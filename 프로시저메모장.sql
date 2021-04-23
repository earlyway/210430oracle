create table memo(--���̺� �����
idx number primary key,
writer varchar2(50) not null,
memo varchar2(500) not null,
post_date date default sysdate
);
--������ ����(�ڵ�ȭ�� ����)
create sequence memo_seq--������ �̸�
start with 1
increment by 1
nomaxvalue;--������ ����
--������.nextval ������ȣ �߱�
insert into memo(idx,writer,memo)values(memo_seq.nextval,'kim','memo');
insert into memo(idx,writer,memo)values(memo_seq.nextval,'park','memo2');

--���̺� ���ο� �ʵ� ip �߰�
alter table memo add ip varchar2(50);
select*from memo;
desc memo;--���̺��� �ʵ��� Ȯ��
--���ν��� ����
create or replace procedure
memo_insert(v_writer in varchar, v_memo in varchar,v_ip in varchar)
is
begin
    insert into memo(idx,writer,memo,ip)
    values(memo_seq.nextval, v_writer, v_memo, v_ip);
end;
/
--���ν��� ����
execute memo_insert('��ö��','�޸�...','192.168.0.10');
select*from memo;
--�����ͻ���(user_source)�� ����� ���ν��� ����Ȯ��
select*from user_source where name='MEMO_INSERT';
commit;






create table members(
userid varchar2(20) not null primary key,
pwd varchar2(30) not null,
username varchar2(20) not null
);
insert into members values('kim123','1234','��ö��');
insert into members values('seo222','1111','��ö��');
select*from members;
commit;



                        --���ν����̸� ememo_list
create or replace procedure memo_list(v_row out sys_refcursor)
                                --�Ű����� �̸��� v_row
is
begin
    open v_row for
        select idx,writer,memo,post_date,ip
        from memo
        order by idx desc;
    end;
    /
--���ν����� ������ �� ���������� �Ű����� a(:a)�� ���ϵ�
execute memo_list(:a);
--�����ͻ����� ����� ���ν��� ���� Ȯ��
select*from user_source where name='MEMO_LIST';
    commit;
    
    

create or replace function fn_update_sal(v_empno number)
return number--���� �ڷ���
is
    v_sal number;
begin
    update emp set sal=sal*1.1 where empno=v_empno;
    select sal into v_sal from emp
    where empno=v_empno;--�ʵ� into ����
    return v_sal;--�Լ��� ȣ���� ������ ���� ����
    end;
/

select sal from emp where empno=7369;
select fn_update_sal(7369)from dual;
select empno,ename,sal,sal*1.1,fn_update_sal(empno)from emp;
desc dual;
select sysdate from dual;
--���� ����
-- ���� := ������ ���� ����, :����--->�Ű�����
--print���� - �������� �ֿܼ� ���
--execute : ���� :=�Լ�(�Է°�)
var salary number;
execute :salary :=fn_update_sal(7369);
print salary;

commit;