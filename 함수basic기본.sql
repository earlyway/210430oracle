--char(�����ڵ�) ���ڿ� �ش��ϴ� �����ڵ带 ����, dual-->�׽�Ʈ�� ���� ���� ���̺�(����)
select*from dual;
select chr(65) from dual;

--ascii(����) ������ �����ڵ带 ����
select ascii('A') from dual;
--concat(A,B) A�� B�� �����Ŵ
select concat(ename, '�� ��å�� '), job from emp;

select ename ||'�� ��å�� ', job from emp;
--lpad(���ڿ�,����,ä�ﰪ)
select lpad('abcd',9,'*') from dual;
--ltrim ���� ���� ����
select ltrim ('    abcd   ','   ') from dual;
select ltrim('####abcd###','#') from dual;
--rtrim ���� ���� ����
select rtrim('     abcd    ','   ') from dual;
--replace(���ڿ�,A,B) ���ڿ����� A�� ã�Ƽ� B�� ��ȯ.
select replace('asiancup','asian','world') from dual;
--substr(���ڿ�,���� �ڸ���, ���ڼ�)
select substr('�ڹٰ����� ����',4,3) from dual;





--�ý����� ���糯¥
select sysdate from dual;

select sysdate+100 from dual; --100�� ��
select sysdate-20 from dual; --20�� ��
select add_months(sysdate,3) from dual;--3���� ��
sleect add_months(hiredate, 5) from emp;--ȸ���Ի� �� 5������ ��¥
--���� ������ ��¥ ���
select last_day('2021-03-15') from dual;
--months_between(A,B) A-B ����
--round(����, �Ҽ� �����ڸ���) �ݿø�
select months_between('2021-03-15','2021-04-30')from dual;
select round(months_between('2021-04-30','2021-04-15'),2) from dual;


--��¥�� ���ڿ� �������� ���
select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;
--���ڿ��� ���ڴ� ������ �� ����, ���ڰ� ���ڷ� �ڵ� ��ȯ��
select '100'+1 from dual;
select to_number('100')+1 from dual;
--���ڸ� ��¥�������� �ٲٴ� �Լ�
select to_date('2021-03-01','yyyy-mm-dd') from dual;

select (sysdate-hiredate)/365 from emp;
select round((sysdate-hiredate)/365,2)from emp;--�ݿø�
select ceil((sysdate-hiredate)/365) from emp;--�ø�
select trunc((sysdate-hiredate)/365)from emp;--����



--bonus�� null�� ��� ��Ȯ�� ����� �����ʴ� ������ �߻���.
select name,pay,bonus,(pay*12+bonus) from professor;
--NVL(A,B) A�� null�̸� B
select name,pay,bonus,(pay*12+nvl(bonus,0)) from professor;

select ename,sal,comm,(sal*12+nvl(comm,0)) from emp;

--decode(A,B,������,�ٸ���)
select name, deptno, decode(deptno, 101, '�İ���',102,'��Ƽ�а�') from professor;

