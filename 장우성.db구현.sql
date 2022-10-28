drop user date2 cascade;

create user date2 identified by date2 default tablespace users;
grant connect, resource to date2;

create table date2.users(
    user_id number(10) constraint date2_userid_pk primary key,
    id varchar2(20) constraint date2_id_uk unique
                        constraint date2_id_nn not null,
    password varchar2(65) constraint date2_password_nn not null,
    user_name varchar2(40) constraint date2_username_nn not null,
    phone_number varchar2(12) constraint date2_phonenumber_nn not null,
    nickname varchar2(18) constraint date2_nickname_nn not null,
    birthday date,
    created_at date,
    updated_at date
);
-- si
create table date2.si(
    si_id number(10) constraint date2_siid_pk primary key,
    si_name varchar2(24) constraint si_siname_uk unique 
                         constraint date2_siname_nn not null
);

-- gu
create table date2.gu(
    gu_id number(10) constraint date2_guid_pk primary key,
    gu_name varchar2(24) constraint si_guname_uk unique 
                         constraint date2_guname_nn not null
);
create table date2.places (
	place_id number(10) constraint places_placeid_pk primary key,
	si_id number(10) constraint palces_siid_fk references date2.si(si_id), 
	gu_id number(10) constraint palces_guid_fk references date2.gu(gu_id),
 	placegroup_id number(10), --constratnts
	place_name varchar2(60),
	introduction varchar2(600),
	views number(10),
	created_at date,
	updated_at date
);
    
    
    
create sequence date2.places_placeid_seq
	start with 1
	increment by 1
	nocache
	nocycle;





create table date2.declarations(
	declare_id number constraint date2_declareid_pk primary key,
	constraint date2_placeid_fk foreign key(place_id) references date2.places(place_id),
	constraint date2_userid_fk foreign key(user_id) references date2.users(user_id),
	content varchar2(1000) constraint date2_content_nn not null,
	confirm varchar2(9)constraint date2_confirm_nn not null,
    created_at date
);

create sequence date2.declaration_declareid_seq;


create table date2.interest_region(
    interestregion_id number constraint date2_interestregionid_pk primary key,
    constraint date2_userid_fk foreign key(user_id) references date2.users(user_id),
    constraint date2_siid_fk foreign key(si_id) references date2.si(si_id),
    constraint date2_guid_fk foreign key(gu_id) references date2.gu(gu_id)
);

create sequence date2.interestregion_interestregionid_seq;

insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 1, 1, 3);
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 2, 3, 1);
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 3, 2, 2);

insert into date2.places values(date2.placeid_seq.nextval, 1, 1, 1, '그림화원',
 '실내 정원 콘셉트의 채광 좋은 루프탑 화실에서 유화, 아크릴화 작품을 완성할 수 있는 원데이 클래스',
    50, '2022-10-27', '2022-10-28');
insert into date2.places values(date2.placeid_seq.nextval, 2, 2, 2, '덮밥 장사장',
    '진짜 맛있는 덮밥집',
    150, '2022-10-27', '2022-10-28');
insert into date2.places values(date2.placeid_seq.nextval, 3, 3, 3, '롯데시네마',
    '크고 넓은 영화관',
    250, '2022-10-27', '2022-10-28');
    
insert into date2.declarations values(date2.declarations_declareid_seq.nextval, 1, 1, '맛대가리 없어요ㅡㅡ', 1, '2022/05/15');    
insert into date2.declarations values(date2.declarations_declareid_seq.nextval, 2, 3, '가격이 많이 올랐어요', 2, '2022/07/23');
insert into date2.declarations values(date2.declarations_declareid_seq.nextval, 3, 3, '음식에서 머리카락나왔어요', 1, '2022/10/05');
