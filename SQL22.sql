select*from emp order by empno;
--distinct 중복값을 제거
select*from distinct job from emp;
select all job from emp;
----desc는 내림차순, asc는 오름차순
select*from emp order by job, sal desc;
--alias, 필드 as 별칭, as 는 생략가능
select ename 이름, job 직급, sal 급여
from emp
order by job, sal desc;
select*from emp


select * from emp
where not(sal>100 and sal<400) --not 부정 not~and~
order by sal desc;

select deptno, sal, ename from emp
where deptno in(10,20,40);--deptno가 10,20,40 중에 포함되는지
select deptno, sal, ename from emp
where deptno=10 or deptno=20 or deptno=40;

select deptno, sal, ename from emp
where deptno=any(10,20,40);--any(집합)이중에 최소 1개와 같은지


select ename, sal from emp
where sal between 300 and 500;--between A and B :A~B

select ename form emp
where ename like '성%';--like 키워드% 키워드로 시작하는 내용들.

select ename from emp
where ename like'%성%'; --%성% 위치에 관계없음

select ename from emp
where ename like '_철%'; --밑줄 1개의 문자

select ename, comm from emp where comm is null;--null과의 비교
select ename, comm from emp where comm=null;
--A||B, A와 B를 연결시키는 연산자. java에서의 +기능
select ename ||'의 급여는 '||sal||'입니다.' from emp;
--()로 묶으면 먼저 연산처리
select empno, sal from emp where not(sal>200 and sal<300);
select empno, sal from emp where not sal>200 and sal<300;

select ename,hiredate,deptno from emp 
where hiredate<'2005-01-01' order by hiredate;
                              --order by ~ ~가 정렬기준  

select ename,job, deptno from emp
where deptno in(20,30) order by ename;
--select 필드
--from 테이블
--where 조건
--order by 정렬기준