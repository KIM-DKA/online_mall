-- 26_member_type_coupon_comparison : 회원 등급별 쿠폰 사용과 미사용에 따른 구매 금액 비교 

create table if not exists final_task.member_type_coupon_sales as

select
    mi.member_type, -- 회원 유형
    pl.coupon_used, -- 쿠폰 사용 여부
    avg(pl.amount) as avg_amount, -- 쿠폰 사용 여부에 따른 평균 구매 금액
    sum(pl.amount) as total_amount, -- 쿠폰 사용 여부에 따른 총 구매 금액
    count(distinct mi.member_code) as total_members -- 쿠폰 사용 여부에 따른 회원 수 (모수)
from
    online_mall.member_info as mi
left join 
    online_mall.payment_log as pl
on 
    mi.member_code = pl.member_code
group by 
    mi.member_type, 
    pl.coupon_used
order by 
    mi.member_type, 
    pl.coupon_used;
