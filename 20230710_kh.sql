select * from employee;
select * from department;
select * from job;
select * from location;
select * from national;
select * from sal_grade;

select * from employee where job_code = 'J1';

--SELECT emp_name, length(emp_name) len, lengthb(emp_name) by
-- from emp
-- ;
-- instr -1부터 시작
select email, instr(email,'@',-1,1)
from employee;

--email 은 @ 이후에 . 1개 이상있어야함.
select email, instr(email,'@'), instr(email, '.',instr(email, '@'))
from employee
where instr(email, '.', instr(email, '@'))<> 0
;

--
select INSTR('ORACLEWALCOME', 'O',2)
from dual;

select INSTR('ORACLEWALCOME', 'O',1,2)
from dual;

-- 날짜 처리함수가 아니지만 함수처럼사용 STSDATE 시스템에 저장되어 있는 현재 날짜 반환.
--SYSDATE은 함수는 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수호출과 같이 동작함.
SELECT SYSDATE
FROM DUAL;

SELECT hiredate from emp;

select add_months(hiredate, 50) from emp;


--급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원 이름과 급여 조회
select emp_name,salary
    from employee
    where salary between 3500000 and 6000000;
--'전'씨 성을 가진 직원 이름과 급여 조회
select emp_name,salary
    from employee
    where emp_name like '전%'
;

-- 핸드폰의 앞 네자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
select emp_name, phone
from employee
where phone like '___7%'
;

--email id 중 '_'의 앞이 3자리인 직원 이름, 이메일 조회
SELECT emp_name, email
from employee
where email like '___#_%'ESCAPE'#'
;

-- ‘이’씨 성이 아닌 직원 사번, 이름, 이메일 조회
select emp_id, emp_name, email
from employee
where emp_name not like '이%'
;

-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
SELECT emp_name, manager_id, dept_code
from employee
where manager_id is null and dept_code is null
;

-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
SELECT emp_name,bonus,dept_code
from employee
where dept_code is null and bonus is not null
;

-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
SELECT emp_name,dept_code,salary
from employee
where dept_code in('d6','d8')
;
-- ‘J2’ 또는 ‘J7’ 직급 코드 중 급여를 2000000보다 많이 받는 직원의
--이름, 급여, 직급코드 조회
SELECT emp_name, salary, job_code
from employee
where job_code = 'j7' or job_code = 'j2'
and salary > 2000000
;

--사원들의 남,여 성별과 함께 이름과 주민번호
select emp_name, emp_no, 
    decode(substr(emp_no, 8,1), 2,'여','남')
    as "성별"
    
    from employee
