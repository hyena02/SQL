SELECT * FROM TAB;
-- f5 전체 스크립트 실행(텍스트로나옴)/ f9 한줄 실행(표로나옴)  ,  /**/
DESC EMPLOYEES;  

SELECT * FROM EMPLOYEES;

-- 직원번호가 100인 사람을 출력 / SELECT* : 모든컬럼 / *숫자 : 곱하기 / COUNT(*) : 전체 행 개수
SELECT * 
  FROM  EMPLOYEES
  WHERE EMPLOYEE_ID = 100;
  
--King 이라는 직원을 출력
SELECT *
  FROM EMPLOYEES 
  WHERE LAST_NAME = 'King';  -- '' = 문자 (값), ""=이름(Column,table)
  
  -- 월급순 내림차순으로 직원정보를 출력
SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY       -- Column 
 FROM       EMPLOYEES                                        -- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
 ORDER BY   SALARY DESC;                                     -- ORDER BY : 정렬 / DESC 내림차순
 
  -- 월급이 내림차순으로 직원정보를 출력
SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY       -- Column 
 FROM       EMPLOYEES                                        -- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
 WHERE      SALARY  >= 5000
 ORDER BY   SALARY DESC;                                     -- ORDER BY : 정렬 / DESC 내림차순

-- 전화번호에 100이 포함된 직원
SELECT PHONE_NUMBER 
 FROM  EMPLOYEES
 WHERE PHONE_NUMBER LIKE '%100%';           -- CONTAIN (X) -> LIKE 'KING%' / '%KING%' / '%KING'
 
 
 
 -- 50번 부서의 직원을 출력해라
SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID LIKE '%50%';
    
-- 부서가 없는 직원을 출력해라
SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IS NULL;
