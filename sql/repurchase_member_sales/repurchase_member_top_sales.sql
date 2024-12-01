-- 5. 자주 구매하는 사람이 많이 구매하는 제품 Top 20 (완료) 


create schema if not exists repurchase_member_sales;

create table if not exists repurchase_member_sales.repurchase_member_top_sales as 

with frequency as (
	select 
		member_code,
		member_type,
		avg_purchase_day_differ,
		purchase_count,
		purchase_amount
	from app_online_mall.purchase_frequency
),
top_customer as (
	select 
		member_code
	from frequency
	where 
		purchase_count >= 50 and
		avg_purchase_day_differ <= 7
),
purchase as (
	select
		member_code,
		product_code,
		product_name,
		sum(quantity) as quantity,
		sum(amount) as amount
	from online_mall.order_log
	where member_code in (select member_code from top_customer)
	group by member_code, product_code, product_name
),
ranked as (
	select
		member_code,
		product_code,
		product_name,
		amount,
		row_number() over (partition by member_code order by amount desc) as amount_rank,
		quantity,
		row_number() over (partition by member_code order by quantity desc) as quantity_rank
	from purchase
)
select * from ranked
where amount_rank <= 20