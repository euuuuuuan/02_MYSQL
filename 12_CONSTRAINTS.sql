use user_db;
-- constraints
-- 제약조건, 테이블에 데이터가 입력되거나 수정될 때의 규칙을 정의한다.
-- 데이터 무결성을 보장하는데 도움된다.

-- not null
-- null 값을 허용하지 않는 조건
drop table if exists user_notnull; -- 테이블 초기화

create table if not exists user_notnull
(
    user_no   int          not null,
    user_id   varchar(255) not null,
    user_pwd  varchar(255) not null,
    user_name varchar(255) not null,
    gender    varchar(3),
    phone     varchar(255) not null,
    email     varchar(255)
);
-- not null을 지정할 시 insert 에 null 값을 삽입할 때 제한을 둘 수 있다.

insert into user_notnull
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
values (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hon123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com');

-- unique
-- 중복값을 허용하지 않는 제약조건
drop table if exists user_unique; -- 테이블 초기화

create table if not exists user_unique
(
    user_no   int          not null unique,
#     user_no   int          not null,
    user_id   varchar(255) not null,
    user_pwd  varchar(255) not null,
    user_name varchar(255) not null,
    gender    varchar(3),
    phone     varchar(255) not null,
    email     varchar(255)
);

-- 같은 내용을 두번 insert 했을 때,
-- user_no의 unique 키가 중복되면서 오류 발생
-- [23000][1062] Duplicate entry '1' for key 'user_unique.user_no'
insert into user_unique
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
values (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hon123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com');

-- primary key
-- 테이블에서 한 행의 정보를 찾기 위해 사용할 column을 의미
-- not null + unique 제약조건을 의미
-- 한 테이블당 한개만 설정할 수 있다.
-- 한개의 column에만 설정하거나, 여러개의 column을 묶어서 설정 가능. (복합키)

drop table if exists user_primarykey; -- 테이블 초기화

create table if not exists user_primarykey
(
    user_no   int          not null unique,
    -- user_no int primarykey,
    user_id   varchar(255) not null,
    user_pwd  varchar(255) not null,
    user_name varchar(255) not null,
    gender    varchar(3),
    phone     varchar(255) not null,
    email     varchar(255),
    primary key (user_no)
);

select *
from user_primarykey;

insert into user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
values (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hon123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com');

-- 중복값 체크
insert into user_primarykey
    (user_no, user_id, user_pwd, user_name, gender, phone, email)
values (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hon123@gmail.com');


-- foreign key
-- 참조된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- 참조 무결성을 위배하지 않기 위해 사용
-- foreign key 제약조건에 의해 테이블 간의 관계(relationship) 형성됨.
-- 제공되는 값(참조하는 테이블의 값) 이외에는 null 사용 가능

/*
참조 무결성
-> 기본키와 외래키 간의 관계가 항상 유지되도록 보장하는 것을 의미한다.
*/

create table if not exists user_grade
(
    grade_code int          not null unique, # null 값을 허용하지 않고, unique는 중복을 허용하지 않는다는 뜻.
    grade_name varchar(255) not null
) engine = innodb;

insert into user_grade
values (10, '일반회원'),
       (20, '우수회원'),
       (30, '특별회원');

select *
from user_grade;

create table if not exists user_foreignkey1
(
    user_no    int primary key,
    user_id    varchar(255) not null,
    user_pwd   varchar(255) not null,
    user_name  varchar(255) not null,
    gender     varchar(3),
    phone      varchar(255) not null,
    email      varchar(255),
    grade_code int,
    foreign key (grade_code)
        references user_grade (grade_code)
);

insert into user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
values (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hon123@gmail.com', 10),
       (2, 'user02', 'pass02', '유관순', '여', '010-7777-7777', 'yu77@gmail.com', 20);

-- 외래키 제약 조건
-- 참조 컬럼에 없는 값 적용
insert into user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
values (3, 'user03', 'pass03', '이순신', '남', '010-4321-5678', 'lee222@gmail.com', 50);
-- [23000][1452] Cannot add or update a child row:
-- a foreign key constraint fails (`user_db`.`user_foreignkey1`,
-- CONSTRAINT `user_foreignkey1_ibfk_1` FOREIGN KEY (`grade_code`)
-- REFERENCES `user_grade` (`grade_code`))


-- 참조 무결성에 의해 일반적으로는 관계가 맺어진 column을 변경할 수 없다.
-- [23000][1452] Cannot add or update a child row: a foreign key constraint fails
-- (`user_db`.`user_foreignkey1`, CONSTRAINT `user_foreignkey1_ibfk_1`
-- FOREIGN KEY (`grade_code`) REFERENCES `user_grade` (`grade_code`))
update user_foreignkey1
set grade_code = 5
where user_no = 2;


-- check
-- check 제약 조건을 위반시 허용하지 않음

create table if not exists user_check
(
    user_no   int auto_increment primary key,
    user_name varchar(255) not null,
    gender    varchar(255) check (gender in ('남', '여')),
    age       int check (age >= 19) -- 조건
);

insert into user_check
values (null, '홍길동', '남', 25), # auto_increment를 작성했으므로 null로 쓴다.
       (null, '이순신', '남', 35);

select *
from user_check;

-- gender check 제약 조건 확인
-- [HY000][3819] Check constraint 'user_check_chk_1' is violated.
insert into user_check
values (null, '안중근', '남자', 27);


-- age check 제약 조건 확인
-- [HY000][3819] Check constraint 'user_check_chk_2' is violated.
insert into user_check
values (null, '유관순', '여', 17);

-- default
-- column에 null 대신 기본 값 적용
-- column 타입이 date일 시, current_date 만 가능
-- datetime -> current_time, current_timestamp, now() 모두 사용 가능
create table if not exists tbl_country
(
    country_code int auto_increment primary key,
    country_name varchar(255) default '한국',
    population varchar(255) default '0명',
    add_day date default (current_date),
    add_time datetime default (current_time)
);

insert into tbl_country
values (null, default, default, default, default);

select *
from tbl_country;

