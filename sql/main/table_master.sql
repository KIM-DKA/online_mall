drop table if exists postgres.online_mall.table_master;

create table postgres.online_mall.table_master (

    table_name varchar,
    table_description varchar
)
;

insert into table_info (table_name, table_description)
values
    ('order_log', '주문정보'),
    ('payment_log', '결제정보'),
    ('order_keyword', '검색 후 주문된 키워드 정보'),
    ('search_keyword', '검색된 전체 키워드 정보'),
    ('event_info', '이벤트 참가자 정보'),
    ('member_info', '회원 정보'),
;
