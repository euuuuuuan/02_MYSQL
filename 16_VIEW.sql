-- view
-- select 쿼리문을 저장한 객체 --> 가상 테이블이라고 불린다.
-- 실질적인 데이터를 물리적으로 저장하고 있지 않음
-- 테이블을 사용하는 것과 같이 동일하게 사용 가능하다.

select *
from tbl_menu;

-- hansik
select *
from tbl_menu
where category_code = 4;

-- view 생성
create view hansik as
select *
from tbl_menu -- 베이스 테이블
where category_code = 4;

select *
from hansik;

-- 베이스 테이블(tbl_menu) 정보가 변경되면 view의 결과도 같이 변경된다.
insert into tbl_menu
values (null, '식혜맛국밥', 5500, 4, 'Y');

-- view를 통해 데이터를 넣기
insert into hansik
values (null, '수정과맛국밥', 5500, 4, 'Y');

-- view를 통한 update
update hansik
set menu_name  = '버터맛국밥',
    menu_price = 5700
where menu_code = 23;

-- veiw를 통한 delete
delete
from hansik
where menu_code = 23;


-- 사용된 subquery에 따라 명령어로 조작이 불가능한 경우
-- 1) 뷰 정의에 포함되지 않은 column을 조작하는 경우
-- 2) 뷰에 포함되지 않는 column 중에 베이스가 되는 테이블 column이 not null 제약조건에 지정된 경우
-- 3) 산술 표현식이 정의된 경우
-- 4) join을 이용해 여러 테이블을 연결한 경우
-- 5) distinct를 포함한 경우
-- 6) group 함수나 group by를 포함한 경우

-- view 삭제
drop view hansik;

-- veiw에 쓰인 subquery 연산 결과도 column으로 사용 가능하다.
create view hansik as
select menu_name                      as '메뉴명',
       truncate(menu_price / 1000, 1) as '가격(천원)',
       category_name                  as '카테고리명'
from tbl_menu a
         join tbl_category b
              on a.category_code = b.category_code
where b.category_name = '한식';

# 'truncate'는 소수점 이하의 숫자를 지정된 자릿수까지 잘라내는 함수입니다.
# 이 함수는 보통 숫자를 다룰 때 사용됩니다. 이 함수는 다음과 같은 두 가지 매개변수를 사용합니다:
#
# 숫자: 잘라내고자 하는 소수를 포함한 숫자입니다.
# 자릿수: 숫자를 잘라낼 때 몇 자리까지 보여줄지 결정합니다.
# 예를 들어, 'truncate(123.456, 1)'는 소수점 이하를 한 자리까지 남기고 나머지를 버립니다.
# 따라서 결과는 '123.4'가 됩니다.
#
# 위의 SQL 구문에서 'truncate(menu_price / 1000, 1)'는
# 'menu_price'를 1000으로 나눈 후, 소수점 이하 한 자리까지 표시하는 것을 의미합니다.
# 이를 통해 메뉴의 가격을 천원 단위로 표시하고 소수점 이하 한 자리까지만 보여줍니다.

select *
from hansik;

-- or replace 옵션
-- 테이블을 drop 하지 않고 기존의 view를 새로운 view로 쉽게 교체가능
create or replace view hansik as
select menu_code     as '메뉴코드',
       menu_name     as '메뉴명',
       category_name as '카테고리명'
from tbl_menu a
         join tbl_category b
              on a.category_code = b.category_code
where b.category_name = '한식';



