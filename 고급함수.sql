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
--round(실수, 소수이하자리수)반올림, trunc(실수)소수이하 모두버림
--decode(a,b,c,d,e) a와 b가 같으면 c, a와 d가 같으면 e
select name,kor,eng,mat,(kor+mat+eng) 총점, round((kor+eng+mat)/3,2) 평균,
decode(trunc((kor+eng+mat)/3)/10),10,'A',9,'A',8,'B',7,'C',6,'D','F')등급 from score;


--case when 조건 then 결과.
select name,position,
    case when position='정교수'then(pay+nvl(bonus,0))*1.1
        when postion='조교수'then(pay+nvl(bonus,0))*0.07
        when postion='전임강사'then(pay+nvl(bonus,0))*1.05
        else pay+nvl(bonus,0)
        end 급여
        from professor
        order by 3 desc; --3번째필드를 기준으로 내림차순 정렬 1필드는 name 2필드는 positi, 3필드는 case
        
        
        
        
        
select name, kor, eng, mat, (kor+mat+eng) 총점, round( (kor+eng+mat)/3,2 ) 평균,
 case when (kor+eng+mat)/3 >= 90 then 'A'
        when (kor+eng+mat)/3 >= 80 then 'B'
        when (kor+eng+mat)/3 >= 70 then 'C'
        when (kor+eng+mat)/3 >= 60 then 'D'
        else 'F'
        end 등급
        from score
        order by 등급, 평균 desc;
        
        
        
--동률순위가 있을 경우 다음번호를 건너뜀
select deptno, ename, sal, rank() over(order by sal desc) 급여순위
from emp;
--동률순위가 있을 경우에도 +1
select deptno, ename, sal, dense_rank() over(order by sal desc) 급여순위
from emp;

select deptno, ename, sal, rank() over(partition by deptno order by sal desc) 부서별순위
from emp;
        


--최초 생성, 두번째부터는 수정 create or replace
--create or replace procedure 프로시저 이름(매개변수)
create or replace procedure update_sal(v_empno in number)
is--프로시저 내부에서 사용할 변수 선언부
begin--실행부
update emp
set sal=sal*1.1
where empno=v_empno;
end;
/
--execute 프로시저이름(전달할 값) 프로시저를 실행하는 방법
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
from emp where ename like '_철%' 
order by empno asc;

select empno, ename, sal, nvl(comm,0), sal*12 + nvl(comm,0), deptno
from emp;
comm값을 정해주지않았는데 값을 호출해서 숫자로 계산을 하라해서 null이 나옴.

select*from dept;

select empno, ename, sal, nvl(comm,0), sal*12 + nvl(comm,0), e.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno;



create table proproduct(
procode varchar2(6) primary key,
proname varchar2(20) not null
);
insert into proproduct values('12345','에어컨');
insert into proproduct values('16789','선풍기');
select*from proproduct;
commit;
