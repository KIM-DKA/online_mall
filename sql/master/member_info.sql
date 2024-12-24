
alter table online_mall.member_info add column join_motivation_aft varchar(255); 
alter table online_mall.member_info add column age integer;
alter table online_mall.member_info add column state varchar(255);
alter table online_mall.member_info add column membership_status varchar(255);


update online_mall.member_info
set 
    join_motivation = split_part(join_motivation, ',', 1); 
    age = date_part('year', age(birth_date)), -- 생년월일로 나이 계산
    state = split_part(state, ' ', 1)
    end;

update online_mall.member_info

set membership_status = case

    -- 실버 → 골드 전환
    when silver_join_date != '1899-12-31' and gold_join_date != '1899-12-31' and premium_join_date = '1899-12-31' then '실버to골드 전환'
    -- 골드 → 프리미엄 전환
    when gold_join_date != '1899-12-31' and premium_join_date != '1899-12-31' then '골드to프리미엄 전환'
    -- 실버 회원
    when silver_join_date != '1899-12-31' and gold_join_date = '1899-12-31' and premium_join_date = '1899-12-31' then '실버'
    -- 골드 회원
    when gold_join_date != '1899-12-31' and premium_join_date = '1899-12-31' then '골드'
    -- 프리미엄 회원
    when premium_join_date != '1899-12-31' then '프리미엄'
    -- 기본값
    else '기타'
end;



update online_mall.member_info
set join_motivation_aft = case
    when join_motivation = '소개' then '소개'
    when join_motivation = '지인소개로' then '소개'
    when join_motivation = '소개,미확인' then '소개'
    when join_motivation = '소개,아토피,질환' then '소개'
    when join_motivation = '소개,물품이좋아서' then '소개'
    when join_motivation = '소개,물품이좋아서,미확인' then '소개'
    when join_motivation = '소개,매장이가까워서' then '소개'
    when join_motivation = '소개,매장이가까워서,미확인' then '소개'
    when join_motivation = '소개,아토피' then '소개'
    when join_motivation = '소개,질환' then '소개'
    when join_motivation = '소개,공급차량을보고' then '소개'
    when join_motivation = '소개,물품이좋아서,매장이가까워서' then '소개'
    when join_motivation = '소개,아토피,질환,공급차량을보고' then '소개'
    when join_motivation = '소개,질환,공급차량을보고' then '소개'
    when join_motivation = '물품이좋아서' then '상품요인'
    when join_motivation = '물품이좋아서,미확인' then '상품요인'
    when join_motivation = '물품이좋아서,매장이가까워서' then '상품요인'
    when join_motivation = '물품이좋아서,매장이가까워서,미확인' then '상품요인'
    when join_motivation = '매장' then '매장요인'
    when join_motivation = '매장이가까워서' then '매장요인'
    when join_motivation = '매장이가까워서,미확인' then '매장요인'
    when join_motivation = '자연드림베이커리' then '매장요인'
    when join_motivation = '공급차량을보고' then '매체노출'
    when join_motivation = '매스컴' then '매체노출'
    when join_motivation = '아토피' then '만성질환'
    when join_motivation = '질환' then '만성질환'
    when join_motivation = '아토피,질환' then '만성질환'
    when join_motivation = '질환,공급차량을보고' then '만성질환'
    when join_motivation = '암 환우 및 가족으로 이벤트 참여' then '암관련 상품/정보'
    when join_motivation = '암경험자로 재발방지 및 항암&힐링식품 구입' then '암관련 상품/정보'
    when join_motivation = '암경험자로 재발방지 및 항암&힐링식품 구입,미확인' then '암관련 상품/정보'
    when join_motivation = '유기농항암식품 등 치유식품 구입' then '암관련 상품/정보'
    when join_motivation = '유기농항암식품 등 치유식품 구입,건강한 자연드림 생활 서비스,건강관련 정보 및 건강 체험 ' then '암관련 상품/정보'
    when join_motivation = '건강한 자연드림 생활 서비스' then '건강정보'
    when join_motivation = '건강관련 정보 및 건강 체험 서비스' then '건강정보'
    when join_motivation = '민우회활동' then '조합원활동'
    when join_motivation = '조합원활동' then '조합원활동'
    when join_motivation = '상품 구입 및 협동조합 활동 참여' then '조합원활동'
    when join_motivation = '농촌살리기' then '농촌살리기'
    when join_motivation = '농촌살리기,물품이좋아서' then '농촌살리기'
    when join_motivation = '기타' then '기타'
    when join_motivation = '미확인' then '미확인'
    else '기타'
end;
