
-- drop user --
drop user date2 cascade;

-- create user --
create user date2 identified by date2 default tablespace users;

-- grant --
grant connect, resource to date2;


-- create table --
-- si
create table date2.si(
    si_id number(10) constraint si_id_pk primary key,
    si_name varchar2(24) constraint si_name_uk unique 
                         constraint si_name_nn not null
);

-- gu
create table date2.gu(
    gu_id number(10) constraint gu_id_pk primary key,
    gu_name varchar2(24) constraint gu_name_uk unique 
                         constraint gu_name_nn not null
);

-- place_group
create table date2.place_group(
    placegroup_id number(10) constraint placegroup_id_pk primary key,
    placegroup_name varchar2(30) constraint placegroup_name_uk unique
                                 constraint placegroup_name_nn not null
);

-- users
create table date2.users(
    user_id number(10) constraint users_userid_pk primary key,
    id varchar2(20) constraint users_id_uk unique
                    constraint users_id_nn not null,
    password varchar2(65) constraint users_password_nn not null,
    user_name varchar2(40) constraint users_username_nn not null,
    phone_number varchar2(12) constraint users_phonenumber_nn not null,
    nickname varchar2(18) constraint users_nickname_nn not null,
    birthday date,
    created_at date,
    updated_at date
);

-- admins
create table date2.admins(
    user_id number(10) constraint admins_id_fk references date2.users(user_id)
);

-- delete_users
create table date2.delete_users(
    user_id number(10) constraint deleteusers_id_fk references date2.users(user_id)
);

-- interest_region
create table date2.interest_region(
    interestregion_id number constraint interestregion_id_pk primary key,
    user_id number(10) constraint interestregion_userid_fk references date2.users(user_id),
    si_id number(10) constraint interestregion_siid_fk references date2.si(si_id),
    gu_id number(10) constraint interestregion_guid_fk references date2.gu(gu_id)
);


-- places
create table date2.places(
    place_id number(10) constraint places_id_pk primary key,
    si_id number(10) constraint palces_siid_fk references date2.si(si_id), 
    gu_id number(10) constraint palces_guid_fk references date2.gu(gu_id),
    placegroup_id number(10) constraint places_placegroupid_fk references date2.place_group(placegroup_id) , --constratnts
    place_name varchar2(60) constraint places_placename_nn not null,
    introduction varchar2(600) constraint places_introduction_nn not null,
    views number(10),
    created_at date,
    updated_at date
);

-- place_images
create table date2.place_images(
    placeimage_id number(10) constraint placeimages_id_pk primary key,
    place_id number(10) constraint placeimages_placeid_fk references date2.places(place_id),
    file_name varchar2(100) constraint placeimages_filename_nn not null
);

-- introductions
create table date2.introductions (
	introduction_id number(10) constraint introductions_id_pk primary key,
	place_id number(10) constraint introductions_placeid_fk references date2.places(place_id),
	address varchar2(300) constraint introductions_address_nn not null,
	tel varchar2(12),
	opening_hours varchar2(6),
	closing_hours varchar2(6),
	dayoff varchar2(100),
	contact varchar2(50),
	parking number(10),
	created_at date,
	updated_at date
);

-- menus
create table date2.menus(
	menu_id number(10) constraint menus_id_pk primary key,
	place_id number(10) constraint menus_placeid_fk references date2.places(place_id),
	menu_name varchar2 (150) constraint menus_menuname_nn not null,
	price number(12) constraint menus_price_nn not null
);

-- declarations
create table date2.declarations(
	declare_id number(10) constraint declarations_id_pk primary key,
    place_id number(10) constraint declarations_placeid_fk references date2.places(place_id),
    user_id number(10) constraint declarations_userid_fk references date2.users(user_id),
	content varchar2(1000) constraint declarations_content_nn not null,
	confirm varchar2(9)constraint declarations_confirm_nn not null,
    created_at date
);

-- interest_places
create table date2.interest_palces(
	interest_place_id number(10) constraint interestplaces_id_pk primary key,
	user_id number(10) constraint interestplaces_userid_fk references date2.users(user_id),
	place_id number(10) constraint interestplaces_placeid_fk references date2.places(place_id)
);

-- reviews
create table date2.reviews (
    review_id number(10) constraint reviews_id_pk primary key,
    place_id number(10) constraint reviews_placesid_fk references date2.places(place_id),
    user_id number(10) constraint reviews_usersid_fk references date2.users(user_id),
    content varchar2(1500) constraint reviews_content_nn not null,
    star_rating number(10) constraint reviews_starrating_nn not null,
    created_at date
);


-- review_images
create table date2.review_images(
    reviewimages_id number(10) constraint reviewimages_id_pk primary key,
    review_id number(10) constraint reviewimages_reviewid_fk references date2.reviews(review_id),
    file_name varchar2(100) constraint reviewimage_filename_nn not null
);


-- feeds
create table date2.feeds(
	feed_id number(10) constraint feeds_id_pk primary key,
	user_id number(10) constraint feeds_userid_fk references date2.users(user_id),
    title varchar2(100) constraint feeds_title_nn not null,
	content varchar2(1500) constraint feeds_content_nn not null,
	created_at date
);

