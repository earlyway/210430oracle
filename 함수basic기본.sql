--char(숫자코드) 숫자에 해당하는 문자코드를 리턴, dual-->테스트를 위한 가상 테이블(더미)
select*from dual;
select chr(65) from dual;

--ascii(문자) 문자의 숫자코드를 리턴
select ascii('A') from dual;
--concat(A,B) A와 B를 연결시킴
select concat(ename, '의 직책은 '), job from emp;

select ename ||'의 직책은 ', job from emp;
--lpad(문자열,길이,채울값)
select lpad('abcd',9,'*') from dual;
--ltrim 좌측 공백 제거
select ltrim ('    abcd   ','   ') from dual;
select ltrim('####abcd###','#') from dual;
--rtrim 우측 공백 제거
select rtrim('     abcd    ','   ') from dual;
--replace(문자열,A,B) 문자열에서 A를 찾아서 B로 변환.
select replace('asiancup','asian','world') from dual;
--substr(문자열,시작 자리수, 글자수)
select substr('자바개발자 과정',4,3) from dual;





--시스템의 현재날짜
select sysdate from dual;

select sysdate+100 from dual; --100일 후
select sysdate-20 from dual; --20일 전
select add_months(sysdate,3) from dual;--3개월 후
sleect add_months(hiredate, 5) from emp;--회사입사 후 5개월의 날짜
--월의 마지막 날짜 계산
select last_day('2021-03-15') from dual;
--months_between(A,B) A-B 월수
--round(숫자, 소수 이하자리수) 반올림
select months_between('2021-03-15','2021-04-30')from dual;
select round(months_between('2021-04-30','2021-04-15'),2) from dual;


--날짜를 문자열 형식으로 출력
select to_char(sysdate, 'yyyy-mm-dd am hh:mi:ss day') from dual;
--문자열과 숫자는 덧셈할 수 없음, 문자가 숫자로 자동 변환됨
select '100'+1 from dual;
select to_number('100')+1 from dual;
--문자를 날짜형식으로 바꾸는 함수
select to_date('2021-03-01','yyyy-mm-dd') from dual;

select (sysdate-hiredate)/365 from emp;
select round((sysdate-hiredate)/365,2)from emp;--반올림
select ceil((sysdate-hiredate)/365) from emp;--올림
select trunc((sysdate-hiredate)/365)from emp;--버림



--bonus가 null인 경우 정확히 계산이 되지않는 문제가 발생함.
select name,pay,bonus,(pay*12+bonus) from professor;
--NVL(A,B) A가 null이면 B
select name,pay,bonus,(pay*12+nvl(bonus,0)) from professor;

select ename,sal,comm,(sal*12+nvl(comm,0)) from emp;

--decode(A,B,같을때,다를때)
select name, deptno, decode(deptno, 101, '컴공과',102,'멀티학과') from professor;