;
--java, js 삼항연산자
-- string a = ( substr(emp_no, 8 ,1) == 2? "여" : "남";
--if(substr(emp_no, 8 ,1) ==2) {
--return "여";
--}else {
--return "남";
--}
select emp_name, emp_no,
decode(substr(emp_no,8,1),2,'여',4,'여',1,'남',3,'남','그외')
as "성 별"
from employee
;

select emp_name, emp_no,
    case
        when substr(emp_no, 8 ,1) = 2 then '여'
        when substr(emp_no, 8 ,1) = 1 then '남'
        when substr(emp_no, 8 ,1) = 4 then '여'
        when substr(emp_no, 8 ,1) = 3 then '남'
        else '그외'
     end
     as "성 별"
     from employee
;
     
     select emp_name, emp_no,
    case to_number (substr(emp_no, 8 ,1))
        when 2 then '여'
        when 1 then '남'
        when 4 then '여'
        when 3 then '남'
        else '그외'
     end
     as "성 별"
     from employee
;

select substr(emp_no, 8 ,1) from employee;

-- 직원들의 평균 급여는 얼마인지 조회
SELECT (avg (salary)) 평균급여 from employee;
SELECT floor(avg (salary)) 평균급여 from employee;
SELECT trunc(avg (salary),2) 평균급여 from employee;
SELECT round(avg (salary)) 평균급여 from employee;
SELECT ceil(avg (salary)) 평균급여 from employee;

SELECT COUNT(DISTINCT DEPT_CODE)FROM EMPLOYEE;
SELECT COUNT(DEPT_CODE)FROM EMPLOYEE; --21
SELECT COUNT(*)FROM EMPLOYEE; -23
SELECT COUNT(*)FROM EMPLOYEE where dept_code is null; 
select * from employee; --23
select * from employee where dept_code is  null;
--count 는 resultset의 row값이 null이면 count 되지 않음.
-- count(*) row 개수
SELECT count(dept_code), count(bonus), count(emp_id), count(manager_id), count(*)
from employee where dept_code is null;

SELECT DEPT_CODE from employee;
select distict FROM EMPLOYEE; 

-- 사원명 , 부서번호 부서명 부서위치를 조회

select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, nationcal_code, tb4.national_name
from employee tb1
join department tb2 on tb1.dept_code = tb2.dept_id
join location tb3 on department.location_id = tb3.local_code
join national tb4 using(national_code)
; --오류남

select *
from employee e
left outer join department d on e.dept_code=d.dept_id
;

select *
from employee e
full outer join department d on e.dept_code=d.dept_id
;

select *
from employee e , department d
where e.dept_code(+)=d.dept_id;

--SUBQUERY  
SELECT emp_id,emp_name, job_code,salary
from employee
where salary >=(select avg(salary) from employee);

--전 직원의 급여 평균 보다 많은 급여를 받는 직원의 이름,직금,부서, 급여조회
--단일행 서브쿼리
SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE E
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY 2;

--부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 다중행 서브쿼리
select emp_name, job_code, dept_code, salary
from employee
where salary in(select max(salary) from employee group by dept_code);

--퇴사한 여직원과 같은 부서 , 같은 직급에 해당하는 사원의 이름, 직급, 부서,입사일조회
--다중 열 서브 쿼리
select emp_name, job_code, dept_code, hire_date
from employee
where(dept_code, job_code)in(select dept_code, job_code from employee
where substr(emp_no,8,1)=2and ent_yn='Y');


--직급별 최소 급여를 받는 직원의 사번, 이름 , 직급,급여 조회
--다중행 다중 열 서브쿼리
select emp_id,emp_name, job_code,salary
from employee
where(job_code,salary)in(select job_code, min(salary)
from employee group by job_code)
order by 3;

--with
--서브쿼리에 이름을 붙여주고 인라인 뷰로 사용시 서브쿼리의 이름으로
--from절에 기술 가능
--같은 서브쿼리가 여러번 사용될 경우 중복 작성을 피할 수 있고 실행속도도 빨라진다는 장점이있음
with topn_sal as(select emp_name,salary from employee order by salary desc)
select rownum, emp_name, salary
from topn_sal;

--rank() over

select 순위,emp_name, salary
from(select emp_name, salary, rank() over(order by salary desc)as 순위
from employee
order by salary desc);

--dense_rack()over
select 순위, emp_name, salary
from(select emp_name, salary, dense_rack() over(order by salary desc)as 순위
from employee
order by salary desc);

--20230712
-- 16.employee테이블에서 사원명, 주민번호 조회( 단, 주민번호는 생년월일만 보이게하고, '-'다음 값은 '*'로 바꾸기)
select emp_id, emp_no,  substr(emp_no,1,7), rpad(substr(emp_no,1,7),14,'*')
from employee
;

CREATE TABLE USER_CHECK(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) CHECK (GENDER IN ('남', '여')),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50)
);
INSERT INTO USER_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남자', '010-1234-5678', 
'hong123@kh.or.kr');
--PPT 6 CREATE
--테이블이나 인덱스,뷰 등 데이터베이스 객체를 생성하는구문
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20));
    
COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';

--제약조건 (CONSTRAINTS)
--NOT NULL 예시
create table user_notnull(
    user_no number not null,
    user_id varchar2(20) not null,
    user_pwd varchar2(30) not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
);
insert into user_notnull values(1,'user01','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_notnull values(2,null,null,null,null,'010-1234-5678',
'hong123@kh.or.kr');

--제약조건 constraints
--unique
--컬럼 입력 값에 대해 중복을 제한하는 제약조건으로
--컬럼 레벨과 테이블 레벨에 설정가능

create table user_unique(
    user_no number,
    user_id varchar(20)unique,
    user_pwd varchar2(30)not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50)
);
insert into user_unique values(1,'user01','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique values(1,'user01','pass01','null','null','010-1234-5678',
'hong123@kh.or.kr');

