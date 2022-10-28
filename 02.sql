--where
--���ǹ�
select employee_id, last_name, department_id
from employees
where department_id = 90; --�����μ�ã��

--���� 176�� ����� �̸��� �μ���ȣ�� ��ȸ�϶�
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
where salary <= 3000; --������ 3000�����λ���� ã�ƶ�

--���� $12,000 �̻� ���� ������� �̸�, ������ ��ȸ�϶�
select last_name, salary
from employees
where salary >= 12000;

SELECT last_name, job_id
from employees
where job_id != 'IT_PROG'; --it programer�� �ƴѻ���� ã�ƶ�

----------------------
--���� ���ǹ�
select last_name, salary
from employees
where salary between 2500 and 3500; --2500�̻� 3500����

select first_name, last_name, job_id, salary
from employees
where last_name between 'King' and 'Smith';

--���� �̸��� King ����� first name, last name, ���� ������ ��ȸ�϶�

select first_name, last_name, job_id, salary
from employees
where last_name = 'King'; --�����ʹ� ��ҹ��ڸ� �����Ѵ�.

select last_name, hire_date
from employees
where hire_date between '02/01/01' and '02/12/31';

------------------

select employee_id, last_name, manager_id
from employees
where manager_id in (100, 101, 201); --100���Ŵ����� ����,101~~

--��������
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
where first_name like 'S%'; --S�� �����ϴ� �̸�ã��

select first_name
from employees
where first_name like '%r';

--���� �̸��� s�� ���Ե� ������� ��ȸ�϶�
select last_name
from employees
where last_name like '%s%';

--���� 2005�⿡ �Ի��� ������� �̸�, �Ի����� ��ȸ�϶�
select last_name, hire_date
from employees
where hire_date like('2005/%/%'); --'2005%';�� ����

select last_name
from employees   --������ �˻��Ҷ� like
where last_name like 'K___';  --K�� �����ϴ� 4�ڸ����� �̸��� ã���� _�ϳ��� ��ĭ

--���� �̸��� �ι��� ���ڰ� o�λ���� �̸��� ��ȸ
select last_name
from employees
where last_name like '_o%';

select job_id
from employees;

select last_name, job_id
from employees
where job_id like 'I_\_%' escape '\'; --\�� �Ϲݹ��ڷ� �ٲ��ش�

select last_name, job_id
from employees
where job_id like 'I_[_%' escape '[';

--���� ������ _R�� ���Ե� ����� �̸�, ������ ��ȸ
select last_name, job_id
from employees
where job_id like '%\_R%' escape '\';

-------------------------------------

select employee_id, last_name, manager_id
from employees;

select last_name, manager_id
from employees
where manager_id = null; --�����ڰ� ���Ե� ���Ŀ��� �Ѵ� null���̶� null���� ã���� ����

select last_name, manager_id
from employees
where manager_id is null; -- =�� is�� ǥ���ϸ� ���̳��´�

----------------------------------------

select last_name, job_id, salary
from employees
where salary > 5000 and job_id like '%IT%';

select last_name, job_id, salary
from employees
where salary > 5000 or job_id like '%IT%';

--���� ������ 5000�޷��̻� 12000�����̰� 
--20���̳� 50�� �μ����� ���ϴ»���� �̸�,
select last_name, salary, department_id
from employees
where (salary between 5000 and 12000)and 
    department_id in(20, 50);
    
--���� �̸��� a�� e�� ���Ե� ����� �̸��� ��ȸ
select last_name
from employees
where last_name like '%a%' and last_name like '%e%';

----------------------------------------

select last_name, job_id
from employees
where job_id not in ('IT_PROG', 'SA_REP'); --���α׷��ӿ� ��������� �ƴ����� ã��

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

--������ 20000�޷� �̻� �޴�, ���� �� ������� �̸�,���� ��ȸ
select last_name, salary
from employees
where not (manager_id is null and salary >= 20000);

--���� ������ ����(SA)�̴� �׸���
--          ������2500, 3500�� �ƴ� ������� �̸�, ����, ������ȸ
select last_name, job_id, salary
from employees
where (job_id like 'SA_%') and not(salary between 2500 and 3500);
----------------------------------------
select last_name, department_id
from employees
order by department_id;  --��������

select last_name, department_id
from employees --order by���� ���� �������� �´�
order by department_id desc; --��������
--100�� �μ����� �Ի��ϼ����� �����ϱ�
select last_name, hire_date
from employees
where department_id = 100
order by hire_date;

select last_name, department_id "dept_id"
from employees
order by 2 desc;  --index�����ε� �Ҽ����� --���� ����

select last_name, department_id, salary
from employees
where department_id > 80
order by department_id asc, salary desc; --n�� ����