select * from user_tables;

-- 주석
-- ctrl + / 주석토글링
-- create 명령어 - DDL 데이터 정의어
create user c##scott identified by tiger;
drop user c##scott;
-- 21g xe 버젼 , "_ORACLE_SCRIPT"=true; 셋 해줘야함.
alter session set "_ORACLE_SCRIPT"=true;
create user kh identified by kh;
create user scott identified by tiger;
create user sjk62 identified by sjk62;


--상태: 실패 -테스트 실패: ORA-01017: 사용자명/비밀번호가 부적합, 로그온할 수 없습니다.
--상태: 실패 -테스트 실패: ORA-01045: 사용자 SCOTT는 CREATE SESSION 권한을 가지고있지 않음; 로그온이 거절되었습니다

-- DCL
-- create session, create table 처럼 각각의 권한명을 모두 나열하여 적기 어려움..
-- 권한들을 묶어서 만들어둔 롤role 을 사용하여 권한을 부여함.
-- connect - 접속관련 권한들이 있는 role
-- resource - 자원(table, view 등 객체)관련 권한들이 있는 role
grant connect, resource to c##scott, kh;
grant connect, resource to kh;
revoke connect, resource from kh;
grant connect, resource to scott, kh;
-- 21g xe 버젼 , dba 추가
grant connect, resource, dba to scott, kh;
grant connect, resource, dba to sjk62;


create public synonym dept_public for KH.DEPT;s
create public synonym dept2_public for KH.DEPARTMENT;
select * from dept_public;
alter session set "_ORACLE_SCRIPT"=true;
DROP USER KH cascade;