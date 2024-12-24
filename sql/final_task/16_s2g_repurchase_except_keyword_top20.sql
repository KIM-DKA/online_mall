-- 16_s2g_repurchase_except_keyword_top20 : 실버→골드 전환 후 특정 키워드 제외 상품 구매율 및 재구매 상위 20개 상품 데이터 

create table if not exists final_task.s2g_repurchase_except_keyword_top20 as

-- step 1: 실버 → 골드 전환한 회원 추출
with silver_to_gold_members as (
    select 
        member_code,
        silver_join_date,
        gold_join_date
    from online_mall.member_info
    where 
        silver_join_date is not null 
        and silver_join_date >= '2024-04-29' -- 실버 가입일 조건
        and gold_join_date is not null 
        and gold_join_date != '1899-12-31' -- 골드로 전환된 회원만 포함
),

-- step 2: 구매 데이터와 조인하여 골드 가입일 이전과 이후로 나누기
ranked_data as (
    select 
        ol.member_code,
        ol.product_code,
        ol.product_name,
        ol.purchase_date::date,
        case 
            when ol.purchase_date < sg.gold_join_date then '실버' -- 골드 가입 이전
            else '골드' -- 골드 가입 이후
        end as purchase_period,
        row_number() over (partition by ol.member_code, ol.product_code order by ol.purchase_date) as repurchase_group,
        lead(ol.purchase_date::date) over (partition by ol.member_code, ol.product_code order by ol.purchase_date) as next_purchase_date,
        ol.unit_price
    from online_mall.order_log as ol
    join silver_to_gold_members as sg
        on ol.member_code = sg.member_code
    where 
        ol.product_name not ilike '%배송%' 
        and ol.product_name not ilike '%증정%' 
        and ol.product_name not similar to '%(항암|유기농|미네랄|파이토)%'
),

-- step 3: 재구매 데이터 집계
repurchase_data as (
    select 
        purchase_period, -- 골드 가입 전/후 구분
        product_code,
        product_name,
        count(distinct member_code) as total_buyers, -- 해당 상품을 구매한 총 사용자 수
        (select count(distinct member_code) 
         from ranked_data 
         where ranked_data.purchase_period = rd.purchase_period) as total_users, -- 구매 시점(실버/골드)별 전체 사용자 수
        count(*) as total_purchases, -- 전체 구매 건수 (모수)
        count(*) - count(distinct member_code) as repurchase_count, -- 재구매 발생 수
        avg(next_purchase_date - purchase_date) as avg_repurchase_period, -- 평균 재구매 기간
        count(distinct case when repurchase_group > 1 then member_code end) * 100.0 / count(distinct member_code) as repurchase_rate -- 재구매 비율
    from ranked_data as rd
    where next_purchase_date is not null -- 재구매가 발생한 데이터만 포함
    group by purchase_period, product_code, product_name
),

-- step 4: top20 상품 추출
top20_repurchase as (
    select 
        purchase_period,
        product_code,
        product_name,
        total_users, -- 구매 시점별 전체 사용자 수 추가
        total_buyers, -- 해당 상품을 구매한 사용자 수
        total_purchases, -- 전체 구매 건수 (모수)
        repurchase_count,
        avg_repurchase_period,
        repurchase_rate,
        row_number() over (partition by purchase_period order by repurchase_count desc) as rank
    from repurchase_data
    where repurchase_count > 0 -- 재구매가 있는 상품만 포함
)

select *
from top20_repurchase
where rank <= 20;
