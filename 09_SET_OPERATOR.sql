-- set operator(연산자)
-- 두개 이상의 select 문의 결과 집합을 결합하는데 사용된다.
-- set 연산자를 통해 결합하는 결과 집합의 column이 동일해야 한다.

-- union
-- 두개 이상의 select 결과문을 결합하여 중복된 레코드를 제거한 후 반환

-- 카테고리 코드가 10인 데이터 조회
select *
from tbl_menu
where category_code = 10


union

-- 메뉴 가격이 9000원보다 작은 경우 조회
select *
from tbl_menu
where menu_price < 9000;

-- union all
-- 두개 이상의 select 문의 결과를 결합하여 중복된 레코드를
-- 제거하지 않고 모두 반환

-- 카테고리 코드가 10인 데이터 조회
select *
from tbl_menu
where category_code = 10


union all

-- 메뉴 가격이 9000원보다 작은 경우 조회
select *
from tbl_menu
where menu_price < 9000;

-- intersect
-- 두 select 문의 결과 중 공통되는 레코드만 반환
-- mysql은 intersect를 제공하지 않지만
-- inner join 또는 in 연산자를 활용해 구현 가능
select a.*
from tbl_menu a
         inner join
     (select *
      from tbl_menu
      where menu_price < 9000) b # join 안에 있는 쿼리를 하나의 테이블로 본다.
     on (a.menu_code = b.menu_code)
where a.category_code = 10;

-- in 연산자 활용
select *
from tbl_menu a
where category_code = 10
  and menu_code
    in (select menu_code
        from tbl_menu
        where menu_price < 9000);


-- minus
-- 첫번째 select 문의 결과에서 두번째 select문의 결과가 포함하는
-- 레코드를 제외하고 반환하는 SQL 연산자
-- mySQL은 minus를 제공하지 않지만 left join을 활용해서 구현가능
select
    a.*
from
    tbl_menu a
left join(select *
          from tbl_menu
          where menu_price < 9000) b
# using (menu_code)
on (a.menu_code = b.menu_code)
where a.category_code = 10
and b.menu_code is null;
-- 테이블 두개 (a와 b)를 코드 10인것과 null인 것을 불러온다.