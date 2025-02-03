-- 과제 1-1: 구매와 실제 거래 데이터 맵핑 분석 (search_purchase_mapping) 

create schema if not exists search_purchase;

create table search_purchase.search_purchase_mapping as 

with search_expanded as (
    -- 검색어 데이터를 분리
    select 
        member_code,
        search_date,
        regexp_replace(
            regexp_replace(
                unnest(string_to_array(searched_keyword, ',')), -- set-returning function
                '\(.*?\)', '', 'g'
            ),
            '[^A-Z0-9가-힣 ]', '', 'g'
        ) as searched_keyword_single
    from online_mall.search_keyword
),
prepared_search as (
    -- 빈 검색어를 필터링
    select *
    from search_expanded
    where searched_keyword_single != '' -- 여기서는 단순 문자열 비교 가능
),
prepared_order as (
    -- 구매 데이터를 전처리
    select distinct 
        member_code, 
        purchase_date,
        payment_number,
        product_code,  
        product_name, 
        quantity,
        amount
    from online_mall.order_log
),
matched_data as (
    -- 검색어와 구매 데이터를 포함 관계로 매칭
    select
        s.member_code,
        s.search_date,
        s.searched_keyword_single,
        o.payment_number,
        o.purchase_date,
        o.product_name,
        o.quantity,
        o.amount,
        case 
            when lower(o.product_name) ilike '%' || lower(s.searched_keyword_single) || '%' then 1 else 0 
        end as is_search_purchase 
    from prepared_search s
    left join prepared_order o
    on s.member_code = o.member_code 
       and s.search_date = o.purchase_date
)

select 
    member_code,
    search_date,
    searched_keyword_single,
    payment_number,
    purchase_date,
    product_name,
    quantity,
    amount,
    is_search_purchase -- 1이면 검색어가 구매로 이어짐
from matched_data