-- comments
create table date2.comments(
	comment_id number(10) constraint comment_id_pk primary key,
	feed_id number(10) constraint comment_feedid_fk references date2.feeds(feed_id),
	content varchar2(500) constraint comment_content_nn not null,
	created_at date
);

-- hashtags
create table date2.hashtags (
    hashtag_id number(10) constraint hashtags_id_pk primary key,
    feed_id number(10) constraint hashtags_feedid_fk references date2.feeds(feed_id),
    tag varchar2(90)
);

-- feed_likes
create table date2.feed_likes (
    feedlike_id number(10) constraint feedlikes_id_pk primary key,
    feed_id number(10) constraint feedlikes_feedid_fk references date2.feeds(feed_id),
    user_id number(10) constraint feedlikes_userid_fk references date2.users(user_id)                       
);

-- comment_likes
create table date2.comment_likes (
	commentlike_id number constraint commentlikes_id_pk primary key,
	comment_id number(10) constraint commentlikes_commentid_fk references date2.comments(comment_id),
    user_id number(10) constraint commentlikes_userid_fk references date2.users(user_id)
);



-- sequence create --
-- si
create sequence date2.si_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- gu
create sequence date2.gu_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- place_group
create sequence date2.placegroup_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- users
create sequence date2.users_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- interest_regions
create sequence date2.interestregions_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- places
create sequence date2.places_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- place_images
create sequence date2.placeimages_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- introductions
create sequence date2.introductions_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- menus
create sequence date2.menus_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;
    
-- declarations
create sequence date2.declarations_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- interest_places
create sequence date2.interestplaces_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- reviews
create sequence date2.reviews_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- reviewimages
create sequence date2.reviewimages_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- feeds
create sequence date2.feeds_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- comments
create sequence date2.comments_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- hashtags
create sequence date2.hashtags_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- feed_likes
create sequence date2.feedlikes_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;

-- comment_likes
create sequence date2.commentlikes_id_seq
	start with 1
	increment by 1
	nocache
	nocycle;


-- insert --

-- si
-- gu
-- place_group
-- users     
insert into date2.users values(date2.users_id_seq.nextval, 'user', 'user', '최한석', '01075463543', '한석', '1998-01-02', sysdate, sysdate);
insert into date2.users values(date2.users_id_seq.nextval, 'user2', 'user2', '한아름', '01042345342', '아름', '1999-04-03', sysdate, sysdate);
insert into date2.users values(date2.users_id_seq.nextval, 'user3', 'user3', '김선우', '01025545242', '선우', '1989-03-04', sysdate, sysdate);
insert into date2.users values(date2.users_id_seq.nextval, 'user4', 'user4', '김승일', '01025545242', '승일', '1989-03-04', sysdate, sysdate);
insert into date2.users values(date2.users_id_seq.nextval, 'user5', 'user5', '이승원', '01025545242', '승원', '1989-03-04', sysdate, sysdate);

-- admins
insert all
    into date2.users values(date2.users_id_seq.nextval, 'admin', 'admin', '경서', '01036457459', 'adm1', '1997-08-05', sysdate, sysdate)
    into date2.admins values(date2.users_id_seq.currval)
    select * from dual;

insert all
    into date2.users values(date2.users_id_seq.nextval, 'admin2', 'admin2', '김현성', '01047543534', 'adm2', '1996-02-04', sysdate, sysdate)
    into date2.admins values(date2.users_id_seq.currval)
    select * from dual;

-- delete_users 
insert into date2.delete_users values(4);
insert into date2.delete_users values(5);

-- interest_regions 
insert into date2.interest_region values(date2.regions_interestregionid_seq.nextval, 1, 1, 3);
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 2, 3, 1);
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 3, 2, 2);

-- place 
-- place_images 
-- introductions 
-- menus 
-- declarations 
-- interest_places 
-- reviews 
-- review_images 
-- feeds 
-- comments 
-- hashtag 
-- feed_likes 
-- comment_likes 



-- 아래는 임시파일 ===================================================================================================================================
-- users

-- admins


-- interest_region
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 1, 1, 3);
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 2, 3, 1);
insert into date2.interest_region values(date2.interestregion_interestregionid_seq.nextval, 3, 2, 2);



-- menus
insert into date2.menus values(date2.menus_menuid_seq.nextval, 1, '2인 아크릴화 or 유화 원데이 클래스 평일 이용권(팝딜 20% 할인)', 64000);
insert into date2.menus values(date2.menus_menuid_seq.nextval, 1, '2인 유화 원데이 클래스', 80000);
insert into date2.menus values(date2.menus_menuid_seq.nextval, 1, '2인 아크릴화 원데이 클래스', 8000);

-- interest_places
insert into date2.interest_places values(date2.interest_places_interesetplaceid_seq.nextval, 1, 1);
insert into date2.interest_places values(date2.interest_places_interesetplaceid_seq.nextval, 1, 2);
insert into date2.interest_places values(date2.interest_places_interesetplaceid_seq.nextval, 1, 3);

