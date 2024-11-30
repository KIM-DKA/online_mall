create table seasonal_sales.seasonal_sales_trend as 
with seasonal_category as (
	
	select
		year,
		season,
		category_large,
		sum(quantity) as quantity,
		sum(amount) as amount
	from seasonal_sales.seasonal_sales_base
	group by year, season, category_large 		
	
)
select
	season,
	sum(quantity) as quantity,
	sum(amount) as amount
from seasonal_category
group by season
