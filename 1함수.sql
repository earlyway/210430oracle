--char(숫자코드) 숫자에 해당하는 문자코드를 리턴, dual테스트를 위한 가상 테이블
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
--rtrim 우측 공백 제거
select rtrim('     abcd    ','   ') from dual;
--replace(문자열,A,B) 문자열에서 A를 찾아서 B로 변환.
select replace('asiancup','asian','world') from dual;
--substr(문자열,시작 자리수, 글자수)
select substr('자바개발자 과정',4,3) from dual;