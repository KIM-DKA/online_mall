-- 10_s2g_repurchase_top20 : 실버→골드 전환 회원의 재구매율이 높은 상위 20개 상품의 재구매 기간, 횟수, 비율을 기록한 테이블입니다.
-- 실버는 4.29 이후로만 볼 것

create table if not exists final_task.s2g_repurchase_top20 as

with ranked_data as (
    select 
        member_code,
        product_code,
        product_name,
        purchase_date::date,
        row_number() over (partition by member_code, product_code order by purchase_date) as repurchase_group,
        lead(purchase_date::date) over (partition by member_code, product_code order by purchase_date) as next_purchase_date,
        unit_price
    from online_mall.order_log 
    where 
        member_code in (
            select 
                member_code 
            from online_mall.member_info 
            where 
                substr(cast(gold_join_date as varchar), 1, 4) not in ('1899') 
                and silver_join_date >= '2024-04-29'
        ) 
        and product_name not ilike '%배송%' 
        and product_name not ilike '%증정%'
),
repurchase_data as (
    select 
        product_code,
        product_name,
        count(distinct member_code) as total_users, -- 모수: 해당 상품을 구매한 총 사용자 수
        count(*) - count(distinct member_code) as repurchase_count, -- 재구매 발생 횟수
        count(*) filter (where repurchase_group > 1) as total_repurchase_purchases, -- 재구매 구매 건수
        avg(next_purchase_date - purchase_date) as avg_repurchase_period, -- 평균 재구매 기간
        count(distinct case when repurchase_group > 1 then member_code end) * 100.0 / count(distinct member_code) as repurchase_rate -- 재구매 비율
    from ranked_data
    where next_purchase_date is not null -- 재구매가 발생한 데이터만 포함
    group by product_code, product_name
),
top20_repurchase as (
    select 
        product_code,
        product_name,
        total_users, -- 모수: 총 사용자 수
        repurchase_count,
        total_repurchase_purchases, -- 재구매 구매 건수
        avg_repurchase_period,
        repurchase_rate
    from repurchase_data
    order by repurchase_count desc
    limit 20
)
select *
from top20_repurchase;
