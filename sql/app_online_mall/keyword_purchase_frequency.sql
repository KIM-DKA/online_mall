create table if not exists app_online_mall.keyword_purchase_frequency as

select
	purchase.member_code,
	member.age,
	member.age_group,
	member.gender,
	member.state,
	member.city,
	member.household_size,
	member.household_type,
	member.member_type,
    purchase.product_code,
    purchase.product_name,
    purchase.category_large,
    purchase.category_medium,
    purchase.keyword_group,
	purchase.purchase_count,
	purchase.purchase_amount
from 
    (
   
    select
        member_code,
        product_code, 
        product_name, 
        category_large,
        category_medium, 
        case 
            when product_name like '%항암%' then '항암' 
            when product_name like '%유기농%' then '유기농' 
            when product_name like '%미네랄%' then '미네랄' 
            when product_name like '%파이토%' then '파이토' 
        end as keyword_group, 

        sum(amount) as purchase_amount, 
        sum(quantity) as purchase_count
        
    from online_mall.order_log
    where product_name similar to '%(항암|유기농|미네랄|파이토)%'
    group by 
        member_code,
        product_code, 
        product_name, 
        category_large,
        category_medium,
         case 
            when product_name like '%항암%' then '항암' 
            when product_name like '%유기농%' then '유기농' 
            when product_name like '%미네랄%' then '미네랄' 
            when product_name like '%파이토%' then '파이토' 
        end

    ) as purchase

    left join

    (     
    select
        member_code,
        age,
        ((age / 10)::int)::text || '0대' as age_group,
        gender,
        split_part(residence, ' ', 1) as state,
        split_part(residence, ' ', 2) as city,
        household_size,
        household_type,
        member_type
    from
        (
        select 
            member_code,
            extract(year from age(now(), birth_date)) as age,
            gender,
            residence,
            member_type,
            household_size,
            household_type
        from online_mall.member_info
        ) as member_base
    ) as member
    on purchase.member_code = member.member_code;