--21.04.16 am10ㅁ
--사원정보
select empno, ename, deptno from emp;

--부서정보
select*from dept;
--테이블, 필드명
select empno, ename, emp.deptno, dname
from emp, dept--조인할 테이블들
where emp.deptno=dept.deptno;--조인 조건

select empno, ename, e.deptno, dname
from emp e, dept d--조인할 테이블들 --alias 활용
where e.deptno=d.deptno;--조인 조건

select empno, ename, e.deptno, dname, sal
from emp e, dept d--조인할 테이블들 --alias 활용
where e.deptno=d.deptno and sal>=300;--조인 조건







create table product(
product_code varchar2(50) not null primary key,
product_name varchar2(50) not null,
price number default 0, --number 정수+실수, int 정수
company varchar2(50),
make_date date default sysdate
);
insert into product values('a1','아이폰',90,'애플','2017-03-01');
insert into product values('a2','갤럭시노트',90,'삼성','2019-03-01');
insert into product values('a3','갤럭시탭',120,'삼성','2020-03-01');

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


--양쪽 테이블에 같은 이름의 필드가 있을 경우, 테이블이름.필드명
select p.product_code, product_name, price, amount, price*amount money, make_date 
from product p, product_sales s --join할 테이블들, 테이블이름 별칭/ 테이블이름이 길어서 alias 사용
where p.product_code=s.product_code;--join 조건


--from A join B on 조인조건
select p.product_code, product_name, price, amount, price*amount money, make_date 
from product p join product_sales s --join할 테이블들, 테이블이름 별칭/ 테이블이름이 길어서 alias 사용
on p.product_code=s.product_code;--조인 조건

--내부조인
select empno, ename, e.deptno, dname
from emp e join dept d on e.deptno=d.deptno;

--외부조인
select empno, ename, e.deptno, dname
from emp e right outer join dept d on e.deptno=d.deptno;
select empno, ename, e.deptno, dname
from dept d left outer join emp e on e.deptno=d.deptno;

select*from dept;

--21.04.16 am11
--create or replace : 최초에는 create 두번째부터는 replace(수정)
create or replace view product_sales_v --view 의 이름
as --as 다음에 sql명령어
select p.product_code, product_name, price, amount, price*amount money, company, make_date 
from product p, product_sales s --join할 테이블들, 테이블이름 별칭/ 테이블이름이 길어서 alias 사용
where p.product_code=s.product_code;

select*from product_sales_v;
select*from product_sales_v where company='삼성';

create or replace view emp_v
as
select empno, ename, job, sal, hiredate, comm, (sal*12+nvl(comm,0)) money, dname from emp e, dept d where e.deptno=d.deptno;
select*from emp_v;



--1.emp와 dept테이블을 조인하여 부서번호,부서명, 이름, 급여를 출력하시오.
select*from emp;
select*from dept;

select d.deptno, d.dname, e.ename, e.sal
from emp e, dept d
where e.deptno=d.deptno;
--2.직급이 사원인 사원의 이름,부서번호,부서이름을 출력하시오.
select e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno=d.deptno and e.job='사원';
    --ansi조인
    
--3.이름이 황인태인 사원의 부서명을 출력하시오.
select ename, dname
from emp e, dept d
where e.deptno=d.deptno and ename='황인태';
--4.emp테이블에 있는 empno,mgr을 이용하여 서로의 관계를 다음과 같이 출력하시오. "박진성의 매니저는 임채호이다"
   --self join
select*from emp;

select a.ename||'의 매니저는 '||b.ename||'이다'
from emp a, emp b
where a.mgr=b.empno;






select*from student;
select*from department;
drop table subject;
create table subject(
subject_code number not null primary key,
subject_name varchar2(50) not null,
profno number not null,--담당교수 사번
point number default 3--학점수, 기본값은 3
);
insert into subject values(1,'java',1001,3);
insert into subject values(2,'db',1002,4);
insert into subject values(3,'jsp',1003,2);
insert into subject ( subject_code, subject_name, profno) 
                    values(4,'android',1001);
select*from subject;
--과목코드,과목명,담당교수 이름
select*from professor;
select subject_code, subject_name, name
from professor p, subject s
where p.profno=s.profno;


--강좌테이블
create table lecture(
studno number not null,
subject_code number not null,
grade varchar(2),
primary key(studno, subject_code)--2개 이상의 필드를 복합키로 사용할 수 있음
);
insert into lecture values(9411,1,'A0');
insert into lecture values(9411,2,'A+');
insert into lecture values(9411,3,'B0');
insert into lecture values(9412,3,'C0');
insert into lecture values(9412,4,'F');
insert into lecture values(9413,2,'B+');
insert into lecture values(9413,3,'A+');
select*from lecture;
--학번,이름,과목명,담당교수,학점,등급
select l.studno, st.name sname, subject_name, p.name pname, point, l.grade
                --st.name의 alias->sname      p.name의 alias->pname
from lecture l, student st, subject sb, professor p
where l.studno=st.studno and l.subject_code=sb.subject_code
    and sb.profno=p.profno
    and l.studno=9411;
select studno, name from student;
commit;

create or replace view stud_view
as
select l.studno, st.name sname, subject_name, p.name pname, point, l.grade
                --st.name의 alias->sname      p.name의 alias->pname
from lecture l, student st, subject sb, professor p
where l.studno=st.studno and l.subject_code=sb.subject_code
    and sb.profno=p.profno;

select*from stud_view;

commit;

