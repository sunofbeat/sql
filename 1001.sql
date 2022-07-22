--DML

drop table emp;
drop table dept;

create table emp(
employee_id number(6),
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date,
job_id varchar2(10),
salary number(8),
commission_pct number(2, 2),
manager_id number(6),
department_id number(4)
);

create table dept(
department_id number(4),
department_name varchar2(30),
manager_id number(6),
location_id number(4)
);

insert into dept(department_id, department_name, manager_id, location_id)
values (300, 'Public Relation', 100, 1700);

insert into dept(department_id, department_name)
values (310, 'Purchasing');

select *
from dept;

commit;

--insert
insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values(300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate,
        'AC_ACCOUNT', 6900, null,
        205, 110);
        
insert into emp
values(310, 'Jarj', 'Klein',
        'Klein@gmail.com', '010-753-4635', to_date('2022/06/15', 'YYYY/MM/DD'),
        'IT_PROG', 8000, null,
        120, 190);

insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-632-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100, 30);
        
commit;

drop table sa_reps;

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2)
);

insert into sa_reps(id, name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';
commit;

----------------------
--새로운 데이터를 n번 반복

declare
    base number(6) := 500;
begin
    for i in 1..10 loop
        insert into sa_reps(id, name, salary, commission_pct)
        values(base + i, 'n' || (base + i), base * i, i * 0.01);
    end loop;
end;
/

select * from sa_reps;

select *
from sa_reps
where id > 500;

--update
select employee_id, salary, job_id
from emp
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205),
    salary = (select salary
                from employees
                where employee_id = 205)
where employee_id = 300;

select job_id, salary
from emp
where employee_id = 300;

rollback;

select job_id, salary
from emp
where employee_id = 300;

update emp
set  (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

commit;

-------------------------

delete dept
where department_id = 300;

select *
from dept;

rollback;

select *
from dept;

select *
from emp;

delete emp
where department_id = (
    select department_id
    from departments
    where department_name = 'Contracting');
    
select *
from emp;

commit;

--DDL
drop table hire_dates;

create table hire_dates(
id number(8),
hire_date date default sysdate);

select tname
from tab;

select tname
from tab
where tname not like 'BIN%';

insert into hire_dates values(1, to_date('2025/12/21'));
insert into hire_dates values(2, null);
insert into hire_dates(id) values(3);

commit;

select *
from hire_dates;

--------------------------
--DCL
drop table employees cascade constraints;
grant all on hr.departments to you;

--system
create user you identified by you;
grant connect, resource to you;

--you
select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;

create table emps(
employee_id number(3) primary key,
emp_name varchar2(10), constraint emps_empname_nn not null,
email varchar2(20),
salary number(6) constraint emp_sal_ck check(salary > 1000),
department_id number(3),
constraint emps_email_uk unique(email),
constraint emps_deptid_fx foreign key(department_id)
    references depts(department_id));
    
select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);
commit;

delete depts;

drop table emps cascade constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

grant all on hr.departments to you;

drop table employees cascade constraints;

create table employees(
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fx references employees(employee_id),
department_id number(4) constraint emp_dept_fx references hr.departments(department_id));

create table emps(
employee_id number(3) primary key, --제약조건
emp_name varchar2(10) constraint emps_empname_nn not null,
email varchar2(20),                    
salary number(6) constraint emp_sal_ck check(salary > 1000), 
department_id number(3),
constraint emps_email_uk unique(email), --email칼럼을 조사했다고 명시
constraint emps_deptid_fx foreign key(department_id)
    references depts(department_id));

select constraint_name, constraint_type, table_name
from user_constraints;

insert into depts values(100, 'Development');
insert into emps values(500, 'musk', 'musk@gmail.com', 5000, 100);

commit;

delete depts;

drop table emps cascade constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

--system
grant all on hr.departments to you;

--you
drop table employees cascade constraints; -- 복습시 드랍후 연습
create table employees(    
employee_id number(6) constraint emp_empid_pk primary key,
first_name varchar2(20),  --table에서 primary key조건은 하나만 존재할수있다.
last_name varchar2(25) constraint emp_lastname_nn not null,
email varchar2(25) constraint emp_email_nn not null
                    constraint emp_email_pk unique,
phone_number varchar2(20),
hire_date date constraint emp_hiredate_nn not null,
job_id varchar2(10) constraint emp_jobid_nn not null,
salary number(8) constraint emp_salary_ck check(salary > 0),
commission_pct number(2, 2),
manager_id number(6) constraint emp_managerid_fx references employees(employee_id),
department_id number(4) constraint emp_dept_fx references hr.departments(department_id));


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
gu_id number(3) references gu(gu_id) on delete set null
);

insert into gu values(100, '강남구');
insert into gu values(200, '노원구');

insert into dong values(5000, '압구정동', null); 
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

----------------------------------
drop table a cascade constraints;
drop table b cascade constraints;

create table a(
aid number(1) constraint a_aid_pk primary key);

create table b(
bid number(2),

aid number(1),
constraint b_aid_fx foreign key(aid) references a(aid));

insert into a values(1);
insert into b values(31, 1); --error

alter table b disable constraint b_aid_fx;
insert into b values(32, 9);

