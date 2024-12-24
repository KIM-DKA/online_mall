-- 25_month_member_type_sales : 회원 등급별 월별 구매 금액과 구매 빈도 데이터를 기록한 테이블입니다.

create table if not exists final_task.month_member_type_sales as

with member_purchase_data as (
    select 
        mi.member_code,
        to_char(ol.purchase_date, 'yyyy-mm') as purchase_month, -- 구매 일자를 월 단위로 변환
        mi.member_type, -- 회원 유형 (개인, 단체 등)
        count(ol.purchase_date) as purchase_frequency, -- 구매 빈도
        sum(ol.amount) as total_purchase_amount -- 총 구매 금액
    from 
        online_mall.order_log as ol
    join 
        online_mall.member_info as mi
    on 
        ol.member_code = mi.member_code -- 회원 데이터와 결합
    where 
        ol.purchase_date >= '2024-01-01' -- 2024년 데이터만 포함
    group by 
        mi.member_code, to_char(ol.purchase_date, 'yyyy-mm'), mi.member_type
),
member_type_summary as (
    select
        purchase_month,
        member_type,
        sum(purchase_frequency) as total_purchase_frequency, -- 유형별 총 구매 빈도
        sum(total_purchase_amount) as total_purchase_amount, -- 유형별 총 구매 금액
        count(distinct member_code) as unique_users -- 유형별 고유 사용자 수
    from 
        member_purchase_data
    group by 
        purchase_month, member_type
)
select 
    purchase_month,
    member_type,
    total_purchase_frequency,
    total_purchase_amount,
    unique_users -- 고유 사용자 수 추가
from 
    member_type_summary
order by 
    purchase_month, member_type;
