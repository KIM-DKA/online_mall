create schema if not exists consumtion_behavior; 
create table consumtion_behavior.cohort_member as
select 
	member_t.member_code,
	member_status,
	age,
	gender,
	state,
	city,
	join_motivation,
	household_type,
	member_type,
	marketing_consent_online_mall,
	marketing_consent_coop,
	marketing_consent_medical,
	investment,
	prepayment,
	
	total_amount,

	purchase_start as first_purchase,
	purchase_end as last_purchase,
	
	payment_count,
	total_prepayment_used,
	total_mileage_used,
	coupon_used_count,
	coupon_not_used_count,
	
	mobile_use_rate,
	pc_use_rate
	
from
(
	select 
		member_code,
		member_status,
		extract(year from age(now(), birth_date)) as age,
		gender,
		split_part(residence, ' ', 1) as state,
		split_part(residence, ' ', 2) as city,
		join_motivation,
		household_type,
		member_type,
		marketing_consent_online_mall,
		marketing_consent_coop,
		marketing_consent_medical,
		investment,
		prepayment
	from online_mall.member_info
) as member_t

left join
(
	select
		member_code,
		sum(amount) as total_amount
	from online_mall.order_log
	group by member_code
) as order_t

on member_t.member_code = order_t.member_code

left join
(	
	select distinct
		member_code,
		purchase_start,
		purchase_end
	from
	(
		select
			member_code,
			purchase_start,
			purchase_date as purchase_end,
			purchase_end_row
		from
		(
			select distinct
				member_code,
				purchase_date::date,
				min(purchase_date::date) over (partition by member_code order by purchase_date) as purchase_start,
				row_number() over (partition by member_code order by purchase_date desc) as purchase_end_row
			from online_mall.order_log
			order by member_code, purchase_date desc
		) as purchase_distinct
		where purchase_end_row = 1
	) as purchase_start_end	
) as purchase_term 

on member_t.member_code = purchase_term.member_code

left join
(
	select
		payment_aggregate.member_code,
		payment_count,
		total_prepayment_used,
		total_mileage_used,
		coupon_used_count,
		coupon_not_used_count,
		mobile_use_rate,
		pc_use_rate
		
	from
	(
		select distinct
			member_code,
			count(payment_number) as payment_count,
			sum(prepayment_used_amount) as total_prepayment_used,
			sum(mileage_used_amount) as total_mileage_used,
			count(case when coupon_used = 'Y' then 1 end) as coupon_used_count,
			count(case when coupon_used = 'N' then 1 end) as coupon_not_used_count
		from online_mall.payment_log
		group by member_code
	) as payment_aggregate
	
	inner join
	(
		select
			member_code,
			sum(acess_type_num)::numeric / count(member_code) as mobile_use_rate,
			1 - (sum(acess_type_num)::numeric / count(member_code)) as pc_use_rate
		from
		(
			select
				member_code,
				access_type,
				case 
					when access_type = '모바일' then 1
					when access_type = 'PC' then 0
				end as acess_type_num	
			from online_mall.payment_log
		) as payment_base
		group by member_code
		
	) as access_use_rate
	
	on payment_aggregate.member_code = access_use_rate.member_code
	
) as payment

on member_t.member_code = payment.member_code;