-- set
select employee_id, job_id
from employees
union  
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
union all
select employee_id, job_id
from job_history;

--과제 과거 직업을 현재 갖고있는 사원들의 사번, 이름, 직업조회
select e.employee_id, e.last_name, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id
and e.job_id = j.job_id;

--이렇게도 할수있음 이름은 출력x
select employee_id, job_id
from employees
intersect --교집합
select employee_id, job_id
from job_history;

select employee_id, job_id
from employees
minus --차집합
select employee_id, job_id
from job_history;

--persistence관점에선 숫자와 문자로 잘 나뉘었지만 도시명이 섞여있어서
-- service관점에선 알아보기 힘듬

select location_id, department_name
from departments
union 
select location_id, state_province
from locations;

--과제 위문장을, service관점에서 고쳐라
select location_id, department_name, null "State"
from departments
union 
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history; --error

--과제 위 문장을 고쳐라
select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 --row값을 맞춰주면 해결
from job_history
order by salary;








