--����
--�ʵ��id �ڷ���numb(������5)
create table t_emp(
id number(5) not null,
name varchar2(35),
salary number(7,2),--��ü 7�ڸ�, �Ҽ����ϴ� 2�ڸ�
phone varchar2(15),
dept_name varchar2(25)
);
--rename A to B
rename t_emp to s_emp;

insert into s_emp values (100,'��',2000,'010-111-2222','���ߺ�');
insert into s_emp values (101,'��',3000,'010-555-9999','�ѹ���');
insert into s_emp values (102,'��',4000,'010-777-2333','������');
--alter table ���̺� add �ʵ�� �ڷ���-->>���ο� �ʵ� �߰�
alter table s_emp add hire_date date;  --�ʵ� �߰�
alter table s_emp modify phone varchar2(20);--������ ����
alter table s_emp rename column id to t_id;--�ʵ��̸� ����
alter table s_emp drop column dept_name;--�ʵ� ����
--update ���̺� set �ʵ�=�� where ����
update s_emp set hire_date=sysdate where t_id=100;
update s_emp set hire_date=sysdate where t_id=101;
update s_emp set hire_date=sysdate where t_id=102;
--���̺� ���ϴ� �ʵ�� ����� �߰�.
insert into s_emp(t_id,hire_date) values (400,sysdate);

alter table s_emp add mailid varchar2(10);--�ʵ� �߰�
alter table s_emp modify mailid varchar2(20);--������ ����
alter table s_emp rename column mailid to e_mail;--�ʵ��̸� ����
rename s_emp to t_emp;

select*from t_emp;





--���������� ���� ���̺�
create table c_emp(
id number(5),
name varchar2(25),
salary number(7,2),
phone varchar2(15),
dept_id number(7)
);

insert into c_emp (id,name) values(1,'��ö��');
insert into c_emp (id,name) values(1,'���ö');
insert into c_emp (id,name) values(1,'��ö��');

alter table c_emp add constraint c_emp_id_pk primary key(id);
select*from c_emp;
delete from c_emp;

--alter table ���̺� add constraint ���������̸� ������������(����� �ʵ�)
alter table add constraint c_emp_id_pk primary key(id);
--�������� ��ȸ
select*from user_constraint where table_name='C_EMP';
insert into c_emp(id,name) values(1,'��ö��');
insert into c_emp(id,name) values(null,'��ö��');
insert into c_emp(id,name) values(1,'���ö');



drop table c_emp;

create table c_emp(
id number(5) constraint c_emp_id_pk primary key,
name varchar2(25),
salary number(7,2),
phone varchar2(15),
dept_id number(7)
);

insert into c_emp(id,name) values(1,'��ö��');
insert into c_emp(id,name) values(null,'��ö��');
insert into c_emp(id,name) values(1,'���ö');




drop table c_emp;

create table c_emp(
id number(5) ,
name varchar2(25),--check ��������, �Է°��� ������ ����. c_emp_salary_ck�� ���������� �̸�.
salary number(7,2) constraint c_emp_salary_ck check(salary between 100 and 1000),
phone varchar2(15),
dept_id number(7)
);

insert into c_emp(id,name,salary) values(1,'kim',500);
--������ ��� ��(100~1000)�� �߻��ϸ� ������ �߻��ϵ���.
insert into c_emp(id,name,salary) values(2,'park',1500);--����





--�μ��ڵ忡 50�� �Է�
select*from dept;
insert into emp(empno,ename,job,hiredate,sal,deptno)values
(9999,'hong','����','2017-03-01',500,50);

drop table c_emp;
--references ���̺�(�ʵ�)
create table c_emp(
id number(5) ,
name varchar2(25),
salary number(7,2),
phone varchar2(15),
dept_id number(7) constraint c_emp_deptid_fk references dept(deptno)
);

insert into c_emp(id,name,dept_id)values(1,'kim',10);
insert into c_emp(id,name,dept_id)values(2,'park',50);--���� �߻�






drop table c_emp;

create table c_emp(
id number(5) ,
name varchar2(25) constraint c_emp_name_un unique,
salary number(7,2),
phone varchar2(15),
dept_id number(7)
);
insert into c_emp(id,name) values(1,'kim');
insert into c_emp(id,name) values(2,'kim');--���� �߻� ORA-00001: unique constraint (HR.C_EMP_NAME_UN) violated
insert into c_emp(id,name) values(3,null);--null�� ���
select*from c_emp;







