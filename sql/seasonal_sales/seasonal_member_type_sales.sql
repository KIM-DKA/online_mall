-- * 과제 2-4: 시즌별 많이 구매한 회원 등급 (seosonal_member_type_sales)

create table if not exists seasonal_sales.seasonal_member_type_sales as

with seasonal_member as ( 
	select
		base.member_code,
		base.year,
		base.season,
		base.quantity,
		base.amount,
		
		member.member_type
	from seasonal_sales.seasonal_sales_base as base
	
	left join
	(
		select
			member_code,
			member_type
		from online_mall.member_info
	) as member
	on base.member_code = member.member_code
)
select
	year,
	season,
	member_type,
	sum(quantity) as qunatity,
	sum(amount) as amount
from seasonal_member
group by year, season, member_type
order by year, season, amount desc