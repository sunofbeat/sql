-- DDL(Data Definition Language)
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname
from tab; --data dictionary

--과제 drop table 후, 위 문장 실행 결과에서, 쓰레기는 제하고, 조회
select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;
-------------------------------

--DCL(Date Control Language)
-- system user connection으로 변경한다.
create user you identified by you;
grant connect, resource to you;

-- you user connection 으로
select tname
from tab;

create table depts(                         
department_id number(3) constraint depts_deptid_pk primary key, --제약조건
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

--------------------------------


--on delete
drop table gu cascade constraints;
drop table dong cascade constraints;
drop table dong2 cascade constraints;

create table gu (
gu_id number(3) primary key,
gu_name char(9) not null);

create table dong(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete cascade);

create table dong2(
dong_id number(4) primary key,
dong_name varchar2(12) not null,
gu_id number(3) references gu(gu_id) on delete set null);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null); --포린키라 null값이 들어감
insert into dong values(5001, '삼성동', 100);
insert into dong values(5002, '역삼동', 100);
insert into dong values(6001, '상계동', 200);
insert into dong values(6002, '중계동', 200);

insert into dong2
select * from dong;

delete gu
where gu_id = 100;

select * from dong;
select * from dong2;

commit;
-------------------------

--disable fx
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),
aid number(1),
constraint b_aid_fx foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1);
insert into b values(32, 9); --error, parent key not found

--제약조건을 끊음
alter table b disable constraint b_aid_fx;
insert into b values(32, 9);

alter table b enable constraint b_aid_fx; --error, parent keys not found
alter table b enable novalidate constraint b_aid_fx;
--포린키 다시 살림

insert into b values(33, 8); --error parent key not found

-------------------------------------
--sub
drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;
    
desc sub_departments

select * from sub_departments;
-------------------------------------

drop table users cascade constraints;

create table users(
user_id number(3));

desc users

--추가하기
alter table users add(user_name varchar2(10));
desc users

--수정하기
alter table users modify(user_name number(7));
desc users

--칼럼지우기
alter table users drop column user_name;
desc users
-----------------------

--테이블을 읽기전용으로 바꾸기
insert into users values(1);

alter table users read only; --읽기전용으로 바꿈
insert into users values(2); --error update작업이 허용되지않음

alter table users read write; --쓰기전용으로 다시 바꿈
insert into users values(2); --추가 가능

commit;