-- reviews
insert into date2.reviews values(date2.reviews_reviewsid_seq.nextval, 1, 1, '그림화원 진짜 채광도 좋고 너무 이쁜것같아요 대표님도 너무 친절하시고 이쁘게 그림도 그리고 왔어요!! 한번쯤 가보시는걸 추천드려요!!', '5', '2022-10-12');
insert into date2.reviews values(date2.reviews_reviewsid_seq.nextval, 1, 2, '분위기는 좋았지만 그알못인 저는 어렵긴 했습니다ㅠㅠ 그래도 같이간 제 여자친구는 잘하더라구요! 좋았습니다~', '3', '2022-10-13');
insert into date2.reviews values(date2.reviews_reviewsid_seq.nextval, 2, 3, '오붓하게 둘이서만의 시간을 가질 수 있었던 것 같아요, 가격은 비싸지만 나쁘지 않았습니다~~', '4', '2022-08-15');

-- declarations
insert into date2.declarations values(date2.declarations_declareid_seq.nextval, 1, 1, '맛대가리 없어요ㅡㅡ', 1, '2022/05/15');    
insert into date2.declarations values(date2.declarations_declareid_seq.nextval, 2, 3, '가격이 많이 올랐어요', 2, '2022/07/23');
insert into date2.declarations values(date2.declarations_declareid_seq.nextval, 3, 3, '음식에서 머리카락나왔어요', 1, '2022/10/05');

-- introductions
insert into date2.introductions values(date2.introductions_introductionid_seq.nextval, 1,'서울특별시 관악구 신림동 1639-20', '01027970703', '17:00', '21:30', '화요일', 'http://blog.naver.com/veo_wj', '', '2022-10-27', '2022-10-27');
insert into date2.introductions values(date2.introductions_introductionid_seq.nextval, 2, '서울특별시 관악구 봉천동 1621-3 1층', '0264393228', '11:00', '21:00', '월요일', '', '1', '2022-10-01', '2022-10-27');
insert into date2.introductions values(date2.introductions_introductionid_seq.nextval, 3, '서울특별시 관악구 신림로 330 타임스트림 10층', '15448855', '05:00', '02:00', '연중무휴', 'https://www.lottecinema.co.kr', '1', '2010-01-22', '2022-10-26');


-- reviewimages
insert into date2.review_images values(date2.reviewimages_reviewimagesid_seq.nextval, 1, 'img1.jpg');
insert into date2.review_images values(date2.reviewimages_reviewimagesid_seq.nextval, 1, 'img2.jpg');
insert into date2.review_images values(date2.reviewimages_reviewimagesid_seq.nextval, 3, 'img3.jpg');

-- comment_likes
insert into date2.comment_likes values(date2.comment_likes_commentlikeid_seq.nextval, 1, 1);
insert into date2.comment_likes values(date2.comment_likes_commentlikeid_seq.nextval, 2, 2);
insert into date2.comment_likes values(date2.comment_likes_commentlikeid_seq.nextval, 3, 3);

-- feeds
insert into date2.feeds values(date2.feeds_feedid_seq.nextval, '1', '카페 추천 받아요', '신림역 근처 분위기 좋은 카페 추천해주세요~~', '22-10-18');
insert into date2.feeds values(date2.hashtags_hashtagid_seq.nextval, '1', '#카페 #신림');
insert into date2.feed_likes values(date2.feed_likes_feedlike_seq.nextval, '1', '1');

insert into date2.feeds values(date2.feeds_feedid_seq.nextval, '2', '용산역 근처 맛집', '용산역 근처에서 데이트 할 예정인데 맛집이나 놀거리 있나요??', '22-10-18');
insert into date2.feeds values(date2.hashtags_hashtagid_seq.nextval, '1', '#맛집  #데이트');
insert into date2.feed_likes values(date2.feed_likes_feedlike_seq.nextval, '2', '2');

insert into date2.feeds values(date2.feeds_feedid_seq.nextval, '1', '홍대 놀거리', '홍대에서 놀만한 곳 추천해주세요~', '22-10-18');
insert into date2.feeds values(date2.hashtags_hashtagid_seq.nextval, '3', '#홍대 #놀거리');
insert into date2.feed_likes values(date2.feed_likes_feedlike_seq.nextval, '3', '3');

-- comments
insert into date2.comments values(date2.comments_commentid_seq.nextval, 1, '여기 좋아요~', '2022-10-18');
insert into date2.comments values(date2.comments_commentid_seq.nextval, 2, '그림화원 추천해요', '2022-10-18');
insert into date2.comments values(date2.comments_commentid_seq.nextval, 3, '여기 주차장 없어요', '2022-10-18'); 

-- comment_likes
insert into date2.comment_likes values(date2.comment_likes_commentlikeid_seq.nextval, 1, 1);
insert into date2.comment_likes values(date2.comment_likes_commentlikeid_seq.nextval, 2, 2);
insert into date2.comment_likes values(date2.comment_likes_commentlikeid_seq.nextval, 3, 3);


commit;

-- create sequence date2.admin_id_seq;
-- insert into date2.admins values(date2.admin_id_seq.nextval, 'admin', 'admin');