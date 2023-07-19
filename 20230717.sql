alter session set "_oracle_script"=true;
create role role_scott_manager;
create user c##kh2 identified by kh2;
create role role_manager;

grant connect, resource to kh2;
--connect --롤 이름
--권한들의 묶음 = 롤
-- create session -- 접속제한
-- create table, alter table, drop table , create view, drop view create sequence, alter sequence.....
--공간 space를 사용하는 권한들 묶어서 resource 롤에 지정함.

grant create table, create view,connect, resource  to role manager;
--grant 권한명, 권한명,...롤명,롤명,.... to 롤명;
grant role_manager to kh2;
revoke create view from role_manager;