--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join(equal연산자) 중의 하나가 natural join이다
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);
--장점 개발하기 편함

select employee_id, last_name, department_id, location_id
from employees join departments
using(department_id);

select last_name, job_id, department_id
from employees
where department_id is null;

---------------------------------

select employee_id, last_name, department_id, location_id
from employees natural join departments;
-------------------
--using
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select l.city, d.department_name
from locations l join departments d
using (location_id)
where d.location_id = 1400; --error using칼럼에서는 접두사를 붙이지못함

select l.city, d.department_name, d.location_id
from locations l join departments d
using (location_id)
where d.location_id = 1400; --error

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where manager_id = 100; --error

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100;

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where e.manager_id = 100;

-----------------
--on
select employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, city, department_name
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

--과제 위 문장을, using으로 refactoring 하라

select employee_id, city, department_id
from employees e join departments d
using (department_id)
join locations l
using(location_id);

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
where e.manager_id = 149;

select e.employee_id, e.last_name, e.department_id,
    d.department_id, d.location_id
from employees e join departments d
on e.department_id = d.department_id
and e.manager_id = 149;

--과제 Toronto에 위치한 부서에서 일하는 사원들의
--  이름, 직업, 부서번호ㅡ 부서명을 조회하라.

select e.last_name, e.job_id, e.department_id, 
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id 
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

-- non-equi join
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

--self join
--접두사는 필수!! 
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error

select last_name emp, last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id; --error

--과제 같은 부서에서 일하는 사원들의 부서번호 이름,  동료의 이름을 조회하라
select e.department_id, e.last_name, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id -- <>는 !=와 같음
order by 1, 2, 3;

--과제 Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.


