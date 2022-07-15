select first_name
from employees
where first_name like 'S%';

select last_name
from employees
where last_name like '%s%';

select last_name
from employees
where last_name like 'K___';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\';

select last_name, salary, department_id
from employees
where (salary between 5000 and 12000) and
    department_id in(20, 50);
    
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP');

select last_name, salary
from employees
where salary not between 10000 and 15000;

select last_name, job_id
from employees
where job_id not like '%IT%';

select last_name, job_id
from employees
where commission_pct is not null;

select last_name, salary
from employees
where manager_id is null and salary >= 20000;

select last_name, salary
from employees
where not (manager_id is null and salary >=20000);

select last_name, job_id, salary
from employees
where (job_id like 'SA_%') and not(salary between 2500 and 3500);

--programer이고 이름에길이, 이름에 a가 몇개 포함되어있는가
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'"
from employees
where substr(job_id, 4) = 'PROG';

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'"
from employees
where job_id like '%PROG';

select initcap(last_name), length(last_name)
from employees
where last_name like 'J&' or last_name like 'A%' or last_name like 'M%';

select round(192.22142, 3)
from dual;

select trunc(192.89, 1)
from dual;

select mod(1600, 300)
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

select last_name, round((sysdate - hire_date)/365)
from employees
where department_id = 90;

select months_between('2022/12/31', '2021/12/31')
from dual;

select add_months('2022/05/14', 1)
from dual;

select next_day('2022/07/14', 3)
from dual;

select last_day('2022/07/14')
from dual;

select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12*20;

