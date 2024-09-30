create schema if not exists app_online_mall; 
create table if not exists app_online_mall.purchase_frequency as
select
	purchase.member_code,
	member.age_group,
	member.state,
	member.city,
	member.household_size,
	member.household_type,
	member.member_type,
	purchase.purchase_count,
	purchase.purchase_amount
from 
(
	-- 멤버별 구매빈도, 금액
	select 
		member_code,
		count(purchase_date) as purchase_count,
		sum(amount) as purchase_amount
	from online_mall.order_log
	group by member_code
) as purchase
left join
(
	-- 멤버별 나이, 성별, 주거지, 가구, 회원유형
	select
		member_code,
		age,
		((age / 10)::int)::text || '0대' as age_group,
		gender,
		split_part(residence, ' ', 1) as state,
		split_part(residence, ' ', 2) as city,
		household_size,
		household_type,
		member_type
	from
	(
		select 
			member_code,
			extract(year from age(now(), birth_date)) as age,
			gender,
			residence,
			member_type,
			household_size,
			household_type
		from online_mall.member_info
	) as member_base
) as member
on purchase.member_code = member.member_code;