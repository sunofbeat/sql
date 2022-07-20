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




