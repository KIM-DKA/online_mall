
-- 6. 회원 유형별 (실버, 골드, 프리미엄) 재구매 Top 20 (완료)

create schema if not exists repurchase_member_sales;

create table if not exists repurchase_member_sales.repurchase_member_type_top_sales as 

with member_purchase as (

	select 
		base.member_code,
		base.product_code,
		base.product_name,
		base.repurchase_group,
		row_number() over(
			partition by base.member_code, base.product_code 
			order by base.repurchase_group desc
		) as purchase_count_rank,
		member.member_type
	from app_online_mall.repurchase_behavior as base
	left join
	(
		select distinct
			member_code,
			member_type
		from app_online_mall.purchase_frequency
	) as member
	on
		base.member_code = member.member_code 
),
repurchase as (
	select 
		member_code,
		member_type,
		product_code,
		product_name,
		repurchase_group - 1 as repurchase_count
	from member_purchase
	where 
		purchase_count_rank = 1 and
		repurchase_group > 1
),
repurchase_ranked as (
	
	select
		*,
		row_number() over(
			partition by member_type order by repurchase_count desc
		) as repurchase_rank
	from
	(
		select 
			member_type,
			product_code,
			product_name,
			sum(repurchase_count) as repurchase_count
		from repurchase
		group by member_type, product_code, product_name
	) joined	
)
select * from repurchase_ranked
where repurchase_rank <= 20