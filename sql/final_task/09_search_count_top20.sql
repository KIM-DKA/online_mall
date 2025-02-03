-- 09_search_count_top20 : 1~9월 동안 가장 많이 검색된 상위 20개 키워드의 검색 빈도를 기록한 테이블입니다.
-- 검색어 데이터 사용 : search_purchase.search_purchase_mapping  

create table final_task.search_count_top20 as

with ranked_keywords as (
    select
        searched_keyword_single as keyword, -- 검색된 키워드
        to_char(search_date, 'yyyy-mm') as month, -- 검색 날짜를 월 단위로 변환
        count(*) as search_count, -- 키워드별 검색 횟수
        rank() over (partition by to_char(search_date, 'yyyy-mm') order by count(*) desc) as rank -- 월별 순위
    from 
        search_purchase.search_purchase_mapping
    group by 
        searched_keyword_single, 
        to_char(search_date, 'yyyy-mm')
),
monthly_totals as (
    select
        to_char(search_date, 'yyyy-mm') as month, -- 검색 날짜를 월 단위로 변환
        count(*) as total_search_count, -- 월별 총 검색 건수
        count(distinct member_code) as total_users -- 월별 총 사용자 수 (user_id가 있는 경우)
    from 
        search_purchase.search_purchase_mapping
    group by 
        to_char(search_date, 'yyyy-mm')
)

select
    rk.keyword,
    rk.month,
    rk.search_count,
    rk.rank,
    mt.total_search_count, -- 월별 총 검색 건수
    mt.total_users -- 월별 총 사용자 수
from 
    ranked_keywords as rk
join 
    monthly_totals as mt
on 
    rk.month = mt.month
where 
    rk.rank <= 20 -- 상위 20개 키워드만 포함
order by 
    rk.month, rk.rank; -- 월별로 순위 정렬
