create schema if not exists seasonal_sales;
create table if not exists seasonal_sales.seasonal_sales_base as
select
	member_code,
	
    to_char(extract(year from purchase_date), '9999') as year,
    case
        when extract(month from purchase_date) in (3, 4, 5) then 'Spring'
        when extract(month from purchase_date) in (6, 7, 8) then 'Summer'
        when extract(month from purchase_date) in (9, 10, 11) then 'Fall'
        when extract(month from purchase_date) in (12, 1, 2) then 'Winter'
    end as season,

    case 
        when category_large in ('') then 'Non-Classified' else category_large 
    end as category_large,

    product_code,
    product_name,

    quantity,
    amount
from online_mall.order_log
where product_name not like '%배송비%'