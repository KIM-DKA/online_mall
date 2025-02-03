drop table if exists online_mall.column_master;

create table online_mall.column_master (
    table_name varchar,
    column_name varchar,
    column_description varchar
);

insert into online_mall.column_master (table_name, column_name, column_description)
values
    ('order_log', 'member_code', '조합원코드'),
    ('order_log', 'purchase_date', '구매날짜'),
    ('order_log', 'payment_number', '결제번호'),
    ('order_log', 'product_code', '상품코드'),
    ('order_log', 'product_name', '상품명'),
    ('order_log', 'category_large', '카테고리(대)'),
    ('order_log', 'category_medium', '카테고리(중)'),
    ('order_log', 'unit_price', '단가'),
    ('order_log', 'quantity', '수량'),
    ('order_log', 'amount', '금액'),

    ('payment_log', 'member_code', '조합원코드'),
    ('payment_log', 'purchase_date', '구매날짜'),
    ('payment_log', 'payment_number', '결제번호'),
    ('payment_log', 'delivery_district', '배송지 (시군구)'),
    ('payment_log', 'amount', '금액'),
    ('payment_log', 'prepayment_used_amount', '수매선수금 사용 금액'),
    ('payment_log', 'mileage_used_amount', '마일리지 사용금액'),
    ('payment_log', 'coupon_used', '쿠폰사용여부'),
    ('payment_log', 'member_grade_at_purchase', '구매당시 회원 등급'),
    ('payment_log', 'access_type', '접속유형'),

    ('order_keyword', 'member_code', '조합원코드'),
    ('order_keyword', 'order_date', '검색후 주문 날짜'),
    ('order_keyword', 'ordered_keyword', '주문된 검색키워드'),

    ('search_keyword', 'member_code', '조합원코드'),
    ('search_keyword', 'search_date', '검색 날짜'),
    ('search_keyword', 'searched_keyword', '검색 키워드'),

    ('event_info', 'challenge_name', '챌린지명'),
    ('event_info', 'participants', '챌린지 참가자코드'),

    ('member_info', 'member_code', '조합원코드'),
    ('member_info', 'member_status', '회원상태'),
    ('member_info', 'birth_date', '연령'),
    ('member_info', 'gender', '성별'),
    ('member_info', 'residence', '주거지'),
    ('member_info', 'silver_join_date', '가입일자(실버)'),
    ('member_info', 'gold_join_date', '가입일자(골드)'),
    ('member_info', 'premium_join_date', '가입일자(프리미엄)'),
    ('member_info', 'join_motivation', '가입동기'),
    ('member_info', 'household_size', '가구인원수'),
    ('member_info', 'household_type', '가구유형'),
    ('member_info', 'expected_product', '기대하는 상품'),
    ('member_info', 'member_type', '회원유형'),
    ('member_info', 'marketing_consent_online_mall', '마케팅수신여부(자연드림몰)'),
    ('member_info', 'marketing_consent_coop', '마케팅수신여부(조합)'),
    ('member_info', 'marketing_consent_medical', '마케팅수신여부(의료사협'),
    ('member_info', 'investment', '출자금'),
    ('member_info', 'prepayment', '수매선수금'),
    ('member_info', 'duplicate_membership_medical_and_coop', '중복가입여부(의료사협과생협)'),

    ('purchase_frequency', 'member_code', '조합원코드'),
    ('purchase_frequency', 'age_group', '연령그룹'),
    ('purchase_frequency', 'state', '주소지(시도)'),
    ('purchase_frequency', 'city', '주소지(시군구'),
    ('purchase_frequency', 'household_size', '가구인원수'),
    ('purchase_frequency', 'household_type', '가구유형'),
    ('purchase_frequency', 'member_type', '회원유형'),
    ('purchase_frequency', 'purchase_count', '구매빈도'),
    ('purchase_frequency', 'purchase_amount', '구매금액'),
    ('purchase_frequency', 'avg_purchase_day_diff', '평균 구매빈도'),

    ('repurchase_behavior', 'member_code', '조합원코드'),
    ('repurchase_behavior', 'product_code', '상품코드'),
    ('repurchase_behavior', 'product_name', '상품명'),
    ('repurchase_behavior', 'purchase_date', '구매일자'),
    ('repurchase_behavior', 'repurchase', '재구매횟수'),
    ('repurchase_behavior', 'price_group', '상품단가그룹'),

    ('repurchase_behavior_cohort_base', 'product_code', '상품코드'),
    ('repurchase_behavior_cohort_base', 'repurchase_group', '재구매횟수그룹'),
    ('repurchase_behavior_cohort_base', 'member_count', '재구매그룹별멤버수'),
    ('repurchase_behavior_cohort_base', 'repurchase_rate', '재구매율'),
    ('repurchase_behavior_cohort_base', 'avg_unit_price', '평균가격'),

    ('member_demographic', 'member_code', '조합원코드'),
    ('member_demographic', 'age', '연령'),
    ('member_demographic', 'age_group', '연령그룹'),
    ('member_demographic', 'gender', '성별'),
    ('member_demographic', 'household_size', '가구원수'),
    ('member_demographic', 'household_group', '가구원수그룹'),
    ('member_demographic', 'household_type', '가구유형'),

    ('member_type_consumtion', 'member_code', '조합원코드'),
    ('member_type_consumtion', 'now_member_type', '현재 회원유형'),
    ('member_type_consumtion', 'pay_member_type', '구매당시 회원유형'),
    ('member_type_consumtion', 'agree_marketing_mall', '온라인몰 마케팅동의'),
    ('member_type_consumtion', 'agree_marketing_coop', '조합 마케팅동의'),
    ('member_type_consumtion', 'payment_number', '결제번호'),
    ('member_type_consumtion', 'payment_date', '결제일자'),
    ('member_type_consumtion', 'order_date', '주문일자'),
    ('member_type_consumtion', 'prepayment_used_amount', '수매 선수금 사용금액'),
    ('member_type_consumtion', 'mileage_used_amount', '마일리지 사용금액'),
    ('member_type_consumtion', 'coupon_used', '쿠폰사용여부'),
    ('member_type_consumtion', 'pay_amount', '결제금액'),
    ('member_type_consumtion', 'order_amount', '주문금액'),
    ('member_type_consumtion', 'order_category', '상품카테고리(대)'),

    ('maketing_purchas_bevior', 'member_code', '조합원코드'),
    ('maketing_purchas_bevior', 'member_status', '회원상태'),
    ('maketing_purchas_bevior', 'member_type', '회원유형'),
    ('maketing_purchas_bevior', 'agree_marketing_mall', '온라인몰 마케팅동의'),
    ('maketing_purchas_bevior', 'agree_marketing_coop', '조합 마케팅동의'),
    ('maketing_purchas_bevior', 'agree_marketing_medical', '의료사협 마케팅동의'),

    ('marketing_effect', 'member_code', '조합원코드'),
    ('marketing_effect', 'purchase_date', '구매날짜'),
    ('marketing_effect', 'event_start_date', '이벤트시작날짜'),
    ('marketing_effect', 'event_end_date', '이벤트종료날짜'),
    ('marketing_effect', 'product_code', '상품코드'),
    ('marketing_effect', 'quantity', '수량'),
    ('marketing_effect', 'amount', '금액'),

    ('survival_member', 'member_code', '조합원코드'),
    ('survival_member', 'member_status', '회원상태'),
    ('survival_member', 'age', '연령'),
    ('survival_member', 'gender', '성별'),
    ('survival_member', 'state', '주소지(시도)'),
    ('survival_member', 'city', '주소지(시군구)'),
    ('survival_member', 'join_motivation', '가입동기'),
    ('survival_member', 'household_type', '가구유형'),
    ('survival_member', 'member_type', '회원유형'),
    ('survival_member', 'marketing_consent_online_mall', '마케팅수신여부(자연드림몰)'),
    ('survival_member', 'marketing_consent_coop', '마케팅수신여부(조합)'),
    ('survival_member', 'marketing_consent_medical', '마케팅수신여부(의료사협)'),
    ('survival_member', 'investment', '출자금'),
    ('survival_member', 'prepayment', '수매선수금'),
    ('survival_member', 'total_amount', '총구매액'),
    ('survival_member', 'first_purchase', '첫구매일'),
    ('survival_member', 'last_purchase', '마지막구매일'),
    ('survival_member', 'payment_count', '결제횟수'),
    ('survival_member', 'total_prepayment_used', '수매선수금총사용액'),
    ('survival_member', 'total_mileage_used', '마일리지총사용액'),
    ('survival_member', 'coupon_used_count', '쿠폰사용횟수'),
    ('survival_member', 'coupon_not_used_count', '쿠폰미사용횟수'),
    ('survival_member', 'mobile_use_rate', '모바일접근사용률'),
    ('survival_member', 'pc_use_rate', 'PC접근사용률'),

    ('popular_search', 'search_date', '검색 날짜'),
    ('popular_search', 'searched_keyword_single', '검색 키워드(개별)'),

    ('search_pattern', 'search_date', '검색 날짜'),
    ('search_pattern', 'searched_keyword_multi', '검색 키워드(전체)'),

    ('serach_keyword_purchase', 'member_code', '조합원 코드'),
    ('serach_keyword_purchase', 'search_date', '검색 날짜'),
    ('serach_keyword_purchase', 'searched_keyword', '검색 키워드'),
    ('serach_keyword_purchase', 'order_date', '주문 날짜'),
    ('serach_keyword_purchase', 'ordered_keyword', '주문 키워드'),

    -- search_purchase_sales 테이블

    ('search_purchase_mapping', 'member_code', '조합원코드'),
    ('search_purchase_mapping', 'search_date', '검색 날짜'),
    ('search_purchase_mapping', 'searched_keyword_single', '검색 키워드(개별)'),
    ('search_purchase_mapping', 'payment_number', '결제번호'),
    ('search_purchase_mapping', 'purchase_date', '구매날짜'),
    ('search_purchase_mapping', 'product_name', '상품명'),
    ('search_purchase_mapping', 'quantity', '수량'),
    ('search_purchase_mapping', 'amount', '금액'),
    ('search_purchase_mapping', 'is_search_purchase', '검색어와 구매의 매칭 여부 (1이면 구매로 이어짐)'), 

    -- search_purchase_sales 테이블 
    ('search_purchase_sales', 'member_code', '조합원코드'),
    ('search_purchase_sales', 'search_date', '검색 날짜'),
    ('search_purchase_sales', 'payment_number', '결제번호'),
    ('search_purchase_sales', 'tot_quantity', '총 구매 수량'),
    ('search_purchase_sales', 'tot_amount', '총 구매 금액'), 

    -- search_purchase_conversion_rate 테이블
    ('search_purchase_conversion_rate', 'searched_keyword_single', '검색 키워드(개별)'),
    ('search_purchase_conversion_rate', 'tot_cnt', '전체 검색 건수'),
    ('search_purchase_conversion_rate', 'buy_cnt', '구매 건수'),
    ('search_purchase_conversion_rate', 'conversion_rate', '구매 전환율 (%)'), 

    -- seasonal_sales_trend 테이블
    ('seasonal_sales_trend', 'season', '시즌 정보'),
    ('seasonal_sales_trend', 'quantity', '총 구매 수량'),
    ('seasonal_sales_trend', 'amount', '총 매출 금액'), 

    -- seasonal_top_sales 테이블
    ('seasonal_top_sales', 'season', '시즌 정보'),
    ('seasonal_top_sales', 'product_code', '상품 코드'),
    ('seasonal_top_sales', 'product_name', '상품명'),
    ('seasonal_top_sales', 'amount', '총 매출 금액'),
    ('seasonal_top_sales', 'amount_rnk', '매출 순위'),

    -- seasonal_keyword_top_sales 테이블
    ('seasonal_keyword_top_sales', 'season', '시즌 정보'),
    ('seasonal_keyword_top_sales', 'keyword_group', '키워드 그룹 (예: 파이토, 항암, 유기농, 미네랄)'),
    ('seasonal_keyword_top_sales', 'seasonal_keyword_quantity', '시즌별 키워드 그룹의 판매량 비율 (%)'),
    ('seasonal_keyword_top_sales', 'seasonal_keyword_amount', '시즌별 키워드 그룹의 매출 금액 비율 (%)'),

    -- seasonal_member_type_sales 테이블
    ('seasonal_member_type_sales', 'year', '연도 정보'),
    ('seasonal_member_type_sales', 'season', '시즌 정보'),
    ('seasonal_member_type_sales', 'member_type', '회원 유형 (예: 실버, 골드, 프리미엄)'),
    ('seasonal_member_type_sales', 'qunatity', '총 구매 수량'),
    ('seasonal_member_type_sales', 'amount', '총 매출 금액'),

    -- date_member_type_top_sales 테이블
    ('date_member_type_top_sales', 'member_type', '회원 유형 (예: 실버, 골드, 프리미엄)'),
    ('date_member_type_top_sales', 'day', '구매 요일'),
    ('date_member_type_top_sales', 'product_code', '상품 코드'),
    ('date_member_type_top_sales', 'product_name', '상품명'),
    ('date_member_type_top_sales', 'amount', '총 매출 금액'),
    ('date_member_type_top_sales', 'amount_rnk', '매출 순위 (Top 20 기준)'),

    -- month_member_type_top_sales 테이블
    ('month_member_type_top_sales', 'member_type', '회원 유형 (예: 실버, 골드, 프리미엄)'),
    ('month_member_type_top_sales', 'month', '구매 월'),
    ('month_member_type_top_sales', 'product_code', '상품 코드'),
    ('month_member_type_top_sales', 'product_name', '상품명'),
    ('month_member_type_top_sales', 'amount', '총 매출 금액'),
    ('month_member_type_top_sales', 'amount_rnk', '매출 순위 (Top 20 기준)'),

    -- new_member_top_sales 테이블
    ('new_member_top_sales', 'member_type', '회원 유형 (예: 실버, 골드)'),
    ('new_member_top_sales', 'product_code', '상품 코드'),
    ('new_member_top_sales', 'product_name', '상품명'),
    ('new_member_top_sales', 'amount', '총 매출 금액'),
    ('new_member_top_sales', 'amount_rnk', '매출 순위 (Top 20 기준)'),

    -- repurchase_member_top_sales 테이블
    ('repurchase_member_top_sales', 'member_code', '조합원코드'),
    ('repurchase_member_top_sales', 'product_code', '상품 코드'),
    ('repurchase_member_top_sales', 'product_name', '상품명'),
    ('repurchase_member_top_sales', 'amount', '총 매출 금액'),
    ('repurchase_member_top_sales', 'amount_rank', '매출 순위 (Top 20 기준)'),
    ('repurchase_member_top_sales', 'quantity', '총 구매 수량'),
    ('repurchase_member_top_sales', 'quantity_rank', '구매 수량 순위 (Top 20 기준)'),

    -- repurchase_member_type_top_sales 테이블
    ('repurchase_member_type_top_sales', 'member_type', '회원 유형 (예: 실버, 골드, 프리미엄)'),
    ('repurchase_member_type_top_sales', 'product_code', '상품 코드'),
    ('repurchase_member_type_top_sales', 'product_name', '상품명'),
    ('repurchase_member_type_top_sales', 'repurchase_count', '재구매 횟수'),
    ('repurchase_member_type_top_sales', 'repurchase_rank', '재구매 순위 (Top 20 기준)'),

    -- month_vip_member_sales 테이블

    ('month_vip_member_sales', 'year', '구매 연도'),
    ('month_vip_member_sales', 'month', '구매 월'),
    ('month_vip_member_sales', 'product_code', '구매한 제품의 코드'),
    ('month_vip_member_sales', 'product_name', '구매한 제품의 이름'),
    ('month_vip_member_sales', 'avg_purchase_amount', '상위 1% 고객의 월별 평균 구매 금액'),
    ('month_vip_member_sales', 'avg_purchase_interval', '상위 1% 고객의 월별 평균 구매 주기 (일 단위)'),
    ('month_vip_member_sales', 'total_quantity', '상위 1% 고객의 월별 총 구매량'),
    ('month_vip_member_sales', 'product_quantity', '상위 1% 고객의 월별 각 제품의 총 구매량'),
    ('month_vip_member_sales', 'product_rank', '상위 1% 고객의 월별 각 제품의 구매 순위 (상위 10개 제품)'), 

    -- 과제8번 
    ('month_keyword_trend', 'keyword_group', '상품 키워드 그룹 (항암, 유기농, 미네랄, 파이토)'),
    ('month_keyword_trend', 'month', '구매가 발생한 월 (yyyy-mm)'),
    ('month_keyword_trend', 'purchase_amount', '키워드별 월간 총 구매 금액'),
    ('month_keyword_trend', 'purchase_count', '키워드별 월간 총 구매 건수'),
    ('month_keyword_trend', 'total_members', '키워드별 월간 구매에 참여한 고유 회원 수'), 

    ('week_keyword_trend', 'keyword_group', '상품 키워드 그룹 (항암, 유기농, 미네랄, 파이토)'),
    ('week_keyword_trend', 'month', '구매가 발생한 월 (yyyy-mm)'),
    ('week_keyword_trend', 'week', '구매가 발생한 주차'),
    ('week_keyword_trend', 'purchase_amount', '키워드별 주간 총 구매 금액'),
    ('week_keyword_trend', 'purchase_count', '키워드별 주간 총 구매 건수'),
    ('week_keyword_trend', 'total_members', '키워드별 주간 구매에 참여한 고유 회원 수'), 

    -- 과제 9번 

    ('search_count_top20', 'keyword', '검색된 키워드'),
    ('search_count_top20', 'month', '검색이 발생한 월 (yyyy-mm)'),
    ('search_count_top20', 'search_count', '키워드별 검색 횟수'),
    ('search_count_top20', 'rank', '키워드의 월별 검색 순위 (1~20)'),
    ('search_count_top20', 'total_search_count', '월별 총 검색 건수'),
    ('search_count_top20', 'total_users', '월별 검색에 참여한 총 사용자 수'), 

    -- 과제 10번 

    ('s2g_repurchase_top20', 'product_code', '상품 코드'),
    ('s2g_repurchase_top20', 'product_name', '상품명'),
    ('s2g_repurchase_top20', 'total_users', '해당 상품을 구매한 총 사용자 수'),
    ('s2g_repurchase_top20', 'repurchase_count', '재구매 발생 횟수'),
    ('s2g_repurchase_top20', 'total_repurchase_purchases', '재구매 구매 건수'),
    ('s2g_repurchase_top20', 'avg_repurchase_period', '평균 재구매 기간 (일 기준)'),
    ('s2g_repurchase_top20', 'repurchase_rate', '재구매 비율 (%)'), 

    -- 과제 11번 
    ('unit_price_repur_chase_count_cor_grouped', 'product_name', '상품명'),
    ('unit_price_repur_chase_count_cor_grouped', 'avg_unit_price', '상품의 평균 단위 가격'),
    ('unit_price_repur_chase_count_cor_grouped', 'total_repurchase_count', '해당 상품의 총 재구매 횟수'),  

    -- 과제 13번

    ('repurchase_top20', 'product_code', '상품코드'),
    ('repurchase_top20', 'product_name', '상품명'),
    ('repurchase_top20', 'repurchase_count', '재구매 발생 횟수'),
    ('repurchase_top20', 'total_purchases', '전체 구매 건수 (모수)'),
    ('repurchase_top20', 'avg_repurchase_period', '평균 재구매 기간 (일 단위)'),
    ('repurchase_top20', 'repurchase_rate', '재구매 비율 (재구매 구매자 / 총 구매자)'), 

    -- 과제 14번

    ('expected_purchase_match', 'member_code', '조합원코드'),
    ('expected_purchase_match', 'is_matched', '기대 상품과 구매 상품의 매칭 여부 (1: 매칭, 0: 미매칭)'), 
    ('expected_purchase_match', 'total_user', '기대 상품을 구매상품 구매한 유저수'), 
    ('expected_purchase_match', 'matched_count', '기대 상품을 구매한 건수'), 

    -- 과제 16번

    ('s2g_repurchase_except_keyword_top20', 'purchase_period', '구매 시점 (실버, 골드 전환 전후 구분)'),
    ('s2g_repurchase_except_keyword_top20', 'product_code', '상품 코드'),
    ('s2g_repurchase_except_keyword_top20', 'product_name', '상품명'),
    ('s2g_repurchase_except_keyword_top20', 'total_purchases', '전체 구매 건수 (모수)'),
    ('s2g_repurchase_except_keyword_top20', 'repurchase_count', '재구매 발생 수'),
    ('s2g_repurchase_except_keyword_top20', 'avg_repurchase_period', '평균 재구매 기간'),
    ('s2g_repurchase_except_keyword_top20', 'repurchase_rate', '재구매 비율 (%)'),
    ('s2g_repurchase_except_keyword_top20', 'rank', '구매 상품 순위'), 

    -- 과제 17번

    ('s2g_keyword_sankey', 'purchase_period', '구매 시점 (실버, 골드 전환 전후 구분)'),
    ('s2g_keyword_sankey', 'keyword_group', '상품 키워드 그룹 (항암, 유기농, 미네랄, 파이토)'),
    ('s2g_keyword_sankey', 'purchase_count', '키워드별 구매 건수'),

    -- 과제 18번

    ('member_status_log', 'member_type', '회원 유형 (개인, 단체 등)'),
    ('member_status_log', 'gender', '성별'),
    ('member_status_log', 'age_group', '연령대 (10단위)'),
    ('member_status_log', 'state', '지역 정보'),
    ('member_status_log', 'join_motivation', '가입 동기'),
    ('member_status_log', 'member_status', '회원 상태 (가능, 이용불가)'),
    ('member_status_log', 'member_count', '해당 조건에 해당하는 회원 수'),

    -- 과제 19번

    ('member_type_coupon_sales', 'member_type', '회원 유형'),
    ('member_type_coupon_sales', 'gender', '회원 성별'),
    ('member_type_coupon_sales', 'age_group', '연령 그룹 (10 단위)'),
    ('member_type_coupon_sales', 'state', '지역 정보'),
    ('member_type_coupon_sales', 'join_motivation', '가입 동기'),
    ('member_type_coupon_sales', 'coupon_used', '쿠폰 사용 여부'),
    ('member_type_coupon_sales', 'avg_amount', '쿠폰 사용 여부에 따른 평균 구매 금액'),
    ('member_type_coupon_sales', 'total_amount', '쿠폰 사용 여부에 따른 총 구매 금액'),

    -- 과제 20번

    ('member_type_state', 'join_month', '회원의 가입 월 (yyyy-mm 형식)'),
    ('member_type_state', 'state', '회원의 지역 정보'),
    ('member_type_state', 'member_type', '회원 유형 (실버, 골드, 프리미엄 등)'),
    ('member_type_state', 'member_count', '해당 지역 및 회원 유형별 회원 수'), 

    -- 과제 21번
    
    ('month_keyword_state_sales', 'purchase_month', '구매가 발생한 월 (yyyy-mm 형식)'),
    ('month_keyword_state_sales', 'state', '구매가 발생한 지역 정보'),
    ('month_keyword_state_sales', 'product_category', '상품의 카테고리 (항암, 미네랄, 파이토, 유기농)'),
    ('month_keyword_state_sales', 'total_purchase_amount', '해당 카테고리의 총 구매 금액'),
    ('month_keyword_state_sales', 'total_member_count', '해당 분석의 전체 회원 수'), 

    -- 과제 22번

    ('month_keyword_age_sales', 'purchase_month', '구매가 발생한 월 (yyyy-mm 형식)'),
    ('month_keyword_age_sales', 'age_group', '연령대 (10년 단위로 그룹화, 예: 20, 30, ...)'),
    ('month_keyword_age_sales', 'product_category', '상품의 카테고리 (항암, 미네랄, 파이토, 유기농)'),
    ('month_keyword_age_sales', 'total_purchase_amount', '해당 카테고리의 총 구매 금액'),
    ('month_keyword_age_sales', 'total_member_count', '해당 분석의 전체 회원 수'),

    -- 과제 23번

    ('month_keyword_member_type_sales', 'purchase_month', '구매 월 (yyyy-mm 형식)'),
    ('month_keyword_member_type_sales', 'member_type', '회원 유형 (개인, 단체 등)'),
    ('month_keyword_member_type_sales', 'product_category', '상품 카테고리 (항암, 미네랄, 파이토, 유기농)'),
    ('month_keyword_member_type_sales', 'total_purchase_amount', '상품 카테고리별 총 구매 금액'),
    ('month_keyword_member_type_sales', 'total_member_count', '해당 분석에서 전체 회원 수'),

    -- 과제 24번

    ('month_vip_frequency', 'gender', '성별'),
    ('month_vip_frequency', 'age_group', '연령대 (10년 단위 그룹)'),
    ('month_vip_frequency', 'state', '지역 정보'),
    ('month_vip_frequency', 'total_vip_members', 'VIP 멤버 수'),
    ('month_vip_frequency', 'avg_purchases_per_member', 'VIP 멤버당 평균 구매 횟수'),
    ('month_vip_frequency', 'avg_purchase_interval', 'VIP 멤버당 평균 구매 주기'),

    -- 과제 25번

    ('month_member_type_sales', 'purchase_month', '구매 월 (yyyy-mm 형식)'),
    ('month_member_type_sales', 'member_type', '회원 유형 (개인, 단체 등)'),
    ('month_member_type_sales', 'total_purchase_frequency', '회원 유형별 월별 총 구매 빈도'),
    ('month_member_type_sales', 'total_purchase_amount', '회원 유형별 월별 총 구매 금액'), 

    -- 과제 26번

    ('member_type_coupon_sales', 'member_type', '회원 유형'),
    ('member_type_coupon_sales', 'coupon_used', '쿠폰 사용 여부'),
    ('member_type_coupon_sales', 'avg_amount', '쿠폰 사용 여부에 따른 평균 구매 금액'),
    ('member_type_coupon_sales', 'total_amount', '쿠폰 사용 여부에 따른 총 구매 금액'),
    ('member_type_coupon_sales', 'total_members', '쿠폰 사용 여부에 따른 총 회원 수 (모수)'), 

    -- 과제 27번

    ('s2g_member_type_conversion', 'month', '골드 가입 기준으로 전환이 일어난 월'),
    ('s2g_member_type_conversion', 'tot_count', '골드 가입 회원 총 수'),
    ('s2g_member_type_conversion', 's2g_count', '실버 → 골드로 전환한 회원 수'),
    ('s2g_member_type_conversion', 's2g_rate', '실버 → 골드 전환 비율 (%)');
;