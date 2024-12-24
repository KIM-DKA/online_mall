-- 24_month_vip_frequency : 상위 1% 고가치 고객의 연령, 성별, 지역, 구매 주기 등의 패턴 분석 데이터를 기록한 테이블입니다.


create table if not exists final_task.month_vip_frequency as

with vip_members as (
    select 
        member_code 
    from 
        vip_member_sales.month_vip_member -- 상위 1% 고가치 멤버
),
vip_purchase_data as (
    select 
        ol.member_code,
        mi.gender,
        floor(extract(year from age(mi.birth_date)) / 10) * 10 as age_group, -- 연령대 그룹화 (10년 단위)
        mi.state,
        ol.purchase_date::date,
        lag(ol.purchase_date::date) over (partition by ol.member_code order by ol.purchase_date) as previous_purchase_date -- 이전 구매일 계산
    from 
        online_mall.order_log as ol
    join 
        online_mall.member_info as mi
    on 
        ol.member_code = mi.member_code
    where 
        ol.member_code in (select member_code from vip_members) -- vip 멤버만 포함
),
vip_analysis as (
    select 
        member_code,
        gender,
        age_group,
        state,
        count(*) as total_purchases, -- 총 구매 횟수
        avg(purchase_date - previous_purchase_date) as avg_purchase_interval -- 평균 구매 주기
    from 
        vip_purchase_data
    where 
        previous_purchase_date is not null -- 이전 구매일이 있는 경우만 포함
    group by 
        member_code, gender, age_group, state
)
select 
    gender,
    age_group,
    state,
    count(member_code) as total_vip_members, -- vip 멤버 수
    avg(total_purchases) as avg_purchases_per_member, -- vip 멤버당 평균 구매 횟수
    avg(avg_purchase_interval) as avg_purchase_interval -- vip 멤버당 평균 구매 주기
from 
    vip_analysis
group by 
    gender, age_group, state
order by 
    gender, age_group, state;
