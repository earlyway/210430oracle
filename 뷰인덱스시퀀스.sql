--최초 create, 두번째부터는 replace
create or replace view test_view
as
select empno, ename, e.deptno, dname
from emp e, dept d
where e.deptno=d.deptno;
--from절에는 테이블 or 뷰가 위치함.
select*from test_view;
--테이블과 뷰의 목록
select*from tab;
--뷰의 상세정보
select*from user_views;




--ㅇ인덱스
--pk에는 idx가 설정되어있음
--F10 누르면 실행계획 보기
select empno,ename from emp where empno=7900;
--인덱스가 없는 필드.
select empno,ename from emp where ename='송기성';
--인덱스추가 create index 인덱스이름 on 테이블(필드이름)
create index emp_ename_idx on emp(ename);

--unique scan--pk의 경우 중복값이 없으므로 unique scan으로 처리됨
--range scan--pk가 아닌 경우 range scan
--full scan--모든 레코드를 검사. 그러므로 속도가 느림.

--인덱스를 사용하여 검색
select empno, ename from emp where ename='송기성';
--인덱스 제거, 제거하면 위의 '송기성' select문을 실행했을때 옵션이 range scan으로 바뀔것임. 다시 drop하면 full scan.
drop index emp_ename_idx;






create table emp3(
no number,
name varchar2(10),
sal number
);

declare--선언부
    i number:=1; --변수 자료형 := 초기값;
    name varchar(20) :='kim';
    sal number :=0;
begin --실행부
    while i<=100000 loop--조건문(반복)
    if i mod 2=0 then-- mod--->>나머지. if 2로나눈 나머지가 0이면..
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



--인덱스가 없는 상태에서의 조회, full scan
select*from emp3 where name='shin691' and sal>200;
--복합인덱스 생성(2개의 필드를 같이 묶어서 인덱스 생성.)
create index emp_name_idx on emp3(name,sal);
--인덱스를 추가한 후 F10을 눌러 option을 체크하면 full이 range scan으로 바뀜.--->>cost가 대폭감소됨. 신속한 검색조회가 가능해짐.
select*from emp3 where name='shin691' and sal>200;
--인덱스 정보조회
select*from user_indexes where table_name='EMP3';
--복합인덱스는 and연산에서는 작동하지만 or연산에서는 작동하지않음-->>F10을 누르면 and연산에서는 range scan. or연산에서는 full scan.
select*from emp3 where name like 'park1111%' and sal>300;
select*from emp3 where name like 'park1111%' or sal>300;



create table emp4(
no number primary key,
name varchar2(10),
sal number
);
--인덱스 확인, primary key필드는 인덱스가 자동으로 만들어짐
select*from user_indexes where table_name='EMP4';
--emp3테이블에 primary key추가. 인덱스도 생성됨
alter table emp3 add constraint emp3_no_pk primary key(no);
select*from user_indexes where table_name='EMP3';
--primary key를 이용하여 검색하면 자동정렬(오름차순)됨.
select*from emp3 where no>90000;
alter table emp3 drop constraint emp3_no_pk;--인덱스를 제거
select*from user_indexes where table_name='EMP3';
select*from emp3 where no>90000;--자동정렬되지않음





create table bankk(
accountnumb varchar2(100) not null primary key,
bankname varchar2(20) not null,
userid varchar2(15) not null,
fee number not null
);

insert into bankk values('110-12-1156-10','신한','김',10000);
insert into bankk values('110-20-6851-83','신한','박',80000);

select*from bankk;





--시퀀스 생성
--200부터 시작, 1씩 증가, 최대값 100000, 캐쉬사용 안함, 순환안함
drop sequence c_emp_seq;
create sequence c_emp_seq
start with 200 --시작값
increment by 1; --증가값
--시퀀스.nextval 다음번호 발급
select c_emp_seq.nextval from dual;
--시퀀스.currval 현재번
select c_emp_seq.currval from dual;

delete from c_emp;
--시퀀스에서 번호를 발급받은 후, 레코드가 저장됨
insert into c_emp values(c_emp_seq.nextval,'kim2',3000,'010-1111-2222',10);
select *from c_emp;

--테이블 만들기
create table test(
idx number primary key,
writer varchar2(50) not null
);
--idx필드의 최대값에 +1, 레코드가 없으므로 null
select max(idx)+1 from test;
--nvl(a,b) a가 null이면 b
select nvl(max(idx)+1,1) from test;
--먼저 select명령어를 실행하여 번호를 계산한 후 레코드가 저장됨
insert into test values(1,'kimmy');
insert into test values ((select nvl(max(idx)+1,1) from test),'kimmy');
delete from test;
select*from test;

----------------------------------------------------
--c_emp테이블을 복사한 v_emp테이블.
create table v_emp as select *from c_emp where 1=0;
--v_emp 테이블에 데이터입력시 sequence를 이용해서 id를 입력하도록.
--206에서 시작하여 1씩증가되고 최대값은 999로 설정하여 sequence를 생성하시오.
create sequence v_emp_seq
start with 206 --시작값
increment by 1; --증가값
maxvalue 999;

--sequence를 이용해서 사번을 입력하고 이름 김철수, 부서 10번부서로 배치하여 데이터를 입력하시오.
insert into v_emp(id, name, dept_id) values (v_emp_seq.nextval,'김철수',10);
delete from v_emp;
select*from v_emp;