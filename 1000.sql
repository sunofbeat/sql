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

select last_name, rpad(' ', salary/1000 + 1, '*') grade
from employees
order by 2 desc;

select hire_date
from employees
where hire_date = '2003/06/17';

select salary
from employees
where salary = '7000';

select hire_date || ''
from employees;

select to_char(sysdate, 'yyyy-mm-dd')
from dual;

select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;

select to_char(sysdate, 'd')
from dual;

select last_name, hire_date,
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd');

select to_char(sysdate, 'hh12:mi:ss am')
from dual;

select to_char(sysdate, 'DD "of" Month')
from dual;

select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 2), 'YYYY.MM.DD')
from employees;

select to_char(salary, '$99,999.99'),
    to_char(salary, '$00,000.00')
from employees
where last_name = 'Ernst';

select to_char(123124, 'L999,999')
from dual;

select job_id, nvl(commission_pct, 0)
from employees;

select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12
from employees
order by 3;

select last_name, nvl(to_char(commission_pct), 'No Commission')
from employees;

select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;
-----------

select last_name, salary,
    decode(trunc(salary / 2000),
    0, 0.00,
    1, 0.09,
    2, 0.20,
    3, 0.30,
    4, 0.40,
    5, 0.42,
    6, 0.44,
        0.45) tax_rate
from employees
where department_id = 80;

select decode(salary, 'a', 1)
from employees;


select job_id, decode(To_char(job_id),
    'IT_PROG', 'A',
    'AD_PRES', 'B',
    'ST_MAN',  'C',
    'ST_CLERK', 'D',
            'None') grade
from employees
order by 2;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;

select case job_id
    when '1' then 1
    when '2' then 2
    else 0 end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'mediun'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

select last_name, hire_date, to_char(hire_date, 'day'),
    case to_char(hire_date, 'fmday')
            when 'monday' then 1
            when 'tuesday' then 2
            when 'wednesday' then 3
            when 'thursday' then 4
            when 'friday' then 5
            when 'saturday' then 6
            when 'sunday' then 7
    end day
from employees
order by day;

select last_name, to_char(hire_date, 'YYYY') "year",
    case when to_char(hire_date, 'YYYY') <= 2005 then '$1000'
        else '$100' end gift
from employees
order by gift, hire_date;

-----------------------------------
--group function
select avg(salary), max(salary), min(salary), sum(salary)
from employees;

select min(hire_date), max(hire_date)
from employees;

select count(*)
from employees;

select count(*)
from employees
where department_id = 70;

select count(employee_id)
from employees;

select avg(nvl(commission_pct, 0))
from employees;

select avg(salary)
from employees;

select count(distinct department_id)
from employees;

select count(distinct manager_id)
from employees;

select department_id, count(employee_id)
from employees
group by department_id
order by department_id;

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

select job_id, sum(salary) payroll
from employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by payroll;

select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by 2 desc;

select max(avg(salary))
from employees
group by department_id;

select department_id, round(avg(salary))
from employees
group by department_id;

--과제  2001, 2002, 2003,년도별 입사자 수를 찾는다.
select sum(decode(to_char(hire_date, 'yyyy'), '2001', 1, 0)) "2001",
    sum(decode(to_char(hire_date, 'yyyy'), '2002', 1, 0)) "2002",
    sum(decode(to_char(hire_date, 'yyyy'), '2003', 1, 0)) "2003"
from employees;

select count(case when hire_date like '2001%' then 1 else null end) "2001",
    count(case when hire_date like '2002%' then 1 else null end) "2002",
    count(case when hire_date like '2003%' then 1 else null end) "2003"
from employees;

--과제] 직업별, 부서별, 월급합을 조회하라.
--  부서는 20, 50, 80이다.
select job_id, sum(decode(department_id, 20, salary)) "20",
    sum(decode(department_id, 50, salary)) "50",
    sum(decode(department_id, 80, salary)) "80"
from employees
group by job_id;

---------------------------------------------

--join
select department_id, department_name, location_id
from departments;

select location_id, city
from locations;

--equi join
select department_id, department_name, location_id, city
from departments natural join locations;

select department_id, department_name, location_id, city
from departments natural join locations
where department_id in(20, 50);

select employee_id, last_name, department_id, location_id
from employees join departments
using (department_id);

--위 코드의 누락된 1인을 구하라.
select last_name, job_id, department_id
from employees
where department_id is null;
---------------------------------

select employee_id, last_name, department_id, location_id
from employees natural join departments;

-----------------
--using
select l.city, d.department_name
from locations l join departments d
using (location_id)
where location_id = 1400;

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where d.manager_id = 100;

select e.last_name, d.department_name
from employees e join departments d
using (department_id)
where e.manager_id = 100;

------------------------------
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

--과제 위 문장을, using으로 refactoring하라

