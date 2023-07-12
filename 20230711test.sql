--join
-- 연결에 사용하려는 컬러명이 같은경우 Using()사용
--다른 경우 on()사용

select emp_id, emp_name, job_code, job_name
from employee
join job using(job_code);

select emp_id, emp_name, dept_code, dept_title
from employee
join department on(dept_code = dept_id);

--inner join 과 outer join
--기본적으로 join은 inner join이며
--두개 이상의 테이블을 조인할떄 일치하는값이 없는 행은 조인에서 제외됨
-- outer join은 일치하지 않은 값도 포함이 되며 반드시 
--outer join 명시

select emp_name,dept_title
from employee
join department
on(dept_code = dept_id);

select emp_name, dept_title
from employee
left join department
on(dept_code = dept_id);

--self join
--두개 이상의 서로 다른 테이블을 연결하는 것이 아닌
--같은 테이블을 조인하는것
SELECT e.emp_id, e.emp_name 사원이름, e.dept_code, e.manager_id,
m.emp_name 관리자이름
from employee e, employee m
where e.manager_id = e.emp_id;

--다중 join
--하나 이상의테이블에서 데이터를 조회하고 위해 사용하고 수행 결과는
--하나의 result으로 나옴

select emp_id, emp_name, dept_code, dept_title, local_name
from employee
join department on (dept_code = dept_id)
join location on (location_id = local_code);