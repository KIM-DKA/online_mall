create schema if not exists vip_member_sales;

create table if not exists vip_member_sales.month_vip_member_sales as  

with vip_member_trends as (
    -- 상위 1% 고객의 월별 평균 구매금액, 구매주기, 총 구매량 계산
    select 
        year,
        month,
        avg(monthly_purchase_amount) as avg_purchase_amount,
        avg(extract(day from (next_purchase_date - purchase_date))) as avg_purchase_interval,
        sum(quantity) as total_quantity
    from (
        select 
            member_code,
            extract(year from purchase_date) as year,
            extract(month from purchase_date) as month,
            amount as monthly_purchase_amount,
            purchase_date,
            lead(purchase_date) over (partition by member_code, extract(year from purchase_date), extract(month from purchase_date) order by purchase_date) as next_purchase_date,
            quantity
        from 
            online_mall.order_log
        where member_code in (select member_code from vip_member_sales.month_vip_member)
    ) as vip_purchases
    group by year, month
),

top_10_products as (
    -- 상위 1% 고객의 월별 구매량이 많은 제품 Top 10
    select 
        year,
        month,
        product_code,
        product_name,
        total_quantity,
        product_rank
    from (
        select 
            extract(year from purchase_date) as year,
            extract(month from purchase_date) as month,
            product_code,
            product_name,
            sum(quantity) as total_quantity,
            row_number() over (partition by extract(year from purchase_date), extract(month from purchase_date) order by sum(quantity) desc) as product_rank
        from 
            online_mall.order_log
        where member_code in (select member_code from vip_member_sales.month_vip_member)
        group by extract(year from purchase_date), extract(month from purchase_date), product_code, product_name
    ) as ranked_products
    where product_rank <= 10
)

select 
    vmt.year,
    vmt.month,
    tp.product_code,
    tp.product_name,
    vmt.avg_purchase_amount,
    vmt.avg_purchase_interval,
    vmt.total_quantity,
    tp.total_quantity as product_quantity,
    tp.product_rank
from 
    vip_member_trends vmt
left join top_10_products tp on vmt.year = tp.year and vmt.month = tp.month
order by 
    vmt.year, vmt.month, tp.product_rank;
