create or replace procedure emp_info(p_empno in emp.empno%type)--변수명 in 자료형.    테이블.필드%type==>필드에 지정된 자료형
is--변수 선언
 v_empno emp.empno%type;
 v_ename emp.ename%type;
 v_sal emp.sal%type;
begin
 select empno,ename,sal into v_empno,v_ename,v_sal from emp
 where empno=p_empno;
 dbms_output.put_line('사번:'||v_empno);
 dbms_output.put_line('이름:'||v_ename);
 dbms_output.put_line('급여:'||v_sal);
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
    dbms_output.put_line('부서코드:'||v_deptno);
    if v_deptno=10 then
        dbms_output.put_line('경리팀 사원입니다.');
    elsif v_deptno=20 then
        dbms_output.put_line('연구팀 사원입니다.');
    elsif v_deptno=30 then
        dbms_output.put_line('총무팀 사원입니다.');
    else
        dbms_output.put_line('기타부서팀 사원입니다.');
    end if;
end;
/
select *from dept;
set serveroutput on
execute dept_search(7499);
select*from emp;





declare
    --사용자정의 자료형
type ename_table
    is table of emp.ename%type index by binary_integer;
type sal_table
    is table of emp.sal%type index by binary_integer;
    --사용자정의 자료형으로 만든 변수(ename_tab과 sal_tab)
    ename_tab ename_table;
    sal_tab sal_table;
    i binary_integer:=0;
begin
    --for 개별 레코드 in 레코드셋
    for emp_row in(select ename,sal from emp)loop
    i:=i+1;--카운트 증가 처리
    ename_tab(i):=emp_row.ename;
    sal_tab(i):=emp_row.sal;
    end loop;
    for cnt in 1 .. i loop--카운트변수 in start .. end
     dbms_output.put('이름:'||ename_tab(cnt)||',');
     dbms_output.put_line('급여:'|| sal_tab(cnt));
    end loop;
end;
/
select*from emp;


delete from emp where empno>=9010;

declare--변수 선언부
    v_cnt number:=9010;
begin
    loop--반복문 시작
        v_cnt:=v_cnt+1;
        insert into emp(empno,ename,hiredate)values
        (v_cnt,'test'||v_cnt,sysdate);
        exit when v_cnt>=9100;--반복문 탈출조건
    end loop;--반복분 종료
    dbms_output.put_line(v_cnt-9010||'개의 레코드가 입력되었습니다.');
end;
/


delete from emp where empno>=9050;

declare
    cnt number := 9050;
begin
    while cnt<9060 loop--조건식이 true이면 반복.
        insert into emp(empno,ename,hiredate)values
        (cnt,'test',sysdate);
        cnt := cnt+1;--카운트 증가 처리.
    end loop;
    dbms_output.put_line(cnt-9050||'개의 레코드가 입력되었습니다.');
end;
/



--커서
create or replace procedure cursor_test(p_empno number)
is
    v_sal number;
    v_update_row number;
begin
    select sal into v_sal from emp where empno=p_empno;
    if sql%found then
        dbms_output.put_line('급여:'||v_sal);
    end if;
    update emp set sal=sal*1.1 where empno=p_empno;
    v_update_row:=sql%rowcount;
    dbms_output.put_line('급여가 인상된 사원수:'||v_update_row);
exception
    when NO_DATA_FOUND then
        dbms_output.put_line('잘못된 사번입니다.');
    when others then
        dbms_output.put_line('기타 예외 발생');
    end;
/
execute cursor_test(7);



delete from cursor_test2;

create or replace procedure cursor_test2(v_deptno number)
is
    cursor dept_avg is--커서 선언. cursor 커서이름 is query
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
    dbms_output.put_line('부서명:'|| v_dname);
    dbms_output.put_line('사원수:'|| emp_cnt);
    dbms_output.put_line('평균급여:'|| sal_avg);
    
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
    cursor dept_avg is--커서 변수 선언
        select dname, count(empno) cnt, round(avg(sal),1) salary
        from emp e, dept d
        where e.deptno=d.deptno
        group by dname;
begin
    for emp_row in dept_avg loop --cursor open, fetch, close 명령어가 생략되어 있음
        dbms_output.put_line('부서명:'|| emp_row.dname);
         dbms_output.put_line('사원수:'|| emp_row.cnt);
          dbms_output.put_line('평균급여:'|| emp_row.salary);
    end loop;
end;
/
--콘솔 출력을 활성화.
set serveroutput on
--저장 프로시저를 실행
execute cursor_test3;