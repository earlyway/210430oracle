--생성
--필드명id 자료형numb(사이즈5)
create table t_emp(
id number(5) not null,
name varchar2(35),
salary number(7,2),--전체 7자리, 소수이하는 2자리
phone varchar2(15),
dept_name varchar2(25)
);
--rename A to B
rename t_emp to s_emp;

insert into s_emp values (100,'이',2000,'010-111-2222','개발부');
insert into s_emp values (101,'최',3000,'010-555-9999','총무부');
insert into s_emp values (102,'정',4000,'010-777-2333','영업부');
--alter table 테이블 add 필드명 자료형-->>새로운 필드 추가
alter table s_emp add hire_date date;  --필드 추가
alter table s_emp modify phone varchar2(20);--사이즈 변경
alter table s_emp rename column id to t_id;--필드이름 변경
alter table s_emp drop column dept_name;--필드 삭제
--update 테이블 set 필드=값 where 조건
update s_emp set hire_date=sysdate where t_id=100;
update s_emp set hire_date=sysdate where t_id=101;
update s_emp set hire_date=sysdate where t_id=102;
--테이블에 원하는 필드와 사이즈만 추가.
insert into s_emp(t_id,hire_date) values (400,sysdate);

alter table s_emp add mailid varchar2(10);--필드 추가
alter table s_emp modify mailid varchar2(20);--사이즈 변경
alter table s_emp rename column mailid to e_mail;--필드이름 변경
rename s_emp to t_emp;

select*from t_emp;





--제약조건이 없는 테이블
create table c_emp(
id number(5),
name varchar2(25),
salary number(7,2),
phone varchar2(15),
dept_id number(7)
);

insert into c_emp (id,name) values(1,'김철수');
insert into c_emp (id,name) values(1,'김기철');
insert into c_emp (id,name) values(1,'이철수');

alter table c_emp add constraint c_emp_id_pk primary key(id);
select*from c_emp;
delete from c_emp;

--alter table 테이블 add constraint 제약조건이름 제약조건종류(제약걸 필드)
alter table add constraint c_emp_id_pk primary key(id);
--제약조건 조회
select*from user_constraint where table_name='C_EMP';
insert into c_emp(id,name) values(1,'김철수');
insert into c_emp(id,name) values(null,'김철수');
insert into c_emp(id,name) values(1,'김기철');



drop table c_emp;

create table c_emp(
id number(5) constraint c_emp_id_pk primary key,
name varchar2(25),
salary number(7,2),
phone varchar2(15),
dept_id number(7)
);

insert into c_emp(id,name) values(1,'김철수');
insert into c_emp(id,name) values(null,'김철수');
insert into c_emp(id,name) values(1,'김기철');




drop table c_emp;

create table c_emp(
id number(5) ,
name varchar2(25),--check 제약조건, 입력값의 범위를 설정. c_emp_salary_ck는 제약조건의 이름.
salary number(7,2) constraint c_emp_salary_ck check(salary between 100 and 1000),
phone varchar2(15),
dept_id number(7)
);

insert into c_emp(id,name,salary) values(1,'kim',500);
--범위를 벗어난 값(100~1000)이 발생하면 에러가 발생하도록.
insert into c_emp(id,name,salary) values(2,'park',1500);--에러





--부서코드에 50번 입력
select*from dept;
insert into emp(empno,ename,job,hiredate,sal,deptno)values
(9999,'hong','과장','2017-03-01',500,50);

drop table c_emp;
--references 테이블(필드)
create table c_emp(
id number(5) ,
name varchar2(25),
salary number(7,2),
phone varchar2(15),
dept_id number(7) constraint c_emp_deptid_fk references dept(deptno)
);

insert into c_emp(id,name,dept_id)values(1,'kim',10);
insert into c_emp(id,name,dept_id)values(2,'park',50);--에러 발생






drop table c_emp;

create table c_emp(
id number(5) ,
name varchar2(25) constraint c_emp_name_un unique,
salary number(7,2),
phone varchar2(15),
dept_id number(7)
);
insert into c_emp(id,name) values(1,'kim');
insert into c_emp(id,name) values(2,'kim');--에러 발생 ORA-00001: unique constraint (HR.C_EMP_NAME_UN) violated
insert into c_emp(id,name) values(3,null);--null은 허용
select*from c_emp;







