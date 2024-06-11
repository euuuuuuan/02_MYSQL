-- join
-- 여러개의 분산된 표를 조합해서 하나의 표로 만드는 기능
-- 관계형 데이터베이스에서 가장 중요한 파트이다.

-- 두개 이상 테이블을 관련있는 column을 통해 결합할 때 사용한다.
-- 두개 이상 테이블은 반드시 연관있는 column이 존재해야 하며,
-- 이를 통해 join된 테이블들의 column을 모두 확인할 수 있다.

/*
alias
- SQL의 column 또는 table에 별칭을 만들 수 있다.
*/

select
    -- 별칭에 띄어쓰기나 특수기호가 없다면
    -- 홀따옴표와 as 는 생략이 가능하다.
    a.menu_code as 'code',
    a.menu_name as name,
    a.menu_price   'price'
from tbl_menu a
order by price;


/*
INNER JOIN
- 두 테이블의 교집합을 반환하는 SQL join 유형
- inner join에서 inner 키워드는 생략 가능하다.
- column 명이 같거나 다를 경우 on 으로 서로 연관있는
- column에 대한 조건을 작성하여 join한다.
*/
select a.menu_name,
       b.category_name
from tbl_menu a # 별칭 a
         inner join tbl_category b # 별칭 b
                    on a.category_code = b.category_code
order by b.category_name; # 가나다 순으로 정렬


-- inner join은 교집합을 반환하기 때문에
-- join 순서를 바꾸어도 영향이 없다.
select a.menu_name,
       b.category_name
from tbl_category b
         inner join tbl_menu a
                    on a.category_code = b.category_code
order by b.category_name;


-- using
-- column 명이 같을 경우 using으로 서로 연관되어 있는 column에 대한
-- 조건을 작성하여 join할 수 있다.

select a.menu_name,
       b.category_name
from tbl_menu a
         inner join tbl_category b using (category_code)
order by b.category_name;


/*
left join
- 첫번째(왼쪽) 테이블을 모두 조회하고,
- 왼쪽과 일치하는 오른쪽 테이블을 join 해준다.
*/
select a.menu_name,
       b.category_name
from tbl_menu a
         left join tbl_category b on a.category_code = b.category_code;

/*
right join
- 두번째(오른쪽) 테이블을 모두 조회하고,
- 오른쪽과 일치하는 왼쪽 테이블을 join 해준다.
*/
select a.menu_name,
       b.category_name
from tbl_menu a
         right join tbl_category b on a.category_code = b.category_code;

/*
cross join
- 두 테이블의 모든 가능한 조합을 반환하는 join (모든 경우의 수를 다 구함)
- 카르테시안 곱이라고도 한다.
*/
select a.menu_name,
       b.category_name
from tbl_menu a
         cross join tbl_category b;

/*
self join
- 같은 테이블 내에서 행과 행 사이의 관계를 찾기 위해 사용되는 join
*/
select a.category_name 카테고리,
       b.category_name 대분류
from tbl_category a
         join
     tbl_category b on a.ref_category_code = b.ref_category_code;

