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