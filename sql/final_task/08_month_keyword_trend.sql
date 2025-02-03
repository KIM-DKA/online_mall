-- 08_month_keyword_trend : 항암, 유기농, 파이토, 미네랄 키워드의 월별 빈도와 매출 변화를 기록한 테이블입니다.

create table final_task.month_keyword_trend as 

select
    case 
        when product_name like '%항암%' then '항암' 
        when product_name like '%유기농%' then '유기농' 
        when product_name like '%미네랄%' then '미네랄' 
        when product_name like '%파이토%' then '파이토' 
    end as keyword_group, 

    substr(cast(purchase_date as varchar), 1, 7) as month, 
    sum(amount) as purchase_amount, 
    sum(quantity) as purchase_count,
    count(distinct member_code) as total_members -- 구매에 참여한 고유 회원 수 추가

from online_mall.order_log
where product_name similar to '%(항암|유기농|미네랄|파이토)%'
group by 
    substr(cast(purchase_date as varchar), 1, 7),
    case 
        when product_name like '%항암%' then '항암' 
        when product_name like '%유기농%' then '유기농' 
        when product_name like '%미네랄%' then '미네랄' 
        when product_name like '%파이토%' then '파이토' 
    end
order by 
    month, keyword_group;
