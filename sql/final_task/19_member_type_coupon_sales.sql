-- 19_member_type_coupon_sales : 실버, 골드, 프리미엄 등 회원 등급별 연령, 가입동기별, 지역 등에 따른 쿠폰 사용과 미사용에 대한 쿠폰사용과 미사용에 따른 구매금액 비용 


create table if not exists final_task.member_type_coupon_sales as

select
    mi.member_type,
    mi.gender,
    floor(mi.age / 10) * 10 as age_group, -- 연령을 10 단위로 그룹화
    mi.state,
    mi.join_motivation_aft as join_motivation,
    pl.coupon_used,
    avg(pl.amount) as avg_amount, -- 쿠폰 사용 여부에 따른 평균 구매 금액
    sum(pl.amount) as total_amount, -- 쿠폰 사용 여부에 따른 총 구매 금액
    count(distinct mi.member_code) as total_users -- 쿠폰 사용 여부에 따른 고유 회원 수
from
    online_mall.member_info as mi
left join 
    online_mall.payment_log as pl
on 
    mi.member_code = pl.member_code
group by 
    mi.member_type,
    mi.gender,
    floor(mi.age / 10),
    mi.state,
    mi.join_motivation_aft,
    pl.coupon_used;

