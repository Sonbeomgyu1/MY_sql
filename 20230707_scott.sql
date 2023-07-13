-- 학습용 SCOTT 명령어들
SELECT *
FROM EMP
;
SELECT EMPNO, ENAME, SAL
FROM EMP
;
SELECT ENAME, MGR, SAL, DEPTNO
FROM emp
WHERE DEPTNO=20 OR SAL>1500
;
SELECT ENAME, MGR, SAL, DEPTNO
FROM emp
--WHERE ENAME = 'smith';
WHERE ENAME = 'SMITH'
-- ORA-00904: "SMITH": 부적합한 식별자
;
select empno, ename, sal
from emp
;
-- * 을 사용하는 것 보다 속도 빠름. 권장.
select empno, ename, job, mgr, hiredate, sal, comm, deptno
from emp;
-- * 보다 컬럼명을 나열하는 것이 속도면에서 좋음.
select * from emp;
select * from dept;
select * from salgrade;
select * from bonus;


-- Q: 사원명과 연봉과 보너스포함한 연봉을 조회
select ename, sal*12, sal*12 + nvl(comm, 0)
from emp
;
select comm, nvl(comm, 0), nvl(comm, 100)
from emp
;
select ename as "사원명", sal*12 as "연봉", sal*12 + nvl(comm, 0) as "보너스 포함 연봉"
from emp
;
select ename "name", sal*12 sal12, sal*12 + nvl(comm, 0) salwcomm
from emp
;

select '안녕' as hello
from emp
;
select '안녕' as hello
from dept
;
select '$' as 단위, sal
from emp
;
select distinct '$' as 단위, sal
from emp
;

-- 급여를 1500보다 많이 받고 2800보다 적게 받는 직원 이름과 급여 조회
-- between and 사용
select ename, sal
    from emp
    where sal between 1500 and 2799
;
-- >= <= 사용
select ename, sal
    from emp
    where sal >= 1500 and sal < 2800
;
--20번 부서를 제외한 ( !=, <> , ^= ) 사원 정보를 조회
select *
    from emp
--        where deptno != 20
--        where depno <> 20
--        where deptno ^= 20
--        where not deptno = 20
          WHERE deptno not in (20, 10)  --20번부서와 10번부서를 제외한 나머지 부서를 나타내주세요
;
-- 10, 20,30 부서를 사원 정보를 조회
select *
    from emp
--    where not (deptno = 10 OR deptno = 20 or deptno = 30)
    where deptno in(10,20,30)
;
-- 10, 20 부서를 제외한 사원 정보를 조회
select *
    from emp
--  where deptno !=10 and deptno !=20
    where deptno not in(10,20,30)
;
--20번 부서를 제외한 사원 중 comm이 null인 사원 정보를 조회
select *
    from emp
    where depno = 20 and comm  is not null
-- 오류      comm != null    
;

--'s'로 시작하는 2글자이상의 이름을 가진 직원 이름과 급여 조회
select ename, sal
from emp
where ename like 'S_%'
;
--이름중 3번쨰 글자가 'S'인 직원 이름과 급여 조회
SELECT ename, sal
from emp
where ename like '___S%'
;

-- 이름중 3번쨰 글자가 '_'인 직원 이름과 급여 조회
SELECT ename, sal
from emp
--이름이 4글자 이상인 직원
--where ename like '___%'
where ename like '___%' escape '/'
    or job like '__@_%' escape '@'
;
-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
select *
from emp
where mgr is null
    and deptno is null
