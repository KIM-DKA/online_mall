create schema if not exists consumtion_behavior;

create table consumtion_behavior.popular_search as
select
	search_date,
	searched_keyword_single
from
(
select
	search_date::date,
	regexp_replace(
		regexp_replace(
			unnest(
				string_to_array(searched_keyword, ',')
			), 
		'\(.*?\)', '', 'g'
		),
		'[^A-Z0-9가-힣 ]', '', 'g'
	)
	as searched_keyword_single
from online_mall.search_keyword
) as melted
where searched_keyword_single != ''