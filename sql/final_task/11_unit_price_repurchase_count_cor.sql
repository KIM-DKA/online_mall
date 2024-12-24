-- 11_unit_price_repurchase_count_cor : 상품 평균 단위 가격과 재구매 횟수 간의 상관관계 데이터를 기록한 테이블입니다.


create table final_task.unit_price_repur_chase_count_cor_grouped as 

with ranked_data as (
    select 
        product_code,
        product_name, -- 물품명 추가
        unit_price,
        row_number() over (partition by member_code, product_code order by purchase_date) as purchase_sequence
    from online_mall.order_log
),
repurchase_data as (
    select 
        product_name, -- 물품명
        avg(unit_price) as avg_unit_price, -- 평균 단위 가격
        sum(case when purchase_sequence > 1 then 1 else 0 end) as total_repurchase_count -- 재구매 횟수
    from ranked_data
    group by product_name
)
select 
    product_name,
    avg_unit_price,
    total_repurchase_count
from repurchase_data;

-- select corr(avg_unit_price, total_repurchase_count) from final_task.unit_pricerepurchase_count_cor_grouped 의 결과가 -0.06 으로 상관관계가 거의 존재하지 않음 -> 파이썬으로 확인 