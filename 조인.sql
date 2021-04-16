--21.04.16 am10��
--�������
select empno, ename, deptno from emp;

--�μ�����
select*from dept;
--���̺�, �ʵ��
select empno, ename, emp.deptno, dname
from emp, dept--������ ���̺��
where emp.deptno=dept.deptno;--���� ����

select empno, ename, e.deptno, dname
from emp e, dept d--������ ���̺�� --alias Ȱ��
where e.deptno=d.deptno;--���� ����

select empno, ename, e.deptno, dname, sal
from emp e, dept d--������ ���̺�� --alias Ȱ��
where e.deptno=d.deptno and sal>=300;--���� ����







create table product(
product_code varchar2(50) not null primary key,
product_name varchar2(50) not null,
price number default 0, --number ����+�Ǽ�, int ����
company varchar2(50),
make_date date default sysdate
);
insert into product values('a1','������',90,'����','2017-03-01');
insert into product values('a2','�����ó�Ʈ',90,'�Ｚ','2019-03-01');
insert into product values('a3','��������',120,'�Ｚ','2020-03-01');

select*from product;

commit;

create table product_sales(
product_code varchar2(20) not null,
amount number default 0
);
insert into product_sales values ('a1',100);
insert into product_sales values ('a2',200);
insert into product_sales values ('a3',250);
select*from product_sales;


--���� ���̺� ���� �̸��� �ʵ尡 ���� ���, ���̺��̸�.�ʵ��
select p.product_code, product_name, price, amount, price*amount money, make_date 
from product p, product_sales s --join�� ���̺��, ���̺��̸� ��Ī/ ���̺��̸��� �� alias ���
where p.product_code=s.product_code;--join ����


--from A join B on ��������
select p.product_code, product_name, price, amount, price*amount money, make_date 
from product p join product_sales s --join�� ���̺��, ���̺��̸� ��Ī/ ���̺��̸��� �� alias ���
on p.product_code=s.product_code;--���� ����

--��������
select empno, ename, e.deptno, dname
from emp e join dept d on e.deptno=d.deptno;

--�ܺ�����
select empno, ename, e.deptno, dname
from emp e right outer join dept d on e.deptno=d.deptno;
select empno, ename, e.deptno, dname
from dept d left outer join emp e on e.deptno=d.deptno;

select*from dept;

--21.04.16 am11
--create or replace : ���ʿ��� create �ι�°���ʹ� replace(����)
create or replace view product_sales_v --view �� �̸�
as --as ������ sql��ɾ�
select p.product_code, product_name, price, amount, price*amount money, company, make_date 
from product p, product_sales s --join�� ���̺��, ���̺��̸� ��Ī/ ���̺��̸��� �� alias ���
where p.product_code=s.product_code;

select*from product_sales_v;
select*from product_sales_v where company='�Ｚ';

create or replace view emp_v
as
select empno, ename, job, sal, hiredate, comm, (sal*12+nvl(comm,0)) money, dname from emp e, dept d where e.deptno=d.deptno;
select*from emp_v;



--1.emp�� dept���̺��� �����Ͽ� �μ���ȣ,�μ���, �̸�, �޿��� ����Ͻÿ�.
select*from emp;
select*from dept;

select d.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno=d.deptno;
--2.������ ����� ����� �̸�,�μ���ȣ,�μ��̸��� ����Ͻÿ�.
select e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno and e.job='���';
    --ansi����
    
--3.�̸��� Ȳ������ ����� �μ����� ����Ͻÿ�.
select ename, dname
from emp e, dept d
where e.deptno=d.deptno and ename='Ȳ����';
--4.emp���̺� �ִ� empno,mgr�� �̿��Ͽ� ������ ���踦 ������ ���� ����Ͻÿ�. "�������� �Ŵ����� ��äȣ�̴�"
   --self join
select*from emp;

select a.ename||'�� �Ŵ����� '||b.ename||'�̴�'
from emp a, emp b
where a.mgr=b.empno;






select*from student;
select*from department;
drop table subject;
create table subject(
subject_code number not null primary key,
subject_name varchar2(50) not null,
profno number not null,--��米�� ���
point number default 3--������, �⺻���� 3
);
insert into subject values(1,'java',1001,3);
insert into subject values(2,'db',1002,4);
insert into subject values(3,'jsp',1003,2);
insert into subject ( subject_code, subject_name, profno) 
                    values(4,'android',1001);
select*from subject;
--�����ڵ�,�����,��米�� �̸�
select*from professor;
select subject_code, subject_name, name
from professor p, subject s
where p.profno=s.profno;


--�������̺�
create table lecture(
studno number not null,
subject_code number not null,
grade varchar(2),
primary key(studno, subject_code)--2�� �̻��� �ʵ带 ����Ű�� ����� �� ����
);
insert into lecture values(9411,1,'A0');
insert into lecture values(9411,2,'A+');
insert into lecture values(9411,3,'B0');
insert into lecture values(9412,3,'C0');
insert into lecture values(9412,4,'F');
insert into lecture values(9413,2,'B+');
insert into lecture values(9413,3,'A+');
select*from lecture;
--�й�,�̸�,�����,��米��,����,���
select l.studno, st.name sname, subject_name, p.name pname, point, l.grade
                --st.name�� alias->sname      p.name�� alias->pname
from lecture l, student st, subject sb, professor p
where l.studno=st.studno and l.subject_code=sb.subject_code
    and sb.profno=p.profno
    and l.studno=9411;
select studno, name from student;
commit;

create or replace view stud_view
as
select l.studno, st.name sname, subject_name, p.name pname, point, l.grade
                --st.name�� alias->sname      p.name�� alias->pname
from lecture l, student st, subject sb, professor p
where l.studno=st.studno and l.subject_code=sb.subject_code
    and sb.profno=p.profno;

select*from stud_view;

commit;

