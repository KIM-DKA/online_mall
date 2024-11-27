create schema if not exists app_online_mall; 

create table if not exists app_online_mall.repurchase_behavior as
select 
	member_code,
	product_code,
	product_name,
	purchase_date::date,
	row_number() over (
	partition by member_code, product_code order by purchase_date
	) as repurchase_group,
	unit_price
from online_mall.order_log
order by product_code, purchase_date;