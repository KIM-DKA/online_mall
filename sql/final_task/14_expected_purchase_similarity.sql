-- 14_expected_purchase : 회원가입 시 입력한 기대 상품과 실제 구매 데이터를 조인한 상품 리스트
-- pg_trgm 확장 설치

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;

-- 기대 상품과 구매 상품의 유사도를 기반으로 테이블 생성
create table final_task.expected_purchase_similarity as

with split_expected_keywords as (
    select 
        mi.member_code,
        mi.member_type, -- 회원 등급 정보
        unnest(string_to_array(mi.expected_product, ',')) as expected_keyword -- 기대 상품 키워드 분리
    from online_mall.member_info as mi
),
split_purchased_keywords as (
    select 
        ol.member_code,
        unnest(string_to_array(ol.product_name, '*')) as purchased_keyword -- 구매 상품 키워드 분리
    from online_mall.order_log as ol
),
keyword_similarity as (
    select 
        ek.member_code,
        ek.member_type, -- 회원 등급 정보
        ek.expected_keyword,
        pk.purchased_keyword,
        -- Levenshtein 거리를 이용한 유사도 계산 (1 - 거리 / 최대 길이)
        1 - levenshtein(ek.expected_keyword, pk.purchased_keyword)::float / greatest(length(ek.expected_keyword), length(pk.purchased_keyword)) as similarity_score
    from split_expected_keywords as ek
    left join split_purchased_keywords as pk
        on ek.member_code = pk.member_code 
    where ek.expected_keyword not in ('기타')
)
select 
    member_type,
    member_code,
    expected_keyword,
    purchased_keyword,
    similarity_score
from keyword_similarity
