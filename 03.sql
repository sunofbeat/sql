--single function

desc dual
select * from dual;

select lower('SQL Course') --소문자로 변환
from dual;

select upper('SQL Course') -- 대문자로 변환
from dual;

select initcap('SQL Course') --첫글자를 대문자로 변환
from dual;

select last_name
from employees
where last_name = 'higgins';
--위 아래 다른 데이터
select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';

select concat('Hello', 'world') --붙이기
from dual;
                        --index, length순 첫번째글자가 1번째
select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello',-1, 1)
from dual;

select length('Hello')
from dual;
                --처음으로 발견된 index를 찾고 종료함
select instr('Hello', 'l')
from dual;

select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') --왼쪽으로 5자리 5자리가 아니면 *로 채우겠다
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and Jue', 'J', 'BL') --J를 BL로 바꾸겠다
from dual;

select trim('H' from 'Hello') --H를 제거
from dual;

select trim('l' from 'Hello') --I를 제거하지만 trim은 앞과 끝만 제거가능
from dual;

--과제 위query에서 ''가 제거됬다는걸 표현해라
select trim(' ' from ' Hello ') 
from dual;

select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;
-------------------------------------------------
--과제 아래 문장을 like로 구현하라.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';    

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

--과제 이름이 J나 A나 M으로 시작하는 사원들의 이름, 이름의 글자수를 조회하라
-- 이름은 첫글자는 대문자, 나머지는 소문자로 출력하라

select initcap(last_name), length(last_name)
from employees
where last_name like 'j%' or last_name like 'A%' or last_name like 'M%';

  

------------------------------------
--숫자를 다루는 Function
--(반올림)앞부분은 수, 뒷부분은 소수점자리
select round(45.926, 2) 
from dual;

--내림
select TRUNC(45.926, 2)
from dual;

select mod(1600, 300)  --나머지
from dual;

select round(45.923, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;



-----------------------------

--사원들의 이름, 월급, 15.5% 인상된 월급(New Salary, 정수)를 조회하라
select last_name, salary, round(salary * 1.155) "New Salary", 
    round(salary * 0.155) "Increase"
from employees;

-------------
--날짜를 다루는 함수
select sysdate
from dual;

select sysdate + 1
from dual;
select sysdate - 1
from dual;
select sysdate - sysdate
from dual;

select last_name, sysdate - hire_date
from employees
where department_id = 90;

----------
--근속년수를 조회하라
select last_name, round((sysdate - hire_date)/365)
from employees
where department_id = 90;

--개월수 비교하기
select months_between('2022/12/31', '2021/12/31')
from dual; --앞에 파라미터가 큰날짜, 뒤에가 작은날짜

--1개월 뒤를 구하라
select add_months('2022/07/14', 1)
from dual;

--일요일이 1 ~ 토요일이 7 (다음주 요일이 몇일인가)
select next_day('2022/07/14', 'thursday')
from dual;

--월의 마지막날
select last_day('2022/07/14')
from dual;

--과제] 20년 이상 재직한 사원들의 이름, 첫 월급일을 조회하라
--월급은 매월 말일에 지급한다.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

--과제] 사원들의 이름, 월급그래프를 조회하라
--      그래프는 1000달러당 *하나를 표시한다
--맨 앞자리는 빈자리가 차지하므로 +1을 해준다
select last_name, rpad(' ', salary/1000 + 1, '*') "grape"
from employees
order by 2 desc; --내림차순

