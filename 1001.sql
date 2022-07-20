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
create user you identified by you;
grant connect, resource to you;

select tname
from tab;

create table depts(
department_id number(3) constraint depts_deptid_pk primary key,
department_name varchar2(20));

desc user_constraints

select constraint_name, constraint_type, table_name
from user_constraints;


create table emps(
employee_idm number(3) primary key, --제약조건
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

--무결성
delete depts; --error

insert into depts values(100, 'Marketing'); --error, (YOU.DEPTS_DEPTID_PK) violated
insert into depts values(null, 'Marketing'); --error, cannot insert NULL
insert into emps values(501, null, 'good@gmail.com', 6000, 100); --error,  cannot insert NULL
insert into emps values(501, 'label', 'musk@gmail.com', 6000, 100); --error
insert into emps values(501, 'abel', 'good@gmail.com', 6000, 200); --error, parent key not found

drop table emps cascade constraints;

select constraint_name, constraint_type, table_name
from user_constraints;

--system user
grant all on hr.departments to you;

-- you user
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

