--예시2
create table USER_UNIQUE2(
    user_no number,
    user_id varchar(20),
    user_pwd varchar2(30)not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    UNIQUE(user_id)
);
insert into user_unique2 values(1,'user01','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique2 values(1,'user01','pass01','NULL','NULL','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique2 values(1,'NULL','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique2 values(1,'NULL','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr'); --중복값이 있는경우 행이 삽입되지않음

--예시3
create table USER_UNIQUE3(
    user_no number,
    user_id varchar(20),
    user_pwd varchar2(30)not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    UNIQUE(USER_NO,user_id)
);
insert into user_unique3 values(1,'user01','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique3 values(2,'user01','pass01','NULL','NULL','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique3 values(2,'user02','pass02','NULL','NULL','010-1234-5678',
'hong123@kh.or.kr');
insert into user_unique3 values(1,'user01','pass01','NULL','NULL','010-1234-5678',
'hong123@kh.or.kr');

--제약조건 CONSRTAINTS
--primary key
-- 테이블에서 한 행의 정보를 구분하기 위한 고유 식별자 역할
--not null의 의미와 unique의 의미를 둘다 가지고 있으며
--한 테이블 당 하나만 설정 가능 컬럼 레벨과 테이블 레벨 둘 다 지정 가능

create table USER_primarykey(
    user_no number primary key,
    user_id varchar(20) unique,
    user_pwd varchar2(30)not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
);
create table USER_primarykey(
    user_no number,
    user_id varchar(20) unique,
    user_pwd varchar2(30)not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    primary key(user_no)
);
insert into user_primarykey values(1,'user01','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_primarykey values(1,'user02','pass02','이순신','남','010-5678-9012',
'lee123@kh.or.kr');
insert into user_primarykey values(null,'user03','pass03','유관순','여','010-3131-3131',
'yoo123@kh.or.kr');

--예시 2
create table USER_primarykey2(
    user_no number,
    user_id varchar(20),
    user_pwd varchar2(30)not null,
    user_name varchar2(30),
    gender varchar2(10),
    phone varchar2(30),
    email varchar2(50),
    primary key(user_no,user_id)
);
insert into user_primarykey2 values(1,'user01','pass01','홍길동','남','010-1234-5678',
'hong123@kh.or.kr');
insert into user_primarykey2 values(1,'user02','pass02','이순신','남','010-5678-9012',
'lee123@kh.or.kr');
insert into user_primarykey2 values(2,'user01','pass01','유관순','여','010-3131-3131',
'yoo123@kh.or.kr');
insert into user_primarykey2 values(1,'user01','pass01','신사임당','여','010-1111-1111',
'shin123@kh.or.kr');

--제약조건 constraints
--foreign key
create table user_grade(
    grade_code number primary key,
    grade_name varchar2(30) not null
);
insert into user_grade values(10,'일반회원');
insert into user_grade values(20,'우수회원');
insert into user_grade values(30,'특별회원');

select *from user_grade;

--foreign key 예시1
CREATE TABLE USER_FOREIGNKEY(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50),
GRADE_CODE NUMBER,
FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE( GRADE_CODE)
);
INSERT INTO USER_FOREIGNKEY 
VALUES(1,'user01','pass01','홍길동','남',
'010-1234-5678','hong123@kh.or.kr',10); 

INSERT INTO USER_FOREIGNKEY 
VALUES(2,'user02','pass02','이순신','남',
'010-9012-3456','lee123@kh.or.kr',20);

INSERT INTO USER_FOREIGNKEY 
VALUES(3,'user03','pass03','유관순','여',
'010-3131-3131','yoo123@kh.or.kr',30); 

INSERT INTO USER_FOREIGNKEY 
VALUES(4,'user04','pass04','신사임당','여',
'010-1111-1111','yoo123@kh.or.kr',null); 

INSERT INTO USER_FOREIGNKEY 
VALUES(5,'user05','pass05','안중근','남',
'010-4444-4444','ahn123@kh.or.kr',50);

--foreign key 예시
CREATE TABLE USER_FOREIGNKEY(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50),
GRADE_CODE NUMBER REFERENCES USER_GRADE (GRADE_CODE) ON DELETE SET NULL
);
DELETE FROM USER_GRADE WHERE GRADE_CODE = 10;

--check
--예시 --오류
CREATE TABLE USER_CHECK(
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) CHECK (GENDER IN (‘남’, ‘여‘)),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50)
);
INSERT INTO USER_CHECK VALUES(1, ‘user01’, ‘pass01’, ‘홍길동’, ‘남자‘, ‘010-1234-5678’, 
‘hong123@kh.or.kr’);

