--char(�����ڵ�) ���ڿ� �ش��ϴ� �����ڵ带 ����, dual�׽�Ʈ�� ���� ���� ���̺�
select chr(65) from dual;

--ascii(����) ������ �����ڵ带 ����
select ascii('A') from dual;
--concat(A,B) A�� B�� �����Ŵ
select concat(ename, '�� ��å�� '), job from emp;

select ename ||'�� ��å�� ', job from emp;
--lpad(���ڿ�,����,ä�ﰪ)
select lpad('abcd',9,'*') from dual;
--ltrim ���� ���� ����
select ltrim ('    abcd   ','   ') from dual;
--rtrim ���� ���� ����
select rtrim('     abcd    ','   ') from dual;
--replace(���ڿ�,A,B) ���ڿ����� A�� ã�Ƽ� B�� ��ȯ.
select replace('asiancup','asian','world') from dual;
--substr(���ڿ�,���� �ڸ���, ���ڼ�)
select substr('�ڹٰ����� ����',4,3) from dual;