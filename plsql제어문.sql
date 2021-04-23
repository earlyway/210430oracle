create or replace procedure emp_info(p_empno in emp.empno%type)--������ in �ڷ���.    ���̺�.�ʵ�%type==>�ʵ忡 ������ �ڷ���
is--���� ����
 v_empno emp.empno%type;
 v_ename emp.ename%type;
 v_sal emp.sal%type;
begin
 select empno,ename,sal into v_empno,v_ename,v_sal from emp
 where empno=p_empno;
 dbms_output.put_line('���:'||v_empno);
 dbms_output.put_line('�̸�:'||v_ename);
 dbms_output.put_line('�޿�:'||v_sal);
end;
/

set serveroutput on
execute emp_info(7369);




create or replace procedure dept_search(p_empno in number)
is
    v_deptno number;
begin
    select deptno into v_deptno from emp
    where empno=p_empno;
    dbms_output.put_line('�μ��ڵ�:'||v_deptno);
    if v_deptno=10 then
        dbms_output.put_line('�渮�� ����Դϴ�.');
    elsif v_deptno=20 then
        dbms_output.put_line('������ ����Դϴ�.');
    elsif v_deptno=30 then
        dbms_output.put_line('�ѹ��� ����Դϴ�.');
    else
        dbms_output.put_line('��Ÿ�μ��� ����Դϴ�.');
    end if;
end;
/
select *from dept;
set serveroutput on
execute dept_search(7499);
select*from emp;





declare
    --��������� �ڷ���
type ename_table
    is table of emp.ename%type index by binary_integer;
type sal_table
    is table of emp.sal%type index by binary_integer;
    --��������� �ڷ������� ���� ����(ename_tab�� sal_tab)
    ename_tab ename_table;
    sal_tab sal_table;
    i binary_integer:=0;
begin
    --for ���� ���ڵ� in ���ڵ��
    for emp_row in(select ename,sal from emp)loop
    i:=i+1;--ī��Ʈ ���� ó��
    ename_tab(i):=emp_row.ename;
    sal_tab(i):=emp_row.sal;
    end loop;
    for cnt in 1 .. i loop--ī��Ʈ���� in start .. end
     dbms_output.put('�̸�:'||ename_tab(cnt)||',');
     dbms_output.put_line('�޿�:'|| sal_tab(cnt));
    end loop;
end;
/
select*from emp;


delete from emp where empno>=9010;

declare--���� �����
    v_cnt number:=9010;
begin
    loop--�ݺ��� ����
        v_cnt:=v_cnt+1;
        insert into emp(empno,ename,hiredate)values
        (v_cnt,'test'||v_cnt,sysdate);
        exit when v_cnt>=9100;--�ݺ��� Ż������
    end loop;--�ݺ��� ����
    dbms_output.put_line(v_cnt-9010||'���� ���ڵ尡 �ԷµǾ����ϴ�.');
end;
/


delete from emp where empno>=9050;

declare
    cnt number := 9050;
begin
    while cnt<9060 loop--���ǽ��� true�̸� �ݺ�.
        insert into emp(empno,ename,hiredate)values
        (cnt,'test',sysdate);
        cnt := cnt+1;--ī��Ʈ ���� ó��.
    end loop;
    dbms_output.put_line(cnt-9050||'���� ���ڵ尡 �ԷµǾ����ϴ�.');
end;
/



--Ŀ��
create or replace procedure cursor_test(p_empno number)
is
    v_sal number;
    v_update_row number;
begin
    select sal into v_sal from emp where empno=p_empno;
    if sql%found then
        dbms_output.put_line('�޿�:'||v_sal);
    end if;
    update emp set sal=sal*1.1 where empno=p_empno;
    v_update_row:=sql%rowcount;
    dbms_output.put_line('�޿��� �λ�� �����:'||v_update_row);
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('�߸��� ����Դϴ�.');
    when others then
        dbms_output.put_line('��Ÿ ���� �߻�');
    end;
/
execute cursor_test(7);



delete from cursor_test2;

create or replace procedure cursor_test2(v_deptno number)
is
    cursor dept_avg is--Ŀ�� ����. cursor Ŀ���̸� is query
        select dname, count(empno) cnt,round(avg(sal),1)salary
        from emp e, dept d
        where e.deptno=d.deptno
        and e.deptno=v_deptno
        group by dname;
        v_dname varchar(50);
        emp_cnt number;
        sal_avg number;
begin
    open dept_avg;
    fetch dept_avg into v_dname,emp_cnt,sal_avg;
    dbms_output.put_line('�μ���:'|| v_dname);
    dbms_output.put_line('�����:'|| emp_cnt);
    dbms_output.put_line('��ձ޿�:'|| sal_avg);
    
    close dept_avg;
end;
/
execute cursor_test2(10);



create table userlist(
userid varchar2(20) not null primary key,
userpwd varchar2(30) not null
);
insert into userlist values ('kim','1234');
insert into userlist values ('hong','1111');

select*from userlist;
commit;








create or replace procedure cursor_test3
is
    cursor dept_avg is--Ŀ�� ���� ����
        select dname, count(empno) cnt, round(avg(sal),1) salary
        from emp e, dept d
        where e.deptno=d.deptno
        group by dname;
begin
    for emp_row in dept_avg loop --cursor open, fetch, close ��ɾ �����Ǿ� ����
        dbms_output.put_line('�μ���:'|| emp_row.dname);
         dbms_output.put_line('�����:'|| emp_row.cnt);
          dbms_output.put_line('��ձ޿�:'|| emp_row.salary);
    end loop;
end;
/
--�ܼ� ����� Ȱ��ȭ.
set serveroutput on
--���� ���ν����� ����
execute cursor_test3;