;
--관리자가 없지만 보너스를 지급받는 직원 조회
SELECT * from emp
where mgr is null
and comm is not null
;
--20 부서와 30 부서원들의 이름, 부서코드 급여조회
SELECT ename,deptno, sal
from emp 
where deptno in ('20', '30')
;
-- analyst 또는 salesman 인 사원 중 급여를 2500보다 많이 받는 직원의 이름, 급여, 직급코드 조회
SELECT ename, sal, job
from emp
where job in ('ANALYST', 'SALESMAN')
 AND sal > 2500
 ;
 
 --사원명의 길이와 byte크기를조회
 SELECT length(ename), lengthb(ename)
 from emp
 ;
 
 --select 'a안 녕b', length('a안녕b'),lengthb('a안 녕b')
 select trim('a안 녕b'), length(trim('a안녕b')),lengthb(trim('a안 녕b'))
 --from emp
 from dual
 -- 테이블 dual은 임시테이블로 연산이나 간다한 함수 결과값을 조회할떄 사용함.
 ;
 --사원명의 시작부분 s와 끝나는 부분 s 모두 제거해주세요.
 SELECT Rtrim(Ltrim(ename,'S'),'S')from emp;
 --Ltrim 예시 010 제거
 
 --Lpad / Rpad 채워넣기 
 --ename이 총 10자가 되도록 left쪽에 'S'를 채워주세요.
SELECT Lpad(ename,10,'S')from emp;
  --ename 이 총 10자가 되도록 left 쪽에 ' '공백(default)를 채워주세요.
select Lpad(ename, 10) from emp;
 
 --문자열(컬럼) 이어붙이기 
select concat(ename, comm) from emp;
select ename ||comm from emp;
select sal||'달러' from emp;
select concat(sal, '달러') from emp;
--substr 엄청중요!!!!!
--replace
select replace(ename, 'SM' ,'A' ) from emp;

--2023.07.10
select sysdate, to_char(sysdate, 'yyyy.mm.dd (dy) hh24:mi:ss') from dual;
select sysdate, to_char(sysdate, 'yyyy.mm.dd (dy) hh24:mi:ss') from dual;

alter session set NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';
SELECT sysdate from dual;
select * from emp;

-- year 2023 month 09 day 11 hour 13
select to_date('2023091113', 'yyyymmddhh24') from dual;
select add_months(to_date('2023091113', 'yyyymmddhh24'),5) from dual;
select next_day(to_date('2023091113', 'yyyymmddhh24'),'일') from dual;
-- 1:일요일 2 월요일, 3 화요일....
SELECT last_day('2023091113') from dual;  --이건 안되는 코드임. 오라클xe 라서 실행 되는것.

select to_char(empno,'000000'), trim(to_char(sal, '999,999,999,999'))
from emp;

select to_number('123,4567,8901', '999,9999,9999')*4 from dual;

-- 직원들의 평균 급여는 얼마인지 조회
SELECT avg(sal) 평균급여 from emp;
SELECT sum(sal) sum from emp;
SELECT max(sal) max from emp;
SELECT min(sal) min from emp;
SELECT min(sal) count from emp;

--부서별 평균급여 조회
SELECT avg(sal) 평균급여, deptno from emp group by deptno;
SELECT sum(sal) 평균급여, deptno from emp group by deptno;
SELECT max(sal) 평균급여, deptno from emp group by deptno;
SELECT min(sal) 평균급여, deptno from emp group by deptno;
SELECT count(sal) 평균급여, deptno from emp group by deptno;

--job별 평균 급여 조회
SELECT avg(sal) 평균급여,job from emp group by job;
SELECT sum(sal) sum,job from emp group by job;
SELECT max(sal) max,job from emp group by job;
SELECT min(sal) min,job from emp group by job;
SELECT min(sal) count,job from emp group by job;

--job이 analyst인 직원의 평균 급여 조회
select avg(sal) 평균급여, job
    from emp
    group by job
    having job = 'ANALYST'
;

select avg(sal) 평균급여, job
    --오류 , job
    from emp
    where job = 'ANALYST'
;

--job이 analyst인 부서별 직원의 평균 급여 조회
--job이 analyst 인 부서별 직원
select job, deptno
    from emp
    where job='CLERK'
;
--JOB이 CLERK 인 부서별 직원의 평균 급여조회
select job, deptno, AVG(SAL)
    from emp
    where job='CLERK'
    GROUP BY DEPTNO, JOB
