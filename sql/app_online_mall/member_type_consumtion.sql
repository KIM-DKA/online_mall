create table app_online_mall.member_type_consumtion as
select distinct
	info.member_code,
	member_type as now_member_type,
	member_grade_at_purchase as pay_member_type,
	marketing_consent_online_mall as agree_marketing_mall,
	marketing_consent_coop as agree_marketing_coop,	
	pay.payment_number,
	pay.purchase_date as payment_date,
	log.purchase_date as order_date,
	prepayment_used_amount,
	mileage_used_amount,
	coupon_used,
	pay.amount as pay_amount,
	log.amount as order_amount,
	category_large as order_category	
from
(	
	select
		member_code,
		member_type,
		marketing_consent_online_mall,
		marketing_consent_coop
	from online_mall.member_info
) as info

left join
(
	select
		member_code,
		purchase_date::date,
		payment_number,
		prepayment_used_amount,
		mileage_used_amount,
		coupon_used,
		member_grade_at_purchase,
		amount
	from online_mall.payment_log
		
) as pay
on info.member_code = pay.member_code
left join
(
	select
		member_code,
		purchase_date::date,
		payment_number,
		category_large,
		amount
	from online_mall.order_log
) as log
on
	pay.member_code = log.member_code and
	pay.payment_number = log.payment_number
order by payment_number, payment_date
;