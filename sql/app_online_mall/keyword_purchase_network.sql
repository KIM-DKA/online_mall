

create table if not exists app_online_mall.keyword_purchase_network as


with ranked_data as (
    select 
        member_code, 
        keyword_group,
        sum(purchase_amount) as purchase_amount,
        row_number() over (partition by keyword_group order by sum(purchase_amount) desc) as rnk
    from app_online_mall.keyword_purchase_frequency 
    group by member_code, keyword_group
)


select
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium, 
    '항암top100' as keyword_rnk,
    sum(amount) as purchase_amount, 
    sum(quantity) as purchase_count
    
from online_mall.order_log
where 
    member_code in (select distinct member_code from ranked_data where keyword_group in ('항암') and rnk <= 100) and 
    product_name not similar to '%(항암|유기농|미네랄|파이토)%'

group by 
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium        
    
union all 

select
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium, 
    '미네랄top100' as keyword_rnk,
    sum(amount) as purchase_amount, 
    sum(quantity) as purchase_count
    
from online_mall.order_log
where 
    member_code in (select distinct member_code from ranked_data where keyword_group in ('미네랄') and rnk <= 100) and 
    product_name not similar to '%(항암|유기농|미네랄|파이토)%'

group by 
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium        

union all 

select
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium, 
    '유기농top100' as keyword_rnk,
    sum(amount) as purchase_amount, 
    sum(quantity) as purchase_count
    
from online_mall.order_log
where 
    member_code in (select distinct member_code from ranked_data where keyword_group in ('유기농') and rnk <= 100) and 
    product_name not similar to '%(항암|유기농|미네랄|파이토)%'

group by 
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium        


union all 

select
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium, 
    '파이토top100' as keyword_rnk,
    sum(amount) as purchase_amount, 
    sum(quantity) as purchase_count
    
from online_mall.order_log
where 
    member_code in (select distinct member_code from ranked_data where keyword_group in ('파이토') and rnk <= 100) and 
    product_name not similar to '%(항암|유기농|미네랄|파이토)%'

group by 
    member_code,
    product_code, 
    product_name, 
    category_large,
    category_medium        