--subquery를 이용한 create table
--예시
CREATE TABLE EMPLOYEE_COPY
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE);
--PPT 7 dml
--데이터 조작 언어로 테이블에 값으 삽입(insert),수정(update),삭제(delete)
--하는 구문을 말함

insert into employee
values(1,'홍길동','820114-1010101','hong_kd@kh.co.kr','01099998888','D5','J2','S4',3800000,
NULL,'200',SYSDATE,NULL,DEFAULT);

UPDATE EMPLOYEE
SET EMP_ID=290
WHERE EMP_NAME='홍길동';

DELTE FROM EMPLOYEE
WHERE EMP_NAME = '홍길동';

--insert
--테이블에 새로운 행을 추가하여 테이블의 행 개수를 증가시키는 구문
--예시
insert into employee(emp_id,emp_name,emp_no,eail,phone,dept_code,
job_code,sal_level,salary,bonus,manager_id,hire_date,ent_date,ent_yn)
values(900,'장채현','901123-1080503','jang_ch@kh.or.kr','01055569512','D1','J8',
'S3',4300000,0.2,'200',SYSDATE,NULL,DEFAULT);

INSERT INTO EMPLOYEE 
VALUES(900, '장채현', '901123-1080503', 'jang_ch@kh.or.kr', '01055569512', 'D1', 'J8', 
'S3', 4300000, 0.2, '200', SYSDATE, NULL, DEFAULT);

--INSERT 예시2
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);
INSERT INTO EMP_01(
    SELECT EMP_ID,
           EMP_NAME,
           DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
);
--INSERT ALL
CREATE TABLE EMP_DEPT_D1
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE 1 = 0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE 1 = 0;

--예시1
--EMP_DEPT_D1테이블에 EMPLOYEE테이블의 부서코드가 D1인 직원의
--사번 이름 소속부서 입사일을 삽입하고
--EMP_MANAGER테이블에 EMPLOYEE테이블의 부서코드가 D1인 직원의
--사번 이름 관리자 사번을 조회하여 삽입

INSERT ALL
INTO EMP_DEPT_D1 VALUES(EMP_ID,EMP_NAME,DEPT_CODE,HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID,EMP_NAME,MANAGER_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--예시2
--EMPLOYEE테이블의 구조를 복사하여 사번 이름 입사일 급여를 기록할수있는
--테이블 EMP_OLD와 EMP_NEW생성
CREATE TABLE EMP_OLD
AS SELECT EMP_ID, 
          EMP_NAME,
          HIRE_DATE,
          SALARY
    FROM EMPLOYEE
    WHERE 1=0;

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, 
          EMP_NAME,
          HIRE_DATE,
          SALARY
    FROM EMPLOYEE
    WHERE 1=0;
--예시2
--EMPLOYEE테이블의 입사일 기준으로 2000년 1월1일 이전에 입사한 사원의사번,
--이름,입사일, 급여를 조회해서 EMP_OLE테이블에 삽입하고
--그후에 입사한 사원의 정보는 EMP_NEW테이블에 삽입
--오류남
INSERT ALL
WHEN HIRE_DATE < ‘2000/01/01’ THEN
INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
WHEN HIRE_DATE >= ‘2000/01/01’ THEN
INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

--UPDATE
--테이블에 기록된 컬럼값을 수정하는 구문으로 테이블 전체 행 개수는 변화없음
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
UPDATE DEPT_COPY
SET DEPT_TITLE = ‘전략기획팀’
WHERE DEPT_ID = ‘D9’;

--UPDATE 예시2
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID,
    EMP_NAME,
    DEPT_CODE,
    SALARY,
    BONUS
    FROM EMPLOYEE;
    
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY
WHERE EMP_NAME='유재식'),
BONUS = (SELECT BONUS
FROM EMP_SALARY WHERE EMP_NAME='유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식', '방명수');

--예시3
--각각 쿼리문 작성한 것을 다중 행 다중 열 서브쿼리로 변경
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식', '방명수');

