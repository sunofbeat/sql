--datatype conversion
--날짜를 문자로
select hire_date
from employees
where hire_date = '2003/06/17';

--숫자를 문자로
select salary
from employees
where salary = '7000';


select hire_date || ''
from employees;

select salary || ''
from employees;
-------------------------

select to_char(hire_date)
from employees;

--지정날짜 형식에 맞게 문자로변환
select to_char(sysdate, 'yyyy-mm-dd')
from dual;

                                --DDsp는 데이의스펠링 DAY(DY)는 단축어
select to_char(sysdate, 'YEAR MONTH DDsp DAY(DY)')
from dual;
--위에껄 소문자로
select to_char(sysdate, 'year month Ddsp Day(Dy)')
from dual;

--d는 요일을 나타냄
select to_char(sysdate, 'd')
from dual;


select last_name, hire_date, 
    to_char(hire_date, 'day'), 
    to_char(hire_date, 'd')
from employees;

--과제 위 테이블을 월요일부터 오름차순 정렬하라.
select last_name, hire_date, 
    to_char(hire_date, 'day') day
from employees
order by to_char(hire_date - 1, 'd'); 

--시분초
select to_char(sysdate, 'hh24:mi:ss am')
from dual;


select to_char(sysdate, 'DD "of" Month')
from dual;

select to_char(hire_date, 'DD Month RR')
from employees;

--fill mode
select to_char(hire_date, 'fmDD Month RR') --fill mode (fm)
from employees;

--과제  사원들의 이름, 입사일, 인사평가일을 조회하라
--      인사평가일은 입사한지 3개월후 첫번째 월요일
--      날짜는 YYYY.MM.DD
select last_name, to_char(hire_date, 'YYYY.MM.DD') hire_date,
    to_char(next_day(add_months(hire_date, 3), 2), 'YYYY.MM.DD') review_day
from employees;

select to_char(salary)
from employees;

--지정형식으로 문자로 바꾸는것
select to_char(salary, '$99,999.99'),
    to_char(salary, '$00,000.00')
FROM employees
where last_name = 'Ernst';

select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, '0000.000') || '|'
from dual;

--fm은 빈자리를 없애줌
select '|' || to_char(12.12, '9999.999') || '|',
    '|' || to_char(12.12, 'fm0000.000') || '|'
from dual;

--원단위를 표현할때 L을 쓴다 (Local)
select to_char(1237, 'L9999')
from dual;

--9월 21일 2005년
select last_name, hire_date
from employees
where hire_date = to_date('sep 21, 2005', 'Mon dd, yyyy');

select last_name, hire_date
from employees                  --Format extract(fx) 정확하게바꿔줘 --error
where hire_date = to_date('Sep 21, 2005', 'fxMon dd, yy'); 

-----------------------------------------------

select to_number('1237')
from dual;

select to_number('1,237')
from dual; --error

select to_number('1,237.12', '9,999.99')
from dual;
--과제 <이름> earms <$,월급> monthly but wants <$,월급x3> 로 조회

select to_char('<'||last_name||'>') || ' earns' ||
    to_char(salary, '$99,999') || ' monthly but wants' ||
    to_char(salary * 3, '$99,999.')
from employees; 
-------------------------------------------

--null

        --조사할값, 이널이면 0
select nvl(null, 0)
from dual;

--데이터 타입이 같아야하는 이유-하나의 칼럼을 구성하기때문
select job_id, nvl(commission_pct, 0)
from employees;

--과제 사원들의 이름, 직업, 연봉을 조회하라.
--영업사원만 commission존재하고 다른직업은 null값이기에 +1을해준다
select last_name, job_id, salary * (1 + nvl(commission_pct, 0)) * 12 ann_sal
from employees
order by ann_sal desc;

--과제 사원들의 이름, 커미션율을 조회하라.
-- 커미션이 없으면, No Commission을 표시한다.
--nvl=없으면.
select last_name, nvl(to_char(commission_pct), 'No Commission')   
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 'SAL') income
from employees;

select job_id, nvl2(commission_pct, 'SAL+COMM', 0) income
from employees;

select first_name, last_name, 
--nullif는 두개의 값이 같으면 null이 리턴됨
    nullif(length(first_name),length(last_name)) name
from employees;


select to_char(null), to_number(null), to_date(null)
from dual;


--coalesce 처음이 아닌값을 리턴하는것
select last_name, job_id,
    coalesce(to_char(commission_pct), to_char(manager_id), 'None')
from employees;

--------------------------------------------------
--07-15
--switch문과 비슷함
--decode
select last_name, salary,
    decode(trunc(salary / 2000),--기본값
        0, 0.00,--비교값, 리턴값
        1, 0.09,
        2, 0.20,
        3, 0.30,
        4, 0.40,
        5, 0.42,
        6, 0.44,
            0.45) tax_rate
from employees
where department_id = 80;

--salary에 a가 있을순없어서 null이 리턴됨
select decode(salary, 'a', 1)
from employees;

select decode(salary, 'a', 1, 0)
from employees;

select decode(job_id, 1, 1)
from employees; --error, invalid number

select decode(hire_date, 'a', 1)
from employees;

select decode(hire_date, 1, 1)
from employees; --error

--과제 사원들의 직업, 직업별 등급을 조회하라.
--      IT_PROG     A
--      AD_PRES     B
--      ST_MAN      C
--      ST_CLERK    D

select job_id, decode(to_char(job_id),
    'IT_PROG', 'A',
    'AD_PRES', 'B',
    'ST_MAN',  'C',
    'ST_CLERK',  'D') "Level"
from employees
order by 2;

select last_name, job_id, salary,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'AD_PRES' then 1.05 * salary
    else salary end revised_salary
from employees;
    
select case job_id when '1' then 1
                    when '2' then 2
                    else 0
       end grade
from employees;

select case salary when 1 then '1'
                    when 2 then '2'
                    else '0'
       end grade
from employees;

select case salary when '1' then '1'
                    when 2 then '2' --error
                    else '0'
       end grade
from employees; 

select case salary when 1 then '1'
                    when 2 then '2'
                    else 0 --error
       end grade
from employees;

select case salary when 1 then 1 --error
                    when 2 then '2'
                    else '0'
       end grade
from employees;

select last_name, salary,
    case when salary < 5000 then 'low'
        when salary < 10000 then 'medium'
        when salary < 20000 then 'high'
        else 'good'
    end grade
from employees;

--과제] 이름, 입사일, 요일을 월요일부터 요일순으로 조회하라.

select last_name, hire_date, to_char(hire_date, 'fmday') day
from employees
order by case day
            when 'monday' then 1
            when 'tuesday' then 2
            when 'wednesday' then 3
            when 'thursday' then 4
            when 'friday' then 5
            when 'saturday' then 6
            when 'sunday' then 7
        end;

--과제 2005년 이전에 입사한 사원들에겐 100만원 상품권
--      2005년 후에 입사한 사원들에게 10만원 상품권을 지급한다.
--      사원들의 이름, 입사일, 상품권금액을 조회하라.
select last_name, to_char(hire_date, 'YYYY') "year",
    case  when to_char(hire_date, 'YYYY') <= 2005  then '100만원'
        when to_char(hire_date, 'YYYY') > 2005 then '10만원'
        end gift
from employees;

--정답
select last_name, to_char(hire_date, 'YYYY') "year",
    case  when to_char(hire_date, 'YYYY') <= 2005  then '100만원'
        else '10만원' end gift
from employees
order by gift, hire_date;
