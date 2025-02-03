-- * 과제 2-2: 시즌별 가장 많이 팔린 품목 Top 20 (seosonal_top_sales)

create table seasonal_sales.seasonal_top_sales as

with season_product as (
	select
		year,
		season,
		product_code,
		product_name,
		sum(amount) as amount
	from seasonal_sales.seasonal_sales_base
	group by
		year, season, product_code, product_name
),
season_rank as (
	select
		season,
		product_code,
		product_name,
		amount,
		row_number() over (partition by season order by amount desc) as amount_rnk
	from season_product
)
select * from season_rank
where amount_rnk <= 20