;

select ename, sal*12+nvl(comm,0) salcomm
    from emp
    order by 2 desc, 1 desc
;
-- job 오름차순
select * from emp
 --   order by job;
    order by 3;
    
-- EMPLOYEE에서 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의 평균(정수처리), 인원 수를 조회하고 부서 코드 순으로 정렬

-- EMPLOYEE테이블에서 부서코드와 보너스 받는 사원 수 조회하고 부서코드 순으로 정렬

-- EMPLOYEE테이블에서 성별과 성별 별 급여 평균(정수처리), 급여 합계, 인원 수 조회하고 인원수로 내림차순 정렬

--사원명, 부서번호, 부서명, 부서위치를 조회
select * from dept;
select * from emp;
select * 
    from emp
    join dept on emp.deptno = dept.deptno
;
select  ename, emp.deptno, dname,loc
    from emp
    join dept on emp.deptno = dept.deptno
;
select * from emp join dept using (deptno);

--부서위치가 dallas인 사원명,부서번호,부서명, 위치를 조회
select ename, dept.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno
and loc = 'DALLAS'
;

select empno, loc
from emp cross join dept;

select * from emp;
select * from salgrade;
--사원의 이름, 사번, sal, grade를 조회
select e.ename,e.empno,e.sal,s.grade
from emp e
    join salgrade s on e.sal between s.losal and s.hisal
    order by s.grade desc, e.sal
;

select empno, ename, mgr from emp;
--같은 이름 컬러명이 나타나지 않도록 별칭 사용
select e.empno boss, e.ename, m.empno emp, m.ename emps
    from emp e join emp m
    on e.empno = m.mgr
;
select ename from emp where empno=7566
;
select * from emp;

--자료형
CREATE table t1 ( c1 char(5), c2 varchar2(5));
insert into t1 values('12345','12345');
commit;
select * from t1;
select length(c1), length(c2) from t1;

desc t1;
desc emp;

