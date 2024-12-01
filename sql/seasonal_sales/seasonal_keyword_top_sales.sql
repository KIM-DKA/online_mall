-- * 과제 2-3: 시즌별 많이 팔린 비율 정리 (파이토, 항암, 유기농, 미네랄) (seosonal_keyword_top_sales)

create table if not exists seasonal_sales.seasonal_keyword_top_sales as

with seasonal_keyword as (
	select
	    base.year,
	    base.season,
	    keyword.keyword_group,
	    sum(base.quantity) as quantity,
	    sum(base.amount) as amount
	from seasonal_sales.seasonal_sales_base as base
	inner join
	(
	    select distinct
	        product_code,
	        keyword_group
	    from app_online_mall.keyword_purchase_frequency
	) as keyword
	on base.product_code = keyword.product_code
	group by base.year, base.season, keyword.keyword_group
),
seasonal_total as (
	select
		year,
		season,
		keyword_group,
		
		quantity,
		sum(quantity) over (partition by season) as season_quantity,
		
		amount,
		sum(amount) over (partition by season) as season_amount
	from seasonal_keyword
)
select
	season,
	keyword_group,
	(quantity / season_quantity) * 100 as seasonal_keyword_quantity,
	(amount / season_amount) * 100 as seasonal_keyword_amount
from seasonal_total