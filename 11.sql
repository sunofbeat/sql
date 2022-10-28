--view 
--query�� ���� ������ view
--query�� ������ view
--view���� �����Ͱ� ����!!

--hr user
drop view empvu80;

create view empvu80 as
    select employee_id, last_name, department_id
    from employees
    where department_id = 80;
    
desc empvu80
--select���� ������ ���Ǹ��� ��Ÿ��

select * from empvu80; --���ٷ� �ؿ� ������ �� ��Ÿ��

select * from ( --view�� �����ٸ� �̷��� ��� ���� �ߴ�!
    select employee_id, last_name, department_id
    from employees
    where department_id = 80);
    
    --������ create���ְ�
create or replace view empvu80 as
    select employee_id, job_id
    from employees
    where department_id = 80;
    
desc empvu80
------------------------
--���� 50�� �μ������� ���, �̸�, �μ���ȣ�� ���� DEPT50 view�� ������.
--      view ������ EMPNO, EMPLOYEE, DEPTNO�̴�
--      view�� ���ؼ� 50�� �μ� ������� �ٸ� �μ��� ��ġ���� �ʵ��� �Ѵ�.
drop view dept50;

create view dept50 (EMPNO, EMPLOYEE, DEPTNO) as
    select employee_id, last_name, department_id
    from employees
    where department_id = 50
    with check option constraint dept50_ck;

--���� DEPT50 view�� ������ ��ȸ�϶�    
desc dept50

--���� DEPT50 view �� data�� ��ȸ�϶�

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
    
insert into team50 --team50�� insert�Ѱ��� teams�� ��
values(300, 'Marketing');
select count(*) from teams;
    
create or replace view team50 as
    select *
    from teams
    where team_id = 50
    with check option; --��������
    
insert into team50 values(50, 'IT Support');
select count(*) from teams;
insert into team50 values(301, 'IT Support'); --error, view WITH CHECK OPTION where-clause violation
    
create or replace view empvu10(emplyee_num, employee_name, job_title) as
    select employee_id, last_name, job_id
    from employees
    where department_id = 10
    with read only; --view�� ����� �Ǹ� read only��� ���������� ����°� ����
    
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
    start with 10  --���۰�
    increment by 5 --����ġ
    maxvalue 20   --�ְ�ġ
    nocache --cahce:�޸𸮿� �ӽ÷� �����ϴ°�, �̷��� ���� ��򰡿� �̸� �����صδ°�
    nocycle; --maxvalue�� �����ϸ� �ٽ� �ʱⰪ���� ���ư�������(10���� �����ؼ� 5�� 20����)
    
select x_xid_seq.nextval from dual;

--���� DEPT���̺��� DEPTID Į���� field value�� ����� sequence�� ������
--      sequence�� 400�̻�, 1000���Ϸ� �����Ѵ�. 10�� �����Ѵ�.
drop sequence dept_deptid_seq;

create sequence dept_deptid_seq
    start with 400
    increment by 10 
    maxvalue 1000;
    
--���� �� sequence��, dept ���̺�, education�μ��� insert�϶�

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

--���� dept ���̺��� department_name�� ���� index�� ������.
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

--���� employees ���̺� emps synonym�� ������

create synonym emps
for employees;

select * from emps;

    
    
    
    
    
    
    
    
    
    
    
    
    
    