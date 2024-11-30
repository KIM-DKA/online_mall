create schema if not exists member_type_top_sales;
create table if not exists member_type_top_sales.new_member_top_sales as
with member_sales_base as (
	select
		ordered.member_code,
		ordered.purchase_date::date,
		ordered.product_code,
		ordered.product_name,
		ordered.category_large,
		ordered.category_medium,
		ordered.quantity,
		ordered.amount,
		
		member.member_type,
		
		to_char(purchase_date, 'Day') as day,
		extract('month' from purchase_date) as month
		
	from online_mall.order_log as ordered
	left join
	(
		select distinct
			member_code,
			member_type
		from online_mall.member_info
	) as member
	on ordered.member_code = member.member_code
),
new_member as (
	
	select
		*,
		row_number() over (partition by member_type order by amount desc) as amount_rnk
	from
	(
		select
			member_type,
			product_code,
			product_name,
			sum(amount) as amount
		from member_sales_base
		where member_type in ('실버', '골드')
		group by member_type, product_code, product_name
	) as grouped
)
select * from new_member
where amount_rnk <= 20

