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
    ('member_info', 'duplicate_membership_medical_and_coop', '중복가입여부(의료사협과생협)')

;