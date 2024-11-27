select distinct
	coalesce(searched.member_code, ordered.member_code) as member_code,
	search_date,
	searched_keyword_single as searched_keyword,
	order_date,
	ordered_keyword_single as ordered_keyword
from
(
	select
		member_code,
		search_date,
		searched_keyword_single
	from
	(
		select
			member_code,
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
	
) as searched 

full outer join
(
	select
		member_code,
		order_date,
		ordered_keyword_single
	from
	(
		select
			member_code,
			order_date::date,
			regexp_replace(
				regexp_replace(
					unnest(
						string_to_array(ordered_keyword, ',')
					), 
				'\(.*?\)', '', 'g'
				),
				'[^A-Z0-9가-힣 ]', '', 'g'
			)
			as ordered_keyword_single
		from online_mall.order_keyword
	) as melted
	where ordered_keyword_single != ''
	
) as ordered

on
	searched.member_code = ordered.member_code and
	searched_keyword_single = ordered_keyword_single and
	search_date = order_date
	
order by member_code, search_date