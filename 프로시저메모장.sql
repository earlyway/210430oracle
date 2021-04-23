create table memo(--테이블 만들기
idx number primary key,
writer varchar2(50) not null,
memo varchar2(500) not null,
post_date date default sysdate
);
--시퀀스 생성(자동화를 위한)
create sequence memo_seq--시퀀스 이름
start with 1
increment by 1
nomaxvalue;--무제한 증가
--시퀀스.nextval 다음번호 발급
insert into memo(idx,writer,memo)values(memo_seq.nextval,'kim','memo');
insert into memo(idx,writer,memo)values(memo_seq.nextval,'park','memo2');

--테이블에 새로운 필드 ip 추가
alter table memo add ip varchar2(50);
select*from memo;
desc memo;--테이블의 필드목록 확인
--프로시저 생성
create or replace procedure
memo_insert(v_writer in varchar, v_memo in varchar,v_ip in varchar)
is
begin
    insert into memo(idx,writer,memo,ip)
    values(memo_seq.nextval, v_writer, v_memo, v_ip);
end;
/
--프로시저 실행
execute memo_insert('김철수','메모...','192.168.0.10');
select*from memo;
--데이터사전(user_source)에 저장된 프로시저 정보확인
select*from user_source where name='MEMO_INSERT';
commit;






create table members(
userid varchar2(20) not null primary key,
pwd varchar2(30) not null,
username varchar2(20) not null
);
insert into members values('kim123','1234','김철수');
insert into members values('seo222','1111','서철수');
select*from members;
commit;



                        --프로시저이름 ememo_list
create or replace procedure memo_list(v_row out sys_refcursor)
                                --매개변수 이름은 v_row
is
begin
    open v_row for
        select idx,writer,memo,post_date,ip
        from memo
        order by idx desc;
    end;
    /
--프로시저를 실행한 후 실행결과값이 매개변수 a(:a)에 리턴됨
execute memo_list(:a);
--데이터사전에 서장된 프로시저 정보 확인
select*from user_source where name='MEMO_LIST';
    commit;
    
    

create or replace function fn_update_sal(v_empno number)
return number--리턴 자료형
is
    v_sal number;
begin
    update emp set sal=sal*1.1 where empno=v_empno;
    select sal into v_sal from emp
    where empno=v_empno;--필드 into 변수
    return v_sal;--함수를 호출한 곳으로 값을 리턴
    end;
/

select sal from emp where empno=7369;
select fn_update_sal(7369)from dual;
select empno,ename,sal,sal*1.1,fn_update_sal(empno)from emp;
desc dual;
select sysdate from dual;
--변수 선언
-- 변수 := 변수에 값을 대입, :변수--->매개변수
--print변수 - 변수값을 콘솔에 출력
--execute : 변수 :=함수(입력값)
var salary number;
execute :salary :=fn_update_sal(7369);
print salary;

commit;