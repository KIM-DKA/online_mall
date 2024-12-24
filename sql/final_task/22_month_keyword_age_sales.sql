-- 22_month_keyword_age_sales : 연령대별 상품 카테고리 총 구매 금액과 월별 구매 금액을 기록한 테이블입니다.

create table if not exists final_task.month_keyword_age_sales as
with total_members as (
    select 
        count(distinct ol.member_code) as total_member_count
    from 
        online_mall.order_log as ol
    join 
        online_mall.member_info as mi
    on 
        ol.member_code = mi.member_code
    where 
        ol.product_name similar to '%(항암|미네랄|파이토|유기농)%' -- 키워드 필터
        and ol.purchase_date >= '2024-01-01' -- 2024년 데이터만 포함
)
select
    to_char(ol.purchase_date, 'yyyy-mm') as purchase_month, -- 구매 일자를 월 단위로 변환
    floor(extract(year from age(mi.birth_date)) / 10) * 10 as age_group, -- 연령대를 10년 단위로 그룹화
    case
        when ol.product_name similar to '%(항암)%' then '항암'
        when ol.product_name similar to '%(미네랄)%' then '미네랄'
        when ol.product_name similar to '%(파이토)%' then '파이토'
        when ol.product_name similar to '%(유기농)%' then '유기농'
    end as product_category, -- 상품의 카테고리 분류
    sum(ol.amount) as total_purchase_amount, -- 총 구매 금액
    (select total_member_count from total_members) as total_member_count -- 전체 회원 수 추가
from
    online_mall.order_log as ol
join
    online_mall.member_info as mi
    on ol.member_code = mi.member_code -- 회원 데이터와 결합하여 연령대 정보 추가
where
    ol.product_name similar to '%(항암|미네랄|파이토|유기농)%' -- 키워드 필터
    and ol.purchase_date >= '2024-01-01' -- 2024년 데이터만 포함
group by
    purchase_month, age_group, product_category
order by
    purchase_month, age_group, product_category;
