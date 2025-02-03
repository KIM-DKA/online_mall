-- 14_expected_purchase : 회원가입 시 입력한 기대 상품과 실제 구매 데이터를 조인하여 분석한 결과를 기록한 테이블입니다.
-- fuzzystrmatch 확장 설치

create table final_task.expected_purchase as 

select 
    member_type, 
    expected_keyword,
    purchased_keyword,
    count(*) as matched_count, 
    count(distinct member_code) as total_user 
    

from final_task.expected_purchase_similarity
where similarity_score > 0.3
group by 
    member_type, 
    expected_keyword,
    purchased_keyword 

