/*
SQL이란?
Structrued Query Language의 약자로 직역하면 구조화된 질의 언어이다.
단순히 질의만 하는 것이 아니라,
DML, DDL, DCL, TCL 등 이러한 데이터베이스를 조작 및 조회하기 위해
사용하는 표준 언어이다.
*/

-- SELECT
-- mysql의 가장 기본적인 명령어로 특정 테이블에서 원하는 데이터를 조회할 수 있다.

select -- 조회해줘
       menu_name -- 어떤 column을
from tbl_menu;
-- 어느 테이블에서?

-- 여러 column을 한번에 조회할 수 있다.
select menu_code,
       menu_name,
       menu_price
from tbl_menu;

-- 모든 column을 직접 써서 조회하기
-- SELECT를 사용해서 tbl_menu에 있는 모든 column을 조회해 보세요
select *
from tbl_menu;

/*
select 단독 활용
- from 없이 단독으로 사용 가능
- 단독으로 사용할 때는 단순한 테스트 용도로 사용된다.
*/
select(5 + 5);
select(5 - 5);
select(5 * 5);
select(5 / 5);
select(5 % 5);

-- mysql 내장 함수도 사용 가능
select now(); -- 현재 시간 출력
select concat('bear', '안녕', 'ohgiraffers');
-- 문자열 합치기

-- column에 별칭을 사용할 수 있다.
select concat('박', ' ', '태근') as name;
select concat('박', ' ', '태근') as 'Full name'; -- 별칭에 공백 사용시 작은 따옴표가 붙어야 한다.

