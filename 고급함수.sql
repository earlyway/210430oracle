create table score(
student_no varchar2(20) primary key,
name varchar2(20) not null,
kor number(3) default 0,
eng number(3) default 0,
mat number(3) default 0
);
insert into score values('1','kim',90,80,70);
insert into score values('2','park',85,81,75);
insert into score values('3','choi',76,80,90);
insert into score values('4','lee',90,80,70);
insert into score values('5','song',100,80,95);
--round(�Ǽ�, �Ҽ������ڸ���)�ݿø�, trunc(�Ǽ�)�Ҽ����� ��ι���
--decode(a,b,c,d,e) a�� b�� ������ c, a�� d�� ������ e
select name,kor,eng,mat,(kor+mat+eng) ����, round((kor+eng+mat)/3,2) ���,
decode(trunc((kor+eng+mat)/3)/10),10,'A',9,'A',8,'B',7,'C',6,'D','F')��� from score;


--case when ���� then ���.
select name,position,
    case when position='������'then(pay+nvl(bonus,0))*1.1
        when postion='������'then(pay+nvl(bonus,0))*0.07
        when postion='���Ӱ���'then(pay+nvl(bonus,0))*1.05
        else pay+nvl(bonus,0)
        end �޿�
        from professor
        order by 3 desc; --3��°�ʵ带 �������� �������� ���� 1�ʵ�� name 2�ʵ�� positi, 3�ʵ�� case
        
        
        
        
        
select name, kor, eng, mat, (kor+mat+eng) ����, round( (kor+eng+mat)/3,2 ) ���,
 case when (kor+eng+mat)/3 >= 90 then 'A'
        when (kor+eng+mat)/3 >= 80 then 'B'
        when (kor+eng+mat)/3 >= 70 then 'C'
        when (kor+eng+mat)/3 >= 60 then 'D'
        else 'F'
        end ���
        from score
        order by ���, ��� desc;
        
        
        
--���������� ���� ��� ������ȣ�� �ǳʶ�
select deptno, ename, sal, rank() over(order by sal desc) �޿�����
from emp;
--���������� ���� ��쿡�� +1
select deptno, ename, sal, dense_rank() over(order by sal desc) �޿�����
from emp;

select deptno, ename, sal, rank() over(partition by deptno order by sal desc) �μ�������
from emp;
        


--���� ����, �ι�°���ʹ� ���� create or replace
--create or replace procedure ���ν��� �̸�(�Ű�����)
create or replace procedure update_sal(v_empno in number)
is--���ν��� ���ο��� ����� ���� �����
begin--�����
update emp
set sal=sal*1.1
where empno=v_empno;
end;
/
--execute ���ν����̸�(������ ��) ���ν����� �����ϴ� ���
select*from emp;
execute update_sal(7369);
commit;

create or replace procedure data_insert(emp_copy in number)
is begin
insert emp_copy
set 



create or replace procedure del_emp(v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno in varchar)
is begin
delete emp
end;
/
execute delete_emp;





select *from emp;
select min(sal) from emp;
select max(sal) from emp;
select sum(sal) from emp order by job;



select empno, ename, sal
from emp where ename like '_ö%' 
order by empno asc;

select empno, ename, sal, nvl(comm,0), sal*12 + nvl(comm,0), deptno
from emp;
comm���� ���������ʾҴµ� ���� ȣ���ؼ� ���ڷ� ����� �϶��ؼ� null�� ����.

select*from dept;

select empno, ename, sal, nvl(comm,0), sal*12 + nvl(comm,0), e.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno;



create table proproduct(
procode varchar2(6) primary key,
proname varchar2(20) not null
);
insert into proproduct values('12345','������');
insert into proproduct values('16789','��ǳ��');
select*from proproduct;
commit;
