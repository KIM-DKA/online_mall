-- * 과제 2-1: 시즌별 매출 변화 및 구매 수량 트렌드 (seosonal_sales_trend) 


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
