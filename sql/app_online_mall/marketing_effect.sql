create table app_online_mall.marketing_effect as
select
	log.member_code,
	log.purchase_date,
	event.event_start_date,
	event.event_end_date,
	product_code,
	quantity,
	amount
from
(
	select
		member_code,
		purchase_date::date,
		product_code,
		quantity,
		amount
	from online_mall.order_log
) as log
left join
(
	select 
		participants,
		split_part(challenge_name, '(', 1) as challenge_name,
		split_part(split_part(challenge_name, '(', 2), ' ~ ', 1)::date as event_start_date,
		split_part(split_part(challenge_name, ' ~ ', 2), ')', 1)::date as event_end_date
	from online_mall.event_info
) as event
on log.member_code = event.participants
where event.participants is not null;