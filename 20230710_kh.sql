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
