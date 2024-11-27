create schema if not exists app_online_mall; 

create table if not exists app_online_mall.purchase_frequency as
select
	purchase.member_code,
	member.age,
	member.age_group,
	member.gender,
	member.state,
	member.city,
	member.household_size,
	member.household_type,
	member.member_type,
	purchase.purchase_count,
	purchase.purchase_amount,
	purchase.avg_purchase_day_differ
from 
(
	-- 멤버별 구매빈도, 금액
	select
		member_code,
		count(purchase_date) as purchase_count,
		sum(amount) as purchase_amount,
		extract(day from (avg(next_purchase_date - purchase_date))) +
		case
			when extract(hour from (avg(next_purchase_date - purchase_date))) >= 12 then 1 else 0
		end as avg_purchase_day_differ
	from
	(
		select
			member_code,
			purchase_date,
			lead(purchase_date) over (partition by member_code order by purchase_date) as next_purchase_date,
			sum(amount) as amount
		from online_mall.order_log
		group by member_code, purchase_date
	) as base
	group by member_code
) as purchase
left join
(
	-- 멤버별 나이, 성별, 주거지, 가구, 회원유형
	select
		member_code,
		age,	
		case 
			when length(age::text) = 1 then '10세 미만'
			else substr(age::text,1,1) || '0대'
		end as age_group,
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