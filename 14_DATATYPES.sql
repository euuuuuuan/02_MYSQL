-- cast functions

-- 명시적 형변환
-- cast ([표현형식] as [데이터 형식] [(길이)]]
-- convert ([표현형식], [데이터 형식] [(길이)]
-- 데이터 형식으로 가능한 것
-- binary, char, date, datetime, decimal, json, signed integer
-- time, unsigned integer

-- tbl_menu 전체 가격 평균
select avg(menu_price)
from tbl_menu;

select cast(avg(menu_price) as signed integer) as '평균 메뉴 가격'
from tbl_menu;

select convert(avg(menu_price), signed integer) as '평균 메뉴 가격'
from tbl_menu;

-- date 형 cast
select cast('2024$06$13' as date);
select cast('2024/5/30' as date);
select cast('2024%6%13' as date);
select cast('2024@1@24' as date);

-- 카테고리별 메뉴 가격 합계 구하기
-- 0000원
select concat(cast(menu_price as char(5)), '원') # 5자리수까지 출력
from tbl_menu;

select category_code, concat(cast(sum(menu_price) as char(5)), '원')
from tbl_menu
group by category_code;
# group by 하지 않을 때 :
# [42000][1140] In aggregated query without GROUP BY,
# expression #1 of SELECT list contains nonaggregated column 'menudb.tbl_menu.category_code';
# this is incompatible with sql_mode=only_full_group_by
# 에러가 발생

# 그룹화
# SQL에서 데이터를 그룹으로 묶어서 특정 기준에 따라 집계하거나 분석하는 것을 말합니다.
# 'GROUP BY' 구문은 이러한 그룹화를 가능하게 합니다.
# 예를 들어, 데이터베이스에서 여러 사용자의 주문 정보가 있다고 가정해 봅시다.
# 각 주문은 사용자 ID, 주문일, 주문 금액 등의 정보를 포함할 수 있습니다.
# 이때 'GROUP BY'를 사용하여 특정 사용자별로 주문 금액을 합산할 수 있습니다.
#
# 간단한 예시로 설명하자면, 다음과 같은 주문 정보가 있다고 가정해 봅시다:
#
# | User ID | Order Date | Order Amount |
# |---------|------------|--------------|
# | 1       | 2024-06-01 | 50           |
# | 2       | 2024-06-01 | 30           |
# | 1       | 2024-06-02 | 20           |
# | 2       | 2024-06-02 | 40           |
# 이 데이터를 'User ID'로 그룹화하여 주문 금액을 합산하려면 다음과 같이 SQL을 작성할 수 있습니다:
#
# SELECT User_ID, SUM(Order_Amount) AS Total_Amount
# FROM Orders
# GROUP BY User_ID;
# 이 질의는 'User_ID' 열을 기준으로 데이터를 그룹화하고, 각 그룹에 대해 'Order_Amount' 값을 합산하여
# 'Total_Amount'이라는 새로운 열을 생성합니다. 결과는 다음과 같습니다:
#
# | User ID | Total Amount |
# |---------|--------------|
# | 1       | 70           |
# | 2       | 70           |
# 그룹화는 데이터를 요약하거나 특정 기준에 따라 분류하여 데이터를 이해하고 분석하는 데 유용합니다.

# 부가설명 :
# 합산값이 각각 70이 되는 이유는 주문 테이블에서 사용자별로 주문 금액을 합산했기 때문입니다.
#
# 주어진 데이터에서 사용자 1은 6월 1일에 50원을 주문하고 6월 2일에 20원을 주문했습니다.
# 사용자 2는 6월 1일에 30원을 주문하고 6월 2일에 40원을 주문했습니다.
#
# 그룹화를 사용하여 사용자별로 주문 금액을 합산하면 다음과 같습니다:
#
# 사용자 1: 50원 + 20원 = 70원
# 사용자 2: 30원 + 40원 = 70원
# 따라서 결과로 얻게 되는 각 사용자의 총 주문 금액은 모두 70원이 됩니다.

-- 암시적 형변환
select '1' + '2'; -- 12가 아니라 정수형으로 연산이 되어 3이 출력
select concat(menu_price, '원')
from tbl_menu;
select 3 > 'MAY'; -- 1 (true) // 문자가 0으로 변환됨
select 5 > '6MAY'; -- 0 (false) // 문자에서 첫번째로 나온 숫자는 정수로 변환됨
select 5 > 'M6AY'; -- 1 (true) // 숫자가 뒤에 나오면 문자로 인식됨
select '2024-6-13'; -- 날짜형으로 바뀔 수 있는 문자 -> date형으로 변환된다.


