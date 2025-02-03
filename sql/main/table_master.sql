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
    ('marketing_effect', '마케팅 효과분석 기초 테이블'), 
        
    ('search_purchase_mapping', '과제1-1: 구매와 실제 거래 데이터 맵핑 분석'),
    ('search_purchase_sales', '과제1-2: 조합원 코드, 날짜, 거래 코드 기준으로 매출 및 수량 합'),
    ('search_purchase_conversion_sales', '과제1-3: 단어별로 구매 전환 count'),
    ('seosonal_sales_trend', '과제2-1: 시즌별 매출 변화 및 구매 수량 트렌드'),
    ('seosonal_top_sales', '과제2-2: 시즌별 가장 많이 팔린 품목 Top 20'),
    ('seosonal_keyword_top_sales', '과제2-3: 시즌별 많이 팔린 비율 정리 (파이토, 항암, 유기농, 미네랄)'),
    ('seosonal_member_type_sales', '과제2-4: 시즌별 많이 구매한 회원 등급'),
    ('date_member_type_top_sales', '과제3-1: 회원 유형별, 요일별 구매 제품 Top 20'),
    ('month_member_type_top_sales', '과제3-2: 회원 유형별, 월별 구매 제품 Top 20'),
    ('new_member_top_sales', '과제4: 신규 고객 구매 제품 Top 20 분석'),
    ('repurchase_member_top_sales', '과제5: 자주 구매하는 고객의 인기 제품 분석'),
    ('repurchase_member_type_top_sales', '과제6: 회원 유형별 재구매 Top 20 분석'),
    ('month_vip_member_sales', '과제7: 고가치 고객 월별 구매액 및 트렌드 분석'), 

    ('month_keyword_trend', '과제8: 항암, 유기농, 파이토, 미네랄 키워드의 월별 빈도와 매출 변화를 기록한 테이블'),
    ('week_keyword_trend', '과제8: 항암, 유기농, 파이토, 미네랄 키워드의 주별 빈도와 매출 변화를 기록한 테이블'),
    ('search_count_top20', '과제9: 많이 나온 검색어 TOP 20 추출'),
    ('s2g_repurchase_top20', '과제10: 실버에서 골드로 전환 회원 대상 재구매율이 높은 BEST 20 상품에 대해 분석'),
    ('unit_price_repurchase_count_cor', '과제11: 상품 평균 단위 가격과 재구매 횟수의 상관관계 분석'),
    ('repurchase_top20', '과제13: 재구매율이 높은 TOP20 상품에 대해 분석'),
    ('expected_purchase', '과제14: 회원가입 시 입력한 기대 상품과 실제 구매 데이터를 분석한 테이블'),
    ('s2g_repurchase_except_keyword_top20', '과제16: 실버 → 골드로 전환 회원의 카테고리 제외 상품 구매율 및 높은 구매 비중의 상품 분석'),
    ('s2g_keyword_sankey', '과제17: 실버 → 골드 전환 전후의 카테고리별 소비 비율 및 금액 변화 분석'),
    ('member_type_log', '과제18: 회원 등급별(실버, 골드, 프리미엄) 월별 가입/탈퇴 기록'),
    ('member_type_coupon_sales', '과제19: 회원 등급별 쿠폰 사용 평균액 및 비율 분석'),
    ('member_type_state', '과제20: 지역 및 회원 유형별 회원 수 분석'),
    ('month_keyword_state_sales', '과제21: 지역 및 상품 카테고리별 총 구매 금액과 월별 구매 금액'),
    ('month_keyword_age_sales', '과제22: 연령대 및 상품 카테고리별 총 구매 금액과 월별 구매 금액'),
    ('month_keyword_member_type_sales', '과제23: 회원 유형별 상품 카테고리별 총 구매 금액과 월별 구매 금액'),
    ('month_vip_frequency', '과제24: 상위 1% 고가치 고객의 연령, 성별, 지역, 구매 주기 등의 패턴 분석 데이터'),
    ('month_member_type_sales', '과제25: 회원 등급별 월별 구매 금액 및 구매 빈도 변화 추이'),
    ('member_type_coupon_comparison', '과제26: 회원 등급별 쿠폰 사용과 미사용에 따른 구매 금액 비교'),
    ('s2g_member_type_conversion', '과제27: 실버 → 골드 전환 회원의 월별 전환 수 및 비율 분석');
