-- 과제 1-3: 단어별로 구매 전환율 높은 상품

create schema if not exists search_purchase;

create table search_purchase.search_purchase_conversion_rate as 

select 
    searched_keyword_single,
    count(*) as tot_cnt, -- 전체 검색 건수
    count(case when is_search_purchase = 1 then 1 else null end) as buy_cnt, -- 구매 건수
    round(
        100.0 * count(case when is_search_purchase = 1 then 1 else null end) / count(*),
        2
    ) as conversion_rate -- 구매 전환율 (%)
from search_purchase.search_purchase_mapping
group by 
    searched_keyword_single
order by 
    conversion_rate desc; -- 전환율 기준으로 정렬 (선택 사항)