drop table if exists online_mall.table_master;

create table online_mall.table_master (

    table_name varchar,
    table_description varchar
)
;

insert into online_mall.table_master (table_name, table_description)
values
    ('order_log', '주문정보'),
    ('payment_log', '결제정보'),
    ('order_keyword', '검색 후 주문된 키워드 정보'),
    ('search_keyword', '검색된 전체 키워드 정보'),
    ('event_info', '이벤트 참가자 정보'),
    ('member_info', '회원 정보'),

    ('purchase_frequency', '특성별 구매 빈도 및 금액 기초 테이블'),
    ('repurchase_behavior', '재구매 행동 및 패턴 기초 테이블'),
    ('repurchase_behavior_cohort_base', '재구매율 코호트분석용 테이블'),
    ('member_demographic', '인구통계학적 분석 기초 테이블'),
    ('member_type_consumtion', '회원 유형별 소비행동 분석 기초 테이블'),
    ('maketing_purchase_behavior', '마케팅 동의여부 별 구매분석 기초 테이블'),
    ('marketing_effect', '마케팅 효과분석 기초 테이블')


;
