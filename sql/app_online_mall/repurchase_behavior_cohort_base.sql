create table if not exists app_online_mall.repurchase_behavior_cohort_base as
select
	product_code,
	repurchase_group,
	member_count,
	member_count::numeric / nullif(
		max(case  when repurchase_group = 1 then member_count end) over (partition by product_code), 
		0
	) as repurchase_rate
from
(
select
	repurchase_master.product_code,
	repurchase_master.repurchase_group,
	coalesce(member_count, master_member_count) as member_count
from
(
	select
		product_code,
		master_repurchase_group as repurchase_group,
		master_member_count
	from
	(
		select distinct
			product_code
		from online_mall.order_log
	) as product_master
	cross join
	(
		select
			master_repurchase_group,
			master_member_count
		from 
		(
		    select 1 as master_repurchase_group, 0 as master_member_count
		    union all
		    select 2 as master_repurchase_group, 0 as master_member_count
		    union all
		    select 5 as master_repurchase_group, 0 as master_member_count
		    union all
		    select 10 as master_repurchase_group, 0 as master_member_count
		    union all
		    select 20 as master_repurchase_group, 0 as master_member_count
		    union all
		    select 50 as master_repurchase_group, 0 as master_member_count
		    union all
		    select 100 as master_repurchase_group, 0 as master_member_count
		) as union_subquery
	) as repurchase_base
) as repurchase_master
left join
(
	select
		product_code,
		repurchase_group,
		count(member_code) as member_count
	from
	(
		select
			member_code,
			product_code,
			repurchase,
			case
				when repurchase = 1 then 1
				when repurchase between 2 and 4 then 2
				when repurchase between 5 and 9 then 5
				when repurchase between 10 and 19 then 10
				when repurchase between 20 and 49 then 20
				when repurchase between 50 and 99 then 50
				when repurchase >= 100 then 100
			end as repurchase_group
		from
		(
			select 
				member_code,
				product_code,
				repurchase
			from app_online_mall.repurchase_behavior 
			
		) as base
	) as repurchase_per_member
	group by product_code, repurchase_group
) as grouped_repurchase_per_member
on
	repurchase_master.product_code = grouped_repurchase_per_member.product_code and
	repurchase_master.repurchase_group = grouped_repurchase_per_member.repurchase_group
order by product_code, repurchase_group
) as cohort_base
;
