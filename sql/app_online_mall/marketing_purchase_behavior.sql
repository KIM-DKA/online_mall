create table app_online_mall.marketing_purchase_behavior as
select
	info.member_code,
	member_status,
	member_type,
	agree_marketing_mall,
	agree_marketing_coop,
	agree_marketing_medical,
	case
		when log.member_code is not null then 'Y'
		else 'N'
	end as purchased	
from
(
select distinct
	member_code,
	member_status,
	member_type,	
	case
		when marketing_consent_online_mall in ('Y', 'N', 'Z')
		then marketing_consent_online_mall
		else null
	end as agree_marketing_mall,
	case
		when marketing_consent_coop in ('Y', 'N')
		then marketing_consent_coop
		else null
	end as agree_marketing_coop,
	case
		when marketing_consent_medical in ('Y', 'N')
		then marketing_consent_medical
		else null
	end as agree_marketing_medical
from online_mall.member_info
) as info
left join
(
select distinct 
	member_code 
from online_mall.order_log
) as log
on info.member_code = log.member_code;