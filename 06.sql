--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

-- equi join(equal연산자) 중의 하나가 natural join이다
select department_id, department_name, location_id, city
from departments natural join locations;

--20, 50번 부서에서 일하는사원의 부서번호, 부서명, 지역번호, 도시
select department_id, department_name, location_id, city
from departments natural join locations
where department_id in (20, 50);
--장점 개발하기 편함

select employee_id, last_name, department_id, location_id
from employees join departments
using(department_id); --공통칼럼명을 내가 정할수 있음
--위 코드의 누락된 1인을 구하라
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
using (location_id) --using의 칼럼에 (where)접두사를 붙여서 에러
where d.location_id = 1400; --error

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where manager_id = 100; --error 접두사가 없음

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
and e.manager_id = 149; --조건문이 n개면 and을 쓸수 있음

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

--self join --table안의
--접두사는 필수!! 
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on manager_id = employee_id; --error 칼럼네임앞에 접두사를 안붙이면 에러

--select절에 접두사가 안붙어서 에러
select last_name emp, last_name mgr
from employees worker join employees manager 
on worker.manager_id = manager.employee_id; --error

--과제 같은 부서에서 일하는 사원들의 부서번호 이름,  동료의 이름을 조회하라
select e.department_id, e.last_name, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id -- <>는 !=와 같음
order by 1, 2, 3; --동료를 구하는거기때문에 나는 빼야함

--과제 Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

----------------------------------------------
--7-19
--과제 메니져보다 먼저 입사한 사원들의 이름, 입사일, 매니져명, 매니저 입사일을 조회
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and w.hire_date < m.hire_date; 
-----------------------------------------------

--inner join
select e.last_name, e.department_id, d.department_name
from employees e join departments d
on e.department_id = d.department_id;

--outer join
select e.last_name, e.department_id, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id;

select e.last_name, e.department_id, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id;

--과제 사원들의 이름, 사번, 매니져명, 매니저의 사번을 조회하라
--      King 사장도 테이블의 포함한다
select e.last_name, e.employee_id, m.last_name, m.employee_id
from employees e left outer join employees m
on e.manager_id = m.employee_id
order by 2;

------------------------------------------------

--옛날 join방식
select d.department_id, d.department_name, d.location_id, l.city
from departments d, locations l
where d.location_id = l.location_id
and d.department_id in(20, 50);

select e.last_name, d.department_name, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select e.last_name, e.salary, e.job_id
from employees e, jobs j
where e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';


select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;
--right outer join = 예전방식 왼쪽 칼럼명에(+)를 붙인다

select e.last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);
--left outer join은 오른쪽칼럼에 (+)를 붙임

--self join
select worker.last_name || ' works for ' || manager.last_name
from employees worker, employees manager 
where worker.manager_id = manager.employee_id;