--예시4
--EMP_SALARY테이블에서 아시아 지역에 근무하는 직원의 보너스 포인트 0.3으로 변경
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN (SELECT EMP_ID
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%');

--DELETE
--테이블의 행을 삭제하는 구문으로 테이블의 행 개수가 줄어듦
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '장채현';

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';

--DELETE
--삭제시 FOREIGN KEY 제약조건으로 컬럼 삭제가 불가능한 경우
--제약조건을 비활성화 할 수있음
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
ALTER TABLE EMPLOYEE
DISABLE CONSTRAINT EMP_DEPTCODE_FK CASCADE;
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
ALTER TABLE EMPLOYEE
ENABLE CONSTRAINT EMP_DEPTCODE_FK;

--TRUNCATE
--테이블 전체 행 삭제시 사용하며 DELETE보다 수행 속도가 빠르고
--ROLLBACK을 통해 복구 불가능
TRUNCATE TABLE EMP_SALARY;
SELECT * FROM EMP_SALARY;
ROLLBACK;

--DDL
--데이터 정의 언어로 객체(OBJECT)를 만들고 (CREATE), 수정하고(ALTER),
--삭제(DROP)하는 구문을 말함

ALTER TABLE DEPT_COPY
ADD(CNAME VARCHAR2(20));

ALTER TABLE DEPT_COPY
ADD(LNAME VARCHAR2(40)DEFAULT'한국');

--ALTER
--제약조건 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID);
ADD CONSTRAINT DCOPY_DTITLE_UNQ UNIQUE(DEPT_TITLE);
MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;

SELECT UC.CONSTRAINT_NAME,
       UC.CONSTRAINT_TYPE,
       UC.TABLE_NAME,
       UCC.COLUMN_NAME,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME=UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'DEPT_COPY';

--ALTER 컬럼 수정

ALTER TABLE DEPT_COPY
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR(30)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY CNAME CHAR(20)
MODIFY LNAME DEFAULT'미국';

--ALTER 컬럼삭제
ALTER TABLE DEPT_COPY
DROP COLUMN DEPT_ID;

CREATE TABLE TB1 ( --오류
    PK NUMBER PRIMARY KEY,
    KF NUMBER PEFERENCES TB1,
    COL1 NUMBER,
    CHECK(PK >0 AND COL1 >0)
);
ALTER TABLE TB1
DROP COLUMN PK;
--컬럼 삭제시 참조하고 있는 컬럼이 있다면 컬럼 삭제 불가능

ALTER TABLE TB1
DROP COLUMN OK CASCADE CONSTRAINT;

ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_DID_PK
DROP CONSTRAINT DCOPY_DTITLE_UNQ
MODIFY LNAME NULL;

--컬럼 이름 변경
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

--제약조건 이름 변경
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007211 TO UF_UP_NN;
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007212 TO UF_UN_PK;
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007213 TO UF_UI_UQ;
ALTER TABLE USER_FOREIGNKEY
RENAME CONSTRAINT SYS_C007214 TO UF_GC_FK;

SELECT UC.CONSTRAINT_NAME 이름, 
UC.CONSTRAINT_TYPE 유형,
UCC.COLUMN_NAME 컬럼명, 
UC.R_CONSTRAINT_NAME 참조,
UC.DELETE_RULE 삭제규칙
FROM USER_CONSTRAINTS UC
JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'USER_FOREIGNKEY';

--테이블 이름 변경
ALTER TABLE DEPT_COPY
RENAME TO DEPT_TEST;

RENAME DEPT_COPY TO DEPT_TEST;

--DROP
--싹다 삭제함
-- DROP TABLE DEPT_TEST CASCADE CONSTRAINT;

--VIEW
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
LEFT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
LEFT JOIN NATIONAL USING(NATIONAL_CODE);

--20230714
CREATE OR REPLACE VIEW V_EMP_JOB2 ()
AS SELECT EMP_ID , EMP_NAME , JOB_NAME , 
DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여'),
EXTRACT(YEAR FROM SYSDATE) – EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

sekect * from v_emp_job;
select extract (year from stsdate)
      ,extract(month from sysdate)
      ,extract(day from sysdate)
from dual;


CREATE OR REPLACE VIEW V_JOB(job_code, job_name)
AS SELECT j1.JOB_CODE, j1.JOB_NAME
    FROM JOB j1
        JOIN JOB j2
        on j1.job_code = j1.job_code
 --       USING(JOB_CODE);
--self join 은 반드시 table 별칭
INSERT INTO V_JOB VALUES('J8', '인턴');
commit;
SELECT * FROM V_JOB; 

