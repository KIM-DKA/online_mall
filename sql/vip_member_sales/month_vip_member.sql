
create schema if not exists vip_member_sales;

create table if not exists vip_member_sales.month_vip_member as  

select 
    member_code, 
    purchase_amount,
    rnk 
from 
    (
    select 
        member_code,
        purchase_amount, 
        rank() over (order by purchase_amount desc) as rnk 
    from app_online_mall.purchase_frequency
    ) rnk_tbl 
where rnk <= 10000 


        
