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
    




    
    
    
    
    
    
    
    
    
    
    
    
    