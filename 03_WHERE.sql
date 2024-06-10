-- where
-- 특정 조건에 맞는 레코드(데이터)만을 선택하는데 사용된다.
-- 방법이 다양하다.

-- 같음(=) 연산자를 활용한 WHERE
select menu_name, -- 보여준다.
       menu_price,
       orderable_status
from tbl_menu -- 이곳에 있는
where orderable_status = 'Y';
-- 조건에 부합하는

/*
tbl_menu에 테이블에 있는 column
menu_name, menu_price, orderable_status 를 조회하려고 한다.
단, menu_price가 13000인 데이터만 조회하도록 한다.
*/
select menu_name,
       menu_price,
       orderable_status
from tbl_menu
where menu_price = 13000;

-- select에 담지 않아도, 다른 column의 속성으로 제한할 수 있다.

select menu_name,
       menu_price
from tbl_menu
where orderable_status = 'Y';

-- 같지 않음(!=, <>) 연산자를 사용하는 where
-- columnA != B 에 있는 내용 중 B와 같지 않은 데이터만 보여주기
-- columnB != A 에 있는 내용 중 B와 같지 않은 데이터만 보여주기
select menu_code,
       menu_name,
       orderable_status
from tbl_menu
where
#     orderable_status != 'Y'
orderable_status <> 'Y';


-- 대소 비교 연산자 (>, >=, <, <=)를 사용하는 where
select menu_code,
       menu_name,
       menu_price
from tbl_menu
where menu_price <= 20000;


-- and 연산자와 함께 where절 사용
-- 둘중에 하나라도 false면 false 반환, 둘다 true일 때만 true
/*
true = 1; // false = 0
null : 값이 없다.
*/

-- true 가 되는 조건
select 1 and 1;
-- true and true -> true

-- false 가 되는 조건
select 1 and 0, 0 and 0, 0 and null;
-- false

-- null 이 되는 조건
select 1 and null, null and null;

-- where에서의 and 조건은 두 조건을 모두 충족시키는 것을 조회한다.
select menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where orderable_status = 'Y'
  and -- 주문 가능 여부가 'Y' 이고
    category_code = 10;
-- 카테고리 코드가 10인 데이터만 출력


/*
tbl_menu 테이블에 있는
menu_name, menu_price, category_code, orderable_status를 조회한다.
주문 가능여부가 Y이고, 가격이 10000원 이하인 데이터 조회
*/
select menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where orderable_status = 'Y'
  and menu_price <= 10000;


-- or 연산자와 함께 where 절에 사용
-- true가 되는 조건
select 1 or 1, 0 or 1, 1 or null;

-- false가 되는 조건
select 0 or 0;

-- null이 될 조건
select 0 or null, null or null;

-- where에서의 or 조건
-- 두 조건중 하나라도 충족하면 조회한다.
select menu_name,
       menu_price,
       category_code,
       orderable_status
from tbl_menu
where orderable_status = 'Y'
   or category_code = 12;
-- 코다리 마늘빵이 N이지만 코드는 12이기 때문에 출력된다.

/*
and와 or 연산의 우선순위
- and가 or보다 우선순위가 높다.
- or의 우선순위를 높이고 싶으면 () 소괄호를 사용한다.
*/
select 1 or 0 and 0; -- and 연산자 0과 0이 먼저 실행된다. 두번째 연산은 1 or 0. 따라서 출력은 1
select (1 or 0) and 0; -- 소괄호로 우선순위가 바뀌어, 출력은 0.




