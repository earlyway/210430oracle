select*from emp order by empno;
--distinct �ߺ����� ����
select*from distinct job from emp;
select all job from emp;
----desc�� ��������, asc�� ��������
select*from emp order by job, sal desc;
--alias, �ʵ� as ��Ī, as �� ��������
select ename �̸�, job ����, sal �޿�
from emp
order by job, sal desc;
select*from emp


select * from emp
where not(sal>100 and sal<400) --not ���� not~and~
order by sal desc;

select deptno, sal, ename from emp
where deptno in(10,20,40);--deptno�� 10,20,40 �߿� ���ԵǴ���
select deptno, sal, ename from emp
where deptno=10 or deptno=20 or deptno=40;

select deptno, sal, ename from emp
where deptno=any(10,20,40);--any(����)���߿� �ּ� 1���� ������


select ename, sal from emp
where sal between 300 and 500;--between A and B :A~B

select ename form emp
where ename like '��%';--like Ű����% Ű����� �����ϴ� �����.

select ename from emp
where ename like'%��%'; --%��% ��ġ�� �������

select ename from emp
where ename like '_ö%'; --���� 1���� ����

select ename, comm from emp where comm is null;--null���� ��
select ename, comm from emp where comm=null;
--A||B, A�� B�� �����Ű�� ������. java������ +���
select ename ||'�� �޿��� '||sal||'�Դϴ�.' from emp;
--()�� ������ ���� ����ó��
select empno, sal from emp where not(sal>200 and sal<300);
select empno, sal from emp where not sal>200 and sal<300;

select ename,hiredate,deptno from emp 
where hiredate<'2005-01-01' order by hiredate;
                              --order by ~ ~�� ���ı���  

select ename,job, deptno from emp
where deptno in(20,30) order by ename;
--select �ʵ�
--from ���̺�
--where ����
--order by ���ı���