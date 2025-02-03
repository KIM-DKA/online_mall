-- * 과제 3-2: 회원 유형별, 월별 구매 제품 Top 20 (month_member_type_top_sales) 


create schema if not exists member_type_top_sales;
create table if not exists member_type_top_sales.month_member_type_top_sales as
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
member_month as (
	
	select
		*,
		row_number() over (partition by member_type, month order by month, amount desc) as amount_rnk
	from
	(
		select
			member_type,
			month,
			product_code,
			product_name,
			sum(amount) as amount
		from member_sales_base
		group by member_type, month, product_code, product_name
	) as grouped
)
select * from member_month
where amount_rnk <= 20