select employee_id, city, department_id
from employees e join departments d
using (department_id)
join locations l
using (location_id);

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
--where대신 and을 써도 결과는 같음

--과제 Toronto에 위치한 부서에서 일하는 사원들의
--  이름, 직업, 부서번호ㅡ 부서명을 조회하라.
select e.last_name, e.job_id, e.department_id,
    d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
and l.city = 'Toronto';

--non-equi join
--
select e.last_name, e.salary, e.job_id
from employees e join jobs j
on e.salary between j.min_salary and j.max_salary
and j.job_id = 'IT_PROG';

--self join --table안의
select worker.last_name emp, manager.last_name mgr
from employees worker join employees manager
on worker.manager_id = manager.employee_id;

--과제 같은 부서에서 일하는 사원들의 부서번호 이름,  동료의 이름을 조회하라
select e.department_id, e.last_name, c.last_name colleague
from employees e join employees c
on e.department_id = c.department_id
and e.employee_id <> c.employee_id
order by 1, 2, 3;

--과제 Davies 보다 후에 입사한 사원들의 이름, 입사일을 조회하라.
select e.last_name, e.hire_date
from employees e join employees d
on d.last_name = 'Davies'
and e.hire_date > d.hire_date;

-----------------------
--과제 메니져보다 먼저 입사한 사원들의 이름, 입사일, 매니져명, 매니저 입사일을 조회
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on w.manager_id = m.employee_id
and w.hire_date < m.hire_date;

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
on e.manager_id = e.employee_id
order by 2;

---------------------------------

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

--------------------------------------------
--subquery
--Abel의 월급을 초과하는 직원을 구하는 쿼리
select last_name, salary
from employees
where salary > (select salary
                from employees
                where last_name = 'Abel');
                
--과제] Kochhar 에게 보고하는 사원들의 이름, 월급을 조회하라
select last_name, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where last_name = 'Kochhar');
 
--과제 abel과 같은 부서에서 일하는 동료들의 이름, 입사일을 조회하라          
select last_name, hire_date
from employees
where department_id = (select department_id
                    from employees
                    where last_name = 'Abel')
and last_name <> 'Abel'
order by 1;

--과제 회사 평균 월급 이상 버는 사원들의 사번, 이름, 월급을 조회하라.
--  월급은 오름차순정렬한다.
select employee_id, last_name, salary
from employees
where salary >= (select avg(salary)
                from employees)
order by 3;

--과제 이름에 u가 포함된 사원이 있는과 같은 부서에서 일하는 사원들의 
-- 사번, 이름을 조회하라.
select employee_id, last_name
from employees
where department_id in (select department_id
                        from employees
                        where last_name like '%u%');
                        
--과제 1700번 지역에 위치한 부서에서 일하는 
--사원들의 이름, 직업, 부서번호를 조회
select last_name, job_id, department_id
from employees
where department_id in (select department_id
                        from departments
                        where location_id = 1700);
                        
--(any)sub에서 1개라도 true면 리턴함                   
select employee_id, last_name
from employees
where salary = any (select min(salary)
                    from employees
                    group by department_id);
                    
select employee_id, last_name, job_id, salary
from employees
where salary < any (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

--all은 모든값이 true여야 리턴됨
select employee_id, last_name, job_id, salary
from employees
where salary < all (select salary
                    from employees
                    where job_id = 'IT_PROG')
and job_id <> 'IT_PROG';

---------------------
--no row
select last_name
from employees
where salary = (select salary
                from employees
                where employee_id = 1);
                
select last_name
from employees
where salary in (select salary
                from employees
                where job_id = 'IT');
                
--null
select last_name
from employees
where employee_id in (select manager_id
                        from employees);

select last_name
from employees
where employee_id not in (select manager_id
                            from employees);

--과제 위 문장으로 all 연산자로 refactoring하라
select last_name
from employees
where employee_id <> all (select manager_id
                        from employees);
                        
select count(*)
from departments;

select count(*)
from departments d
where exists (select *
                from employees e
                where e.department_id = d.department_id);
                
--과제] 직업을 바꾼 적이 있는 사원들의 사번, 이름, 직업을 조회
select employee_id, last_name, job_id
from employees e
where exists (select *
            from job_history j
            where e.employee_id = j.employee_id)
order by 1;

select *
from job_history
order by employee_id;

-------------------------------------
--set
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

select location_id, department_name
from departments
union
select location_id, state_province
from locations;

select location_id, department_name, null "State"
from departments
union
select location_id, null, state_province
from locations;

select employee_id, job_id, salary
from employees
union
select employee_id, job_id
from job_history; --error  row값이 다름

select employee_id, job_id, salary
from employees
union
select employee_id, job_id, 0 --row값을 맞춰주면 해결
from job_history;

--DML



























