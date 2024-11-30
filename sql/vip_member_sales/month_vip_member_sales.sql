create schema if not exists vip_member_sales;

create table if not exists month_vip_member_sales as  

with order_base as (
	select 
		member_code,
		extract('year' from purchase_date)::text as year,
		extract('month' from purchase_date)::text as month,
		amount
	from online_mall.order_log
),
date_range as (
	select
		min(purchase_date) as min_date,
		max(purchase_date) as max_date
	from online_mall.order_log
),
all_month as (

	select
		extract('year' from date_series)::text as year,
		extract('month' from date_series)::text as month
	from
	(	
		select
			generate_series(
				(select min_date from date_range)::date,
				(select max_date from date_range)::date,
				'1 month'
			) as date_series
	) as series
),
member_list as (
	select distinct member_code from order_base
),
cartesian as (
	select * from member_list, all_month
),
padded as (
	
	select
		cartesian.member_code,
		cartesian.year,
		cartesian.month,
		
		case
			when order_base.amount is null then 0 else order_base.amount 	
		end as amount
		
	from cartesian
	left join order_base
	on 
		cartesian.member_code = order_base.member_code and
		cartesian.year = order_base.year and
		cartesian.month = order_base.month
)
select
	member_code,
	year,
	month,
	sum(amount) as amount
from padded
group by member_code, year, month