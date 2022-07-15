select * from departments;

select department_id, location_id
from departments;

select location_id, department_id
from departments;

desc departments

select last_name as name, commission_pct comm
from employees;

--Á¶°Ç¹®
select employee_id, last_name, department_id
from employees
where department_id = 90; 

select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06';

select last_name, salary
from employees
where salary <= 3000;

select last_name, job_id
from employees
where job_id != 'IT_PROG';

select last_name, salary
from employees
where salary between 1000 and 5000;

select first_name, last_name, job_id, salary
from employees
where last_name between 'King' and 'Smith';

select first_name, last_name, job_id, salary
from employees
where last_name = 'King';

select last_name, hire_date
from employees
where hire_date between '2002/01/01' and '2002/12/31';

select employee_id, last_name, manager_id
from employees
where manager_id in(100, 101, 201);

select employee_id, last_name, manager_id
from employees
where manager_id = 100 or
    manager_id = 101 or
    manager_id = 201;
    
select employee_id, last_name
from employees
where last_name in('Hartstein', 'Vargas');

select last_name, hire_date
from employees
where hire_date in ('2001/01/01', '2005/09/21');