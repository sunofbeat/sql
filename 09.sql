-- DML(Date Manipulation Language)

--삭제(drop)
drop table emp; 
drop table dept; 

create table emp(
employee_id number(6), --(size)
first_name varchar2(20),
last_name varchar2(25),
email varchar2(25),
phone_number varchar2(20),
hire_date date, --date에는 size가 없음
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
location_id number(4));

insert into dept(department_id, department_name, manager_id, location_id)
values (300, 'Public Relation', 100, 1700);

insert into dept(department_id, department_name)
values(310, 'Purchasing');

--과제 row 2건이 insert 성공됐는지 확인하라.
select *
from dept; --transaction의 요소는 아님

commit;
--insert묶음을 transaction이라한다

--insert
insert into emp(employee_id, first_name, last_name,
                email, phone_number, hire_date,
                job_id, salary, commission_pct,
                manager_id, department_id)
values(300, 'Louis', 'Pop',
        'Pop@gmail.com', '010-378-1278', sysdate,
        'AC_ACCOUNT', 6900, null, 
        205, 110);
        
insert into emp --위에 한번 작성했으면 다시 안써도됨
values(310, 'Jark', 'Klein',
        'Klein@gmail.com', '010-753-4635', to_date('2022/06/15', 'YYYY/MM/DD'),
        'IT_PROG', 8000, null,
        120, 190);
        
insert into emp
values(320, 'Terry', 'Benard',
        'Benard@gmail.com', '010-632-0972', '2022/07/20',
        'AD_PRES', 5000, .2,
        100, 30);
        
commit;

--------------------------------

drop table sa_reps;

create table sa_reps(
id number(6),
name varchar2(25),
salary number(8, 2),
commission_pct number(2, 2));

insert into sa_reps(id, name, salary, commission_pct)
    select employee_id, last_name, salary, commission_pct
    from employees
    where job_id like '%REP%';
commit;

--------------------------------------------
--새로운 데이터를 n번 반복
declare
    base number(6) := 400;
begin
    for i in 1..10 loop
        insert into sa_reps(id, name, salary, commission_pct)
        values(base + i, 'n' || (base + i ), base * i, i * 0.01);
    end loop;
end;  
/       --프로시저(procedure)  '/'로 마무리
--plsql

select * from sa_reps;

--과제 procedure 로 insert한 row들을 조회하라
select *
from sa_reps
where id > 400; 

----------------------

--update
select employee_id, salary, job_id
from emp
where employee_id = 300;

--300번 사번의 월급을 수정한다
update emp
set salary = 9000, job_id = null
where employee_id = 300;

commit;

update emp
set job_id = (select job_id
                from employees
                where employee_id = 205), --205번이랑 같은직업으로
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
set (job_id, salary) = (
    select job_id, salary
    from employees
    where employee_id = 205)
where employee_id = 300;

commit;

-----------------------------

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





























