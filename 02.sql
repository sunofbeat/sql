--where
--조건문
select employee_id, last_name, department_id
from employees
where department_id = 90; --같은부서찾기

--과제 176번 사원의 이름과 부서번호를 조회하라
select employee_id, last_name, department_id
from employees
where employee_id = 176;

select employee_id, last_name, department_id
from employees
where last_name = 'Whalen';

select employee_id, last_name, hire_date
from employees
where hire_date = '2008/02/06'; 

select last_name, salary
from employees
where salary <= 3000; --연봉이 3000이하인사람을 찾아라

--과제 $12,000 이상 버는 사원들의 이름, 월급을 조회하라
select last_name, salary
from employees
where salary >= 12000;

SELECT last_name, job_id
from employees
where job_id != 'IT_PROG'; --it programer가 아닌사람을 찾아라

----------------------
--범위 조건문
select last_name, salary
from employees
where salary between 2500 and 3500; --2500이상 3500이하

select first_name, last_name, job_id, salary
from employees
where last_name between 'King' and 'Smith';

--과제 이름이 King 사원의 first name, last name, 직업 월급을 조회하라

select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; --데이터는 대소문자를 구분한다.

select last_name, hire_date
from employees
where hire_date between '02/01/01' and '02/12/31';

------------------

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); --100번매니저의 부하,101~~

--논리연산자
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
where hire_date in ('2003/06/17', '2005/09/21');

----------------------------------------------------------

select first_name
from employees
where first_name like 'S%'; --S로 시작하는 이름찾기

select first_name
from employees
where first_name like '%r';

--과제 이름에 s가 포함된 사원들을 조회하라
select last_name
from employees
where last_name like '%s%';

--과제 2005년에 입사한 사원들의 이름, 입사일을 조회하라
select last_name, hire_date
from employees
where hire_date like('2005/%/%'); --'2005%';도 가능

select last_name
from employees   --브라우저 검색할때 like
where last_name like 'K___';  --K로 시작하는 4자리수의 이름을 찾을때 _하나의 한칸

--과제 이름의 두번재 글자가 o인사원의 이름을 조회
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; --\를 일반문자로 바꿔준다

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '[';

--과제 직업에 _R이 포함된 사원의 이름, 직업을 조회
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

-------------------------------------

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null; --연산자가 포함된 수식에선 둘다 null값이라 null값을 찾을수 없음

select last_name, manager_id
from employees
where manager_id is null; -- =를 is로 표현하면 값이나온다

----------------------------------------

select last_name, job_id, salary
from employees
where salary > 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary > 5000 or job_id like '%IT%';

--과제 월급이 5000달러이상 12000이하이고 
--20번이나 50번 부서에서 일하는사원의 이름,
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000)and 
    department_id in(20, 50);
    
--과제 이름에 a와 e가 포함된 사원의 이름을 조회
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

----------------------------------------

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); --프로그래머와 영업사원이 아닌직업 찾기

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

--월급을 20000달러 이상 받는, 사장 외 사원들의 이름,월급 조회
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--과제 직업이 영업(SA)이다 그리고
--          월급이2500, 3500가 아닌 사원들의 이름, 직업, 월급조회
select last_name, job_id, salary
from employees
where (job_id like 'SA_%') and not(salary between 2500 and 3500);
----------------------------------------
select last_name, department_id
from employees
order by department_id;  --오름차순

select last_name, department_id
from employees --order by문은 제일 마지막에 온다
order by department_id desc; --내림차순
--100번 부서에서 입사일순으로 나열하기
select last_name, hire_date
from employees
where department_id = 100
order by hire_date;

select last_name, department_id "dept_id"
from employees
order by 2 desc;  --index값으로도 할수있음 --별명도 가능

select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc; --n차 정렬