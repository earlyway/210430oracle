drop table address;
commit;

create table address(
userid varchar2(20) primary key,
username varchar2(10) not null,
addr varchar2(50) not null,
tel varchar2(30) not null,
email varchar2(20) not null
);
insert into address values('10','kim','���� ����','02-1111-1111','kim@naver');
insert into address values('11','hong','���� ���α�','02-1111-5333','hong@naver');
insert into address values('12','son','���� ����','02-5556-1111','son@naver');

select*from address;
commit;