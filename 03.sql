--single function

desc dual
select * from dual;

select lower('SQL Course') --�ҹ��ڷ� ��ȯ
from dual;

select upper('SQL Course') -- �빮�ڷ� ��ȯ
from dual;

select initcap('SQL Course') --ù���ڸ� �빮�ڷ� ��ȯ
from dual;

select last_name
from employees
where last_name = 'higgins';
--�� �Ʒ� �ٸ� ������
select last_name
from employees
where last_name = 'Higgins';

select last_name
from employees
where lower(last_name) = 'higgins';

select concat('Hello', 'world') --���̱�
from dual;
                        --index, length�� ù��°���ڰ� 1��°
select substr('HelloWorld', 2, 5)
from dual;

select substr('Hello',-1, 1)
from dual;

select length('Hello')
from dual;
                --ó������ �߰ߵ� index�� ã�� ������
select instr('Hello', 'l')
from dual;

select instr('Hello', 'w')
from dual;

select lpad(salary, 5, '*') --�������� 5�ڸ� 5�ڸ��� �ƴϸ� *�� ä��ڴ�
from employees;

select rpad(salary, 5, '*')
from employees;

select replace('JACK and Jue', 'J', 'BL') --J�� BL�� �ٲٰڴ�
from dual;

select trim('H' from 'Hello') --H�� ����
from dual;

select trim('l' from 'Hello') --I�� ���������� trim�� �հ� ���� ���Ű���
from dual;

--���� ��query���� ''�� ���ŉ�ٴ°� ǥ���ض�
select trim(' ' from ' Hello ') 
from dual;

select '|' || trim(' ' from ' Hello ') || '|'
from dual;

select trim(' Hello World ')
from dual;
-------------------------------------------------
--���� �Ʒ� ������ like�� �����϶�.
select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where substr(job_id, 4) = 'PROG';    

select employee_id, concat(first_name, last_name) name,
    job_id, length(last_name), instr(last_name, 'a') "Contains 'a'?"
from employees
where job_id like '%PROG';

--���� �̸��� J�� A�� M���� �����ϴ� ������� �̸�, �̸��� ���ڼ��� ��ȸ�϶�
-- �̸��� ù���ڴ� �빮��, �������� �ҹ��ڷ� ����϶�

select initcap(last_name), length(last_name)
from employees
where last_name like 'j%' or last_name like 'A%' or last_name like 'M%';

  

------------------------------------
--���ڸ� �ٷ�� Function
--(�ݿø�)�պκ��� ��, �޺κ��� �Ҽ����ڸ�
select round(45.926, 2) 
from dual;

--����
select TRUNC(45.926, 2)
from dual;

select mod(1600, 300)  --������
from dual;

select round(45.923, 0), round(45.923)
from dual;
select trunc(45.923, 0), trunc(45.923)
from dual;



-----------------------------

--������� �̸�, ����, 15.5% �λ�� ����(New Salary, ����)�� ��ȸ�϶�
select last_name, salary, round(salary * 1.155) "New Salary", 
    round(salary * 0.155) "Increase"
from employees;

-------------
--��¥�� �ٷ�� �Լ�
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
--�ټӳ���� ��ȸ�϶�
select last_name, round((sysdate - hire_date)/365)
from employees
where department_id = 90;

--������ ���ϱ�
select months_between('2022/12/31', '2021/12/31')
from dual; --�տ� �Ķ���Ͱ� ū��¥, �ڿ��� ������¥

--1���� �ڸ� ���϶�
select add_months('2022/07/14', 1)
from dual;

--�Ͽ����� 1 ~ ������� 7 (������ ������ �����ΰ�)
select next_day('2022/07/14', 'thursday')
from dual;

--���� ��������
select last_day('2022/07/14')
from dual;

--����] 20�� �̻� ������ ������� �̸�, ù �������� ��ȸ�϶�
--������ �ſ� ���Ͽ� �����Ѵ�.
select last_name, last_day(hire_date)
from employees
where months_between(sysdate, hire_date) >= 12 * 20;

--����] ������� �̸�, ���ޱ׷����� ��ȸ�϶�
--      �׷����� 1000�޷��� *�ϳ��� ǥ���Ѵ�
--�� ���ڸ��� ���ڸ��� �����ϹǷ� +1�� ���ش�
select last_name, rpad(' ', salary/1000 + 1, '*') "grape"
from employees
order by 2 desc; --��������

