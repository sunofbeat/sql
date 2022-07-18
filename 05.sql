--group function --single이던 group이던 리턴값은 1개이다.
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date) 
from employees;     --max 최근방문기록

--과제 최고월급과 최소월급의 차액을 조회하라
select max(salary), min(salary), max(salary) - min(salary)
from employees;

select count(*) 
from employees; --record를 리턴해줌

--과제 70번 부서원이 몇명인지 조회하라.
select count(*) 
from employees
where department_id = 70;

select count(employee_id)
from employees;

SELECT count(manager_id)
from employees; --group에서는 null값이면 무시한다.

select avg(commission_pct)
from employees; --영업사원의 커미션이다

--과제 조직의 평균 커미션율을 조회하라.
select avg(nvl(commission_pct, 0))
from employees;

----------------------------------

select avg(salary)
from employees;

select avg(distinct salary)
from employees;

select avg(all salary)
from employees;

--과제] 직원이 배치된 부서 개수를 조회하라.
select count(distinct department_id)
from employees;

--과제] 
select count(distinct manager_id)
from employees;

--------------------------
--그룹칼럼, 그룹func을 쓸수 있다.
select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

select employee_id
from employees
where department_id = 30;
                            
select department_id, job_id, count(employee_id)
from employees --job_id는 문법상 안맞아서 error
group by department_id
order by department_id;

--과제 직업별 사원수를 조회하라.
select job_id, count(employee_id)
from employees
group by job_id;

select department_id, max(salary)
from employees
group by department_id
having department_id > 50;

select department_id, max(salary)
from employees
group by department_id
having max(salary) > 10000;

select department_id, max(salary) max_sal
from employees
group by department_id
having max_sal > 10000; --error

select department_id, max(salary)
from employees
where department_id > 50
group by department_id ;

select department_id, max(salary)
from employees
where max_sal > 10000
group by department_id; --error

