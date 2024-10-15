create schema if not exists app_online_mall;
create table if not exists app_online_mall.member_demographic as
select 
	member_code,
	age,
	((age / 10)::int)::text || '0대' as age_group,
	gender,
	household_size,
	case
		when household_size = 1 then '1인'
		when household_size = 2 then '2인'
		when household_size in (3, 4) then '3인 ~ 4인'
		when household_size >= 5 then '5인 이상'
		else null
	end as household_group,
	household_type
from
(
	select 
		member_code,
		extract(year from age(now(), birth_date)) as age,
		gender,
		residence,
		member_type,
		household_size::numeric,
		household_type
	from online_mall.member_info
) as member_base;