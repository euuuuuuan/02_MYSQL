-- ORDER BY
-- select 문과 함께 사용하며 결과 집합을
-- 특정한 열이나 값 정렬에 사용된다.

select menu_code,
       menu_name,
       menu_price,
       orderable_status
from tbl_menu
order by
#         menu_price asc; -- asd(ascending) : 오름차순 정렬
-- 가격순으로 오름차순 되는 결과 출력을 확인할 수 있다.
#         menu_price desc; -- desc(descending) : 내림차순 정렬
        menu_price; -- 오름차순 정렬 (default)
#         menu_name; -- 사전적 오름차순 정렬 (default)
# orderable_status;

-- column에 따라 여러번 정렬할 수 있다.
-- 메뉴 price를 기준으로 내림차순 정렬을 하고,
-- 같은 가격이 있다면, menu_name에 따라 오름차순 정렬
select
    menu_code,
    menu_name,
    menu_price
from
    tbl_menu
order by
    menu_price desc,
    menu_name;

-- column을 연산해서, 연산 결과와 함께 정렬을 할 수 있다.
-- order by 절을 이용해서 연산결과와 함께 정렬
select
    menu_code,
    menu_price,
    menu_code * menu_price as multiple
from
    tbl_menu
order by
    menu_code * menu_price desc;

/*
field('비교할 값', '비교대상', '비교대상', ...)
-- 첫번째 인자가 두번째 인자 이후의 값들과 비교해서 일치하면
-- 해당 위치의 값을 보여준다.
*/
select field('A', 'A', 'B', 'C'); -- 첫번째 A와 동일한 두번째 A의 위치값인 '1'이 출력된다.
select field('B', 'A', 'B', 'C'); -- '2'

-- 데이터 베이스에 들어있는 데이터를 비교할 수 있다.
select field(orderable_status, 'N', 'Y') -- 첫째 N, 둘째 Y
from
    tbl_menu;
--  N 은 '1'(첫째 선언된 것), Y 는 '2'(둘째 선언된 것

-- order by, field 같이 써서 사용하기
select menu_name,
       orderable_status
from tbl_menu
order by field(orderable_status, 'N', 'Y');


-- null 값이 있는 column에 대한 정렬
select category_name,
       category_code,
       ref_category_code
from tbl_category
order by ref_category_code; -- 오른차순 정렬했을 때 null이 상단으로 온다.

-- null 값 위치에 따라 정렬할 때,
-- asc : 오름차순 정렬시 null이 마지막으로 위치된다. (default)
-- desc : 내림차순 정렬시 null이 첫번부터 위치된다.
select category_code,
       category_name,
       ref_category_code
from tbl_category
order by ref_category_code is null asc;

-- 한개를 조회해서 두번 정렬 할 때
select category_code,
       category_name,
       ref_category_code
from tbl_category
order by ref_category_code is null desc, -- null 값의 위치를 정하고
         ref_category_code asc; -- ref_category_code를 오름차순으로 정렬

