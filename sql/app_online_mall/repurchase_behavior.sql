create schema if not exists app_online_mall; 

create table if not exists app_online_mall.repurchase_behavior as
select 
	member_code,
	product_code,
	product_name,
	purchase_date::date,
	row_number() over (
	partition by member_code, product_code order by purchase_date
	) as repurchase,
	case
		when unit_price::numeric < 10000 then '저가'
		when unit_price::numeric between 10000 and 49999 then '중저가'
		when unit_price::numeric between 50000 and 99999 then '중가'
		when unit_price::numeric between 100000 and 199999 then '중고가'
		when unit_price::numeric >= 200000 then '고가'
	end as price_group
from online_mall.order_log
order by product_code, purchase_date;