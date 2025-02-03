
-- 17_s2g_keword_sankey : 실버→골드 전환 회원의 전환 전/후 카테고리별 소비 변화 데이터를 sankey 다이어그램 형식으로 기록한 테이블입니다.

create table if not exists final_task.s2g_keyword_sankey as

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
        ol.product_name,
        ol.purchase_date::date,
        case 
            when ol.purchase_date < sg.gold_join_date then '실버' -- 골드 가입 이전
            else '골드' -- 골드 가입 이후
        end as purchase_period
    from online_mall.order_log as ol
    join silver_to_gold_members as sg
        on ol.member_code = sg.member_code
    where 
        ol.product_name similar to '%(항암|유기농|미네랄|파이토)%' -- 키워드 필터
),

-- step 3: 키워드별 구매 건수 및 총 사용자 수 집계
keyword_purchase_counts as (
    select 
        purchase_period, -- 골드 가입 전/후 구분
        case 
            when product_name ilike '%항암%' then '항암'
            when product_name ilike '%유기농%' then '유기농'
            when product_name ilike '%미네랄%' then '미네랄'
            when product_name ilike '%파이토%' then '파이토'
        end as keyword_group,
        count(*) as purchase_count, -- 구매 건수
        count(distinct member_code) as unique_users -- 고유 사용자 수
    from ranked_data
    group by purchase_period, keyword_group
),

-- step 4: 총 사용자 수 계산
total_users as (
    select 
        purchase_period,
        count(distinct member_code) as total_users -- 구매 시점별 전체 사용자 수
    from ranked_data
    group by purchase_period
)

-- step 5: 결과 테이블
select 
    kpc.purchase_period, 
    kpc.keyword_group, 
    sum(kpc.purchase_count) as purchase_count, -- 키워드별 구매 건수
    kpc.unique_users, -- 키워드별 고유 사용자 수
    tu.total_users -- 구매 시점별 전체 사용자 수
from keyword_purchase_counts kpc
join total_users tu
    on kpc.purchase_period = tu.purchase_period
group by 
    kpc.purchase_period, 
    kpc.keyword_group, 
    kpc.unique_users, 
    tu.total_users
order by 
    kpc.purchase_period, 
    kpc.keyword_group;
