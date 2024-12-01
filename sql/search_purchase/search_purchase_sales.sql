-- 과제 1-2: 조합원 코드, 날짜, 거래 코드 기준으로 매출 및 수량 합 (search_purchase_sales)

create schema if not exists search_purchase;

create table search_purchase.search_purchase_sales as 

select 
    member_code,
    search_date,
    payment_number, 
    sum(quantity) as tot_quantity,
    sum(amount) as tot_amount
from search_purchase.search_purchase_mapping
where is_search_purchase = 1 
group by 
    member_code,
    search_date,
    payment_number
