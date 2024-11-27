create table if not exists app_online_mall.repurchase_behavior_cohort_base as

select
	member_cnt.product_code,
	member_cnt.product_name,
	member_cnt.repurchase_group,
	member_cnt.member_count,
	member_cnt.member_count::numeric / price.tot_member_cnt as repurchase_rate, 
	price.avg_unit_price::integer

from 
	(
	select 
		product_code,
		product_name,
		repurchase_group, 
		count(member_code) as member_count
	from app_online_mall.repurchase_behavior
	group by 
		product_code,
		product_name,
		repurchase_group 
	) as member_cnt 

	left join 

	(
	select
		product_code,
		count(distinct member_code) as tot_member_cnt,
		avg(unit_price) as avg_unit_price 

	from app_online_mall.repurchase_behavior
	group by 
		product_code
	) as price

	on member_cnt.product_code = price.product_code 