--ERD(entisy relationship diagram
-- UML - classDiagram, ERD

--인라인뷰 (inline-view)
--오류
select rownum, e.* from emp e where deptno in (20,30)
order by hiredate asc
;
--해결 방법
select rownum, e.* from (select * from emp order by ename asc)e 
where deptno in (20,30)
;

-- 1page 1-3
select rownum, e.*
    from( select * from emp where deptno in (20,30) order by ename asc) e
    where rownum between 1 and 3
;
-- 2page 4-6
select rownum rnum, e.*
    from( select * from emp where deptno in (20,30) order by ename asc) e
    where rownum between 4 and 6
--    rnum은 select -6수행순서로 where 절에서 사용할수 없음
;
-- 3page 7-9
select *
    from (select rownum rnum, e.* 
    from (select * from emp where deptno in (20,30) order by ename asc) e
    )
    where rnum between 7 and 9
    
    
    with abc (select rownum rnum, e.*
    from (select * from emp where deptno in (20,30) order by ename asc)e)
   select *
   from abc
    where rnum between 7 and 9
    ;
    
    create view view_abc
    as
    select rownum rnum, e.*
    from (select * from emp where deptno in (20,30) order by ename asc)e
    ;
    select * from view_abc;
    where rnum between 7 and 9
    --abc 가 마치 새로우 테이블 것처럼 사용 가능
    
    --20230712
    -- 03-11. grade별로 평균 급여에 10프로내외의 급여를 받는 사원명을 조회-정렬
    select s.grade, e.ename
        from emp e join salgrade s
            on e.sal between s.losal and s.hisal
        where e.sal > 
        --다중 행 결과물과 >=비교안됨.(950, 1266, 1550, 2879, 5000)
        (
        select avg(sal) 
            from emp e2 join salgrade s2
            on e2.sal between s2.losal and s2.hisal
            where s2.grade = s.grade
            --group by s.grade having s2.frade =4
            )*1.1
;
--select에서 rownum 별칭
--select에서 함수 사용한 경우 반드시 별칭
--with 사용
with abc2 as( select avg(sal) avgsal 
            from emp e2 join salgrade s2
            on e2.sal between s2.losal and s2.hisal
            where s2.grade = s.grade
            )
select s.grade, e.enme, e.sal
            from emp e2 join salgrade s
            on e.sal between s.losal and s.hisal
            where e.sal > abc2.avgsal*0.9 and e.sal < abc2.avgsal*1.1
            ;
            ----------------------------
with abc3 as(select s.grade, e.enme, e.sal
            from emp e join salgrade s
            on e.sal between s.losal and s.hisal)
            
select *
from abc3 t1
where sal between (select avg(t2.sal) from abc3 t2 where t2.frade=t1.grade)*
and (select avf(t2.sal) from abc3 t2 where t2.frade = t1.frade)*1.1
;
Creat or replace view view_emp_salfrade
(select e.empno, e.ename, job, mgr, hiredate, sal, comm, deptno, grade, losal, hisal
from emp e join salfrade s
on e.sal between s.losal and s.hisal
;

select avg(sal), s.grade
    from emp e join salgrade s
    on e.sal between s.losal and s.hisal
    group by s.grade
    ;
    
-- from 절 subquery

--group by 사용시
-- select 컬럼명으로는 group by에 사용된 컬럼명 작성가능. 그리고 그룹함수 사용가능.
        select avg(e2.sal)*0.9 minsal, avg(e2.sal)*1.1 maxsal,avg(e2.sal) avgsal, s2.grade 
            from emp e2 join salgrade s2 on e2.sal between s2.losal and s2.hisal
            group by s2.grade ;

--실습 3-12            
--지역 재난 지원금을 사원들에게 추가지급
--조건 :
--1. NEW YORK지역은 SAL의 2%, DALLAS지역은 SAL 5%, CHICAGO지역은 SAL의 3%,BOSTON지역은 SAL 7%
--2.추가지원금이 많은 사람 순으로 정렬

SELECT empno,ename, sal, loc,
--    decode(loc, 'NEW YORK, sal*0.02,'DALLAS',sal*0.05,'CHICAGO',sal*0.03,'BOSTON',sal*0.07,0)
    case loc
        when 'NEW YORK' then sal*0.02
        when 'DALLAS' then sal*0.05
        when 'CHICAGO' then sal*0.03
        when 'BOSTON' then sal*0.07
    end
    as sal_sunsidy
    from emp e
        join dept d using(deptno)
--    where
--    group by
--   having
    order by sal_sunsidy
;

--salesman들의 급여와 같은 급여를 받는 사원을조회
select empno, ename, sal
    from emp
    where sal >any(select sal from emp where job='SALESMAN')
    ;
select ename,sal from emp where job='SALESMAN';

--관리자로 등록되어 있는 사원들을 조회
select empno, ename
    from emp e
    where exists (select empno from emp e2 where e2.empno = e.mgr)
;
select * from emp;

select distinct e.empno, e.ename
    from emp e join emp e2
        on e.empno = e2.mgr 
;
--join 대비 상관쿼리 사용시 속도 향상

-- 부서 번호가 30인 사원들의 급여와 부서번호를 묶어 메인 쿼리로 전달해보자.
select *
    from emp
    where (deptno, sal) in (select deptno, sal from emp where deptno=30)
;

--부서별 평균급여와 직원들 정보를 조회해주세요.
select e.*,
    --스칼라서브쿼리 작성되어야함.
    (select trunc(avg(sal)) from emp e2 where e2.deptno=e.deptno)
    from emp e
;

-- 직우너 정보와 부서번호, 부서명, 부서위치
select ename, deptno, dname, loc
    from emp join dept using(deptno);
    
select ename, deptno,
    (select dname from dept d where d.deptno=e.deptno) dname
    ,(select loc from dept d where d.deptno=e.deptno) loc
    from emp e;