select*from emp;





create table emp_copy 
as select*from emp where 1=2;

select*from emp_copy;

delete from emp_copy where empno<9000;

commit;








create table subject(
subject_code number not null primary key,--코드
subject_name varchar2(50) not null,--이름
profno number not null,--순서
point number default 3--점수
);
insert into subject values (1,'java',1001,3);
insert into subject values (2,'db',1002,4);
insert into subject values (3,'jsp',1003,2);
insert into subject (subject_code,subject_name,profno)
values (4,'android',1001);
select*from subject;
commit;
