create schema if not exists consumtion_behavior;

create table consumtion_behavior.search_pattern as
select
	search_date,
	replace(
		string_agg(searched_keyword_multi, ','), ',', ' '
	)  as searched_keyword_multi
from
(
	select 
		search_date::date,
		
		regexp_replace(
	            regexp_replace(
	            	searched_keyword, '\([^)]*\)', '', 'g'
	            ), '[^,A-Z가-힣\s]', '', 'g'
	    ) as searched_keyword_multi
	from online_mall.search_keyword
) as base
group by search_date
order by search_date