-- distinct
-- 중복된 값을 제거하는데 사용된다.
-- 중복을 제거해서 column에 있는 column값의 종류를 쉽게 파악할 수 있다.

select category_code
from tbl_menu
order by category_code;

-- deistinct select 뒤에 작성한다.
select distinct category_code
from tbl_menu
order by category_code;

-- null 값을 포함하고 있는 컬럼에 distinct 사용
select ref_category_code
from tbl_category;

select distinct ref_category_code
from tbl_category;


-- 다중열(columns) distinct 사용
-- 다중열의 값들이 모두 동일하면 중복된 것으로 판별한다.
select category_code,
       orderable_status
from tbl_menu;

select distinct category_code,
                orderable_status
from tbl_menu;

