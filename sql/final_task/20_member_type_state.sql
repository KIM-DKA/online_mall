-- 20_member_type_state : 지역 및 회원 유형별(실버, 골드, 프리미엄) 회원 수 월별 테이블 

create table if not exists final_task.member_type_state as

select
    to_char(date_trunc('month', greatest(silver_join_date, gold_join_date, premium_join_date)), 'yyyy-mm') as join_month, -- 가장 최근 가입일을 yyyy-mm 형식으로 변환
    state,
    member_type,
    count(member_code) as member_count -- 회원 수 계산
from
    online_mall.member_info
where
    greatest(silver_join_date, gold_join_date, premium_join_date) >= '2024-01-01' -- 2024년 이후 데이터만 포함
    and greatest(silver_join_date, gold_join_date, premium_join_date) != '1899-12-31' -- 1899년 데이터 제외
group by
    join_month, state, member_type
order by
    join_month, state, member_type;
