create table if not exists app_online_mall.repurchase_behavior_cohort_base as
select
	product_code,
	repurchase_group,
	member_count,
	member_count::numeric / nullif(max(case  when repurchase_group = 1 then member_count end) over (partition by product_code), 0) as repurchase_rate

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