alter table b enable constraint b_aid_fx; --error, parent keys not found
alter table b enable novalidate constraint b_aid_fx;
--포린키 다시 살림

insert into b values(33, 8); --error parent key not found
----------------------------------

--sub
drop table sub_departments;

create table sub_departments as
    select department_id dept_id, department_name dept_name
    from hr.departments;
    
desc sub_departments
    
select * from sub_departments;

--------------------------------------

drop table users cascade constraints;

create table users(
user_id number(3));

desc users

--추가
alter table users add(user_name varchar2(10));
desc users


--수정
alter table users modify(user_name number(7));
desc users

--칼럼지우기
alter table users drop column user_name;
desc users

--테이블을 읽기전용으로 바꾸기
insert into users values(1);

alter table users read only; --읽기전용으로 바꿈
insert into users values(2); --error update작업이 허용되지않음

alter table users read write; --쓰기전용으로 다시 바꿈
insert into users values(2); --추가 가능

commit;
----------------------------------------

--view
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80
--select절의 구조가 뷰의모든걸 나타냄

select * from empvu80; --한줄로 밑에 쿼리를 다 나타냄

select * from ( --view가 없었다면 이렇게 길게 썼어야 했다!
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
    --없으면 create해주고
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80
------------------------
    
drop table teams;
drop view team50;

create table teams as
    select department_id team_id, department_name team_name
    from departments;
    
create view team50 as
    select *
    from teams
    where team_id = 50;
    
select * from team50;   

select count(*) from teams;
    
insert into team50 --team50에 insert한것이 teams로 들어감
values(300, 'Marketing');
select count(*) from teams;
    
create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; --제약조건
    
insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support'); --error, view WITH CHECK OPTION where-clause violation
    
create or replace view empvu10(emplyee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --view를 만들게 되면 read only라는 제약조건을 만드는걸 권장
    
insert into empvu10 values(501, 'able', 'Sales'); --error, cannot perform a DML

-----------------------------------------

--sequence
drop sequence team_teamid_seq;

create sequence team_teamid_seq;

select team_teamid_seq.nextval from dual;
select team_teamid_seq.nextval from dual;
select team_teamid_seq.currval from dual;

insert into teams
values(team_teamid_seq.nextval, 'Marketing');
    
select * from teams
where team_id = 3;

create sequence x_xid_seq
    start with 10
    increment by 5
    maxvalue 20
    nocache
    nocycle;
    
select x_xid_seq.nextval from dual;

drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10
    maxvalue 1000;
    
insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees;

select index_name, index_type, table_owner, table_name
from user_indexes;

create index dept_departmentname_idx
on dept(department_name);

select department_name, rowid
from dept;

---------------

drop synonym team;

create synonym team
for departments;

create synonym emps
for employees;

select * from emps;


------------------------
--mybatis table 생성

drop user mybatis cascade;

create user mybatis identified by mybatis default tablespace users;
grant connect, resource to mybatis;


create table mybatis.users (
    user_id number(2) constraint users_userid_pk primary key,
    user_name varchar2(12),
    reg_date date
);

create table mybatis.addresses(
    user_id number(2) constraint addr_userid_pk primary key
                  constraint addr_userid_fk references mybatis.users(user_id),
    address varchar2(30)
);

create table mybatis.posts(
    post_id number(3) constraint posts_postid_pk primary key,
    post_title varchar2(60),
    post_content varchar2(120),
    user_id number(2) constraint posts_userid_pk 
                    references mybatis.users(user_id)
);

--table생성후 제약조건 만들때 
create table mybatis.users(
    user_id number(2),
    user_name varchar2(12),
    reg_date date
);

create table mybatis.addresses(
    user_id number(2),
    address varchar2(30)
);

create table mybatis.posts(
    post_id number(3),
    post_title varchar2(60),
    post_content varchar2(120),
    user_id number(2)
);


alter table mybatis.users
    add constraint users_userid_pk primary key(user_id);
alter table mybatis.addresses
    add constraint addr_userid_pk primary key(user_id);
alter table mybatis.posts
    add constraint posts_postid_pk primary key(post_id);
    
alter table mybatis.addresses
    add constraint addr_userid_fk foreign key(user_id)
        references mybatis.users(user_id);
alter table mybatis.posts
    add constraint posts_userid_fk foreign key(user_id)
        references mybatis.users(user_id);

insert into mybatis.users
    values(1, 'john', to_date('2022-07-22', 'yyyy-mm-dd'));

insert into mybatis.users
    values(2, 'terry', to_date('2022-07-23', 'yyyy-mm-dd'));
    
insert into mybatis.addresses
    values(1, '서울시 마포구');
    
insert into mybatis.addresses
    values(2, '성남시 분당구');

insert into mybatis.posts
    values(101, '사랑', '너와 나의 연결고리', 1);
insert into mybatis.posts
    values(102, '정의', '너와 나의 연대고리', 1);
insert into mybatis.posts
    values(201, '김치', '네가 있어야 밥을 먹지.', 2);
insert into mybatis.posts
    values(202, '비빔밥', '동학농민항쟁이 만든 음식이다.', 2);
insert into mybatis.posts
    values(203, '찹살떡', '네가 그리워.', 2);
    
commit;












    
    



















