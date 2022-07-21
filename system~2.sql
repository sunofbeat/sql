
--system user
drop user mybatis cascade;
-- 과제 mybatis/mybatis user 를 만들어라.

create user mybatis identified by mybatis default tablespace users;
grant connect, resource to mybatis;

--과제] 테이블 설계도를 보고 테이블 3개를 만들어라.
--시스템유저로 접속한 상태기 때문에 create table users(); X
drop table mybatis.addresses;

create table mybatis.addresses (
user_id number(2)  constraint addresses_userid_pk primary key,
address varchar2(30) 
);
desc mybatis.addresses

create table mybatis.users (
user_id number(2) constraint users_userid_pk primary key,
user_name varchar2(12) constraint emps_empname_nn not null,
reg_date date,
    constraint users_redate_uk unique(date),
    constraint users_userid_fx foreign key(user_id),
        reference mybatis.addresses(user_id));

create table mybatis.posts(
post_id number(3)
post_title varchar2(60)
post_content varvhar2(120)
user_id number(2)
);




