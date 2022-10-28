--view 
--query에 붙인 별명은 view
--query에 별명이 view
--view에는 데이터가 없음!!

--hr user
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
--과제 50번 부서원들의 사번, 이름, 부서번호로 만든 DEPT50 view를 만들어라.
--      view 구조는 EMPNO, EMPLOYEE, DEPTNO이다
--      view를 통해서 50번 부서 사원들이 다른 부서로 배치되지 않도록 한다.
drop view dept50;

create view dept50 (EMPNO, EMPLOYEE, DEPTNO) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck;

--과제 DEPT50 view의 구조를 조회하라    
desc dept50

--과제 DEPT50 view 의 data를 조회하라

select * from dept50;


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
    start with 10  --시작값
    increment by 5 --증가치
    maxvalue 20   --최고치
    nocache --cahce:메모리에 임시로 저장하는것, 미래를 위해 어딘가에 미리 저장해두는것
    nocycle; --maxvalue에 도달하면 다시 초기값으로 돌아가지않음(10부터 시작해서 5씩 20까지)
    
select x_xid_seq.nextval from dual;

--과제 DEPT테이블의 DEPTID 칼럼의 field value로 사용할 sequence를 만들어라
--      sequence는 400이상, 1000이하로 생성한다. 10씩 증가한다.
drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10 
    maxvalue 1000;
    
--과제 위 sequence로, dept 테이블에, education부서를 insert하라

insert into dept(department_id, department_name)
values(dept_deptid_seq.nextval, 'Education');

commit;

---------------------------------------------   
    
--index

drop index emp_lastname_idx;

create index emp_lastname_idx
on employees(last_name);

select last_name, rowid
from employees;

select last_name
from employees
where rowid = 'AAAEAbAAEAAAADNABK';

select index_name, index_type, table_owner, table_name
from user_indexes;

--과제 dept 테이블의 department_name에 대해 index를 만들어라.
create index dept_departmentname_idx
on dept(department_name);

select department_name, rowid
from dept;
    
---------------------------------    

--synonym  
drop synonym team;

create synonym team
for departments;

select * from team;

--과제 employees 테이블에 emps synonym을 만들어라

create synonym emps
for employees;

select * from emps;

    
    
    
    
    
    
    
    
    
    
    
    
    
    