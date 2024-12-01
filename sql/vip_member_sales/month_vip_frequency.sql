-- 월별로 구매금액, 구매빈도, 구매주기 등을 추출

create schema if not exists vip_member_sales;

create table if not exists vip_member_sales.month_vip_frequency as  

select
    member_code,
    count(purchase_date) as purchase_count,
    sum(amount) as purchase_amount,
    extract(day from (avg(next_purchase_date - purchase_date))) +
    case
        when extract(hour from (avg(next_purchase_date - purchase_date))) >= 12 then 1 else 0
    end as avg_purchase_day_differ
from
(
    select
        member_code,
        purchase_date,
        lead(purchase_date) over (partition by member_code order by purchase_date) as next_purchase_date,
        sum(amount) as amount
    from online_mall.order_log
    where member_code in (select member_code from vip_member_sales.month_vip_member)
    group by member_code, purchase_date
) as base
group by member_code