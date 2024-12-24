-- 27_s2g_member_type_conversion : 실버→골드 회원 전환 추이와 월별 전환 수 및 비율을 기록한 테이블입니다.

create table if not exists final_task.s2g_member_type_conversion as

select 
    gold_join_month as month, -- 골드 가입 월
    silver_join_month, -- 실버 가입 월
    count(*) as tot_count, -- 전체 회원 수
    count(case when membership_status = '실버to골드 전환' then 1 else null end) as s2g_count, -- 실버 → 골드 전환 회원 수
    round(
        count(case when membership_status = '실버to골드 전환' then 1 else null end)::numeric 
        / count(*) * 100, 2
    ) as s2g_rate, -- 실버 → 골드 전환 비율 (%)
    join_date, -- 가입 일자별
    floor(extract(year from age(birth_date)) / 10) * 10 as age_group, -- 연령대 (10년 단위)
    join_motivation, -- 가입 동기
    state -- 지역
from
    (
    select 
        member_code, 
        member_type, 
        to_char(silver_join_date, 'yyyy-mm') as silver_join_month, -- 실버 가입 월
        case 
            when to_char(gold_join_date, 'yyyy-mm') = '1899-12' then to_char(silver_join_date, 'yyyy-mm')
            else to_char(gold_join_date, 'yyyy-mm') 
        end as gold_join_month, -- 골드 가입 월
        silver_join_date as join_date, -- 가입 일자
        birth_date, -- 회원 생일
        join_motivation_aft as join_motivation, -- 가입 동기
        state, -- 지역 정보
        membership_status
    from online_mall.member_info 
    where 
        silver_join_date >= '2024-04-29' 
        and membership_status in ('실버', '실버to골드 전환')
    ) s2g
group by 
    gold_join_month, 
    silver_join_month, 
    join_date, 
    age_group, 
    join_motivation,
    state
order by 
    gold_join_month, silver_join_month, join_date, age_group, join_motivation_aft, state;
