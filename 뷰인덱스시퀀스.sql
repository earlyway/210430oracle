--���� create, �ι�°���ʹ� replace
create or replace view test_view
as
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno;
--from������ ���̺� or �䰡 ��ġ��.
select*from test_view;
--���̺�� ���� ���
select*from tab;
--���� ������
select*from user_views;




--���ε���
--pk���� idx�� �����Ǿ�����
--F10 ������ �����ȹ ����
select empno,ename from emp where empno=7900;
--�ε����� ���� �ʵ�.
select empno,ename from emp where ename='�۱⼺';
--�ε����߰� create index �ε����̸� on ���̺�(�ʵ��̸�)
create index emp_ename_idx on emp(ename);

--unique scan--pk�� ��� �ߺ����� �����Ƿ� unique scan���� ó����
--range scan--pk�� �ƴ� ��� range scan
--full scan--��� ���ڵ带 �˻�. �׷��Ƿ� �ӵ��� ����.

--�ε����� ����Ͽ� �˻�
select empno, ename from emp where ename='�۱⼺';
--�ε��� ����, �����ϸ� ���� '�۱⼺' select���� ���������� �ɼ��� range scan���� �ٲ����. �ٽ� drop�ϸ� full scan.
drop index emp_ename_idx;






create table emp3(
no number,
name varchar2(10),
sal number
);

declare--�����
    i number:=1; --���� �ڷ��� := �ʱⰪ;
    name varchar(20) :='kim';
    sal number :=0;
begin --�����
    while i<=100000 loop--���ǹ�(�ݺ�)
    if i mod 2=0 then-- mod--->>������. if 2�γ��� �������� 0�̸�..
        name :='kim' || to_char(i);
        sal :=300;
        elsif i mod 3=0 then
        name :='park' || to_char(i);
        sal :=400;
        elsif i mod 5=0 then
        name :='hong' || to_char(i);
        sal :=500;
        else
        name :='shin' || to_char(i);
        sal :=250;
    end if;
    insert into emp3 values(i,name,sal);
    i := i+1;
    end loop;
end;
/

select*from emp3;
select count(*) from emp3;



--�ε����� ���� ���¿����� ��ȸ, full scan
select*from emp3 where name='shin691' and sal>200;
--�����ε��� ����(2���� �ʵ带 ���� ��� �ε��� ����.)
create index emp_name_idx on emp3(name,sal);
--�ε����� �߰��� �� F10�� ���� option�� üũ�ϸ� full�� range scan���� �ٲ�.--->>cost�� �������ҵ�. �ż��� �˻���ȸ�� ��������.
select*from emp3 where name='shin691' and sal>200;
--�ε��� ������ȸ
select*from user_indexes where table_name='EMP3';
--�����ε����� and���꿡���� �۵������� or���꿡���� �۵���������-->>F10�� ������ and���꿡���� range scan. or���꿡���� full scan.
select*from emp3 where name like 'park1111%' and sal>300;
select*from emp3 where name like 'park1111%' or sal>300;



create table emp4(
no number primary key,
name varchar2(10),
sal number
);
--�ε��� Ȯ��, primary key�ʵ�� �ε����� �ڵ����� �������
select*from user_indexes where table_name='EMP4';
--emp3���̺� primary key�߰�. �ε����� ������
alter table emp3 add constraint emp3_no_pk primary key(no);
select*from user_indexes where table_name='EMP3';
--primary key�� �̿��Ͽ� �˻��ϸ� �ڵ�����(��������)��.
select*from emp3 where no>90000;
alter table emp3 drop constraint emp3_no_pk;--�ε����� ����
select*from user_indexes where table_name='EMP3';
select*from emp3 where no>90000;--�ڵ����ĵ�������





create table bankk(
accountnumb varchar2(100) not null primary key,
bankname varchar2(20) not null,
userid varchar2(15) not null,
fee number not null
);

insert into bankk values('110-12-1156-10','����','��',10000);
insert into bankk values('110-20-6851-83','����','��',80000);

select*from bankk;





--������ ����
--200���� ����, 1�� ����, �ִ밪 100000, ĳ����� ����, ��ȯ����
drop sequence c_emp_seq;
create sequence c_emp_seq
start with 200 --���۰�
increment by 1; --������
--������.nextval ������ȣ �߱�
select c_emp_seq.nextval from dual;
--������.currval �����
select c_emp_seq.currval from dual;

delete from c_emp;
--���������� ��ȣ�� �߱޹��� ��, ���ڵ尡 �����
insert into c_emp values(c_emp_seq.nextval,'kim2',3000,'010-1111-2222',10);
select *from c_emp;

--���̺� �����
create table test(
idx number primary key,
writer varchar2(50) not null
);
--idx�ʵ��� �ִ밪�� +1, ���ڵ尡 �����Ƿ� null
select max(idx)+1 from test;
--nvl(a,b) a�� null�̸� b
select nvl(max(idx)+1,1) from test;
--���� select��ɾ �����Ͽ� ��ȣ�� ����� �� ���ڵ尡 �����
insert into test values(1,'kimmy');
insert into test values ((select nvl(max(idx)+1,1) from test),'kimmy');
delete from test;
select*from test;

----------------------------------------------------
--c_emp���̺��� ������ v_emp���̺�.
create table v_emp as select *from c_emp where 1=0;
--v_emp ���̺� �������Է½� sequence�� �̿��ؼ� id�� �Է��ϵ���.
--206���� �����Ͽ� 1�������ǰ� �ִ밪�� 999�� �����Ͽ� sequence�� �����Ͻÿ�.
create sequence v_emp_seq
start with 206 --���۰�
increment by 1; --������
maxvalue 999;

--sequence�� �̿��ؼ� ����� �Է��ϰ� �̸� ��ö��, �μ� 10���μ��� ��ġ�Ͽ� �����͸� �Է��Ͻÿ�.
insert into v_emp(id, name, dept_id) values (v_emp_seq.nextval,'��ö��',10);
delete from v_emp;
select*from v_emp;