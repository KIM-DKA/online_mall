-- 08_week_keyword_trend : 항암, 유기농, 파이토, 미네랄 키워드의 주별 빈도와 매출 변화를 기록한 테이블입니다.

create table final_task.week_keyword_trend as 

select
    case 
        when product_name like '%항암%' then '항암' 
        when product_name like '%유기농%' then '유기농' 
        when product_name like '%미네랄%' then '미네랄' 
        when product_name like '%파이토%' then '파이토' 
    end as keyword_group, 

    substr(cast(purchase_date as varchar), 1, 7) as month, -- 월 추가
    extract(week from purchase_date) as week, -- 주차 추가
    sum(amount) as purchase_amount, -- 구매 금액 합계
    sum(quantity) as purchase_count, -- 구매 건수 합계
    count(distinct member_code) as total_members -- 구매에 참여한 고유 회원 수

from 
    online_mall.order_log
where 
    product_name similar to '%(항암|유기농|미네랄|파이토)%' -- 키워드 필터
group by 
    substr(cast(purchase_date as varchar), 1, 7),
    extract(week from purchase_date),
    case 
        when product_name like '%항암%' then '항암' 
        when product_name like '%유기농%' then '유기농' 
        when product_name like '%미네랄%' then '미네랄' 
        when product_name like '%파이토%' then '파이토' 
    end
order by 
    month, week, keyword_group;