create or replace view v_job2(job_code)
    as select job_code from job;
    
    insert into v_job2 values('J9');


--춘대학교 6번문항
--학생 번호 , 학생이름, 학과 이름을 학생이름으로 오름차순 정렬하여 출력하는 sql문을 작성하시오.
select student no, student_name, department_name
from TB_student
JOIN TB_DEPARTMENT USING(DEPARTMENT_NUM)
ORDER BY 2;
--04-2 
--나이 상 가장 막내의 사원코드, 사원명, 나이, 부서 명, 직급명 조회

select emp_id, emp_name, d.dept_title, j.job_name
    , Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2),'rr')) age
    from employee e
    join department d on (e.dept_code = d.dept_id)
    join "JOB" j using (job_code)
    where emp_no = (select max(emp_no) from employee)
;
select max(emp_no) from employee;
select max(emp_name) from employee;
select min(emp_name) from employee;
--
select Extract(year from sysdate)
    -extract(year from to_date(substr(emp_no,1,2),'yy'))
    from employee
;
select emp_no,extract(year from to_date(substr(emp_no,1,2),'yy')) ,
--rr은 50을 기준으로 1951,2049
    extract(year from to_date(substr(emp_no,1,2),'rr')),
    case 
    when Extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2),'yy')) < 0
    then Extract(year from sysdate)-(extract(year from to_date(substr(emp_no,1,2),'yy')) - 100)
    end age
from employee;
--
select extract(year from to_date('500112','yymmdd'))yy
        ,extract(year from to_date('500112','rrmmdd'))mm
        ,extract(year from to_date('450112','yymmdd'))yy
        ,extract(year from to_date('450112','rrmmdd'))mm
        FROM dual;
-- 4-7 한국이나 일본에서 근무 중인 사원 사원 명, 부서명, 지역 명, 국가 명 조회
select emp_name,d.dept_title, j.job_name, c.local_name, n.national_name
    from employee e
    join department d on (e.dept_code=d.dept_id)
    join "JOB" j using (job_code)
    join location c on (d.location_id=c.local_code)
    join national n using (national_code)
    where n.national_name in('한국','일본')
;
select *from department;
select *from location;
select *from national;

--4-8 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select e1.emp_name,e2.emp_name
    from employee e1
        join employee e2 on e1.dept_code = e2.dept_code
order by e1.emp_name
;

--2-21 employee테이블에서 직원명, 부서코드, 생년월일, 나이(만) 조회
-- (단, 생년월일은 주민번호에서 추출해서 00년00월00일로 출력되게하며
--나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산
select emp_name, dept_code,
        substr(emp_no,1,2)||'년'||substr(emp_no,3,2)||'월'||substr(emp_no,5,2)||'일' "생년월일"
--        "만나이"
        , extract(year from sysdate)-extract(year from to_date(substr(emp_no,1,2),'rr'))"만나이"
    from employee
;
--맞는거 같은데 오류뜸,,,,,,,,,,,,,,,
select emp_name
    ,to_date (substr(emp_no,1,6),'rrmmdd')
    ,to_char(to_date(substr(emp_no,1,6),'rrmmdd'), 'yy"년"mm"월"dd"일"')"생년월일"
    ,floor((sysdate - to_date(substr(emp_no,1,6),'rrmmdd'))/365)"진짜 만나이"
    from employee;
    
--춘대학교 5번 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼것인가?
--이떄, 19살에 입학하면 재수를 하지 않은것으로 간주한다.

select student_name, student_ssn, entrance_date from tb_student;
select*from(
    select student_name, student_ssn, entrance_date
    ,extract(year from to_date(substr(student_ssn,1,2),'rr')) birth
    ,extract(year from entrance_date) entr
    ,extract(year from entrance_date)- extract(year from to_date(substr(student_ssn,1,2),'rr'))+1 aaa
    from tb_student) tb1
where tb1.aaa > 20
;

--20230717
--group by - 꼭 지켜져야하는 룰: group by 컬럼명, 컬럼명 만 select 로 선택할수있음. 또는 그룹함수 사용가능.
select job_code,sum(salary) 
from employee
group by rollup(job_code) order by 1;

--집계(전체)
-- 문제에 00별 00을 구하라 하면 그룹바이써야함
select job_code,sum(salary)sumsal, count(*)cnt
from employee
group by rollup(job_code) order by 1;

--춘대학교 3-15 rollup, cube 사용

