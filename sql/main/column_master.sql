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

;