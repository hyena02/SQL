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
SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY     
 FROM       EMPLOYEES                                    
 WHERE      SALARY  >= 5000
 ORDER BY   SALARY DESC;                                   



-- 전화번호에 100이 포함된 직원
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER 
 FROM  EMPLOYEES
 WHERE PHONE_NUMBER LIKE '%100%'           -- CONTAIN (X) -> LIKE 'KING%' / '%KING%' / '%KING'
 ORDER BY EMPLOYEE_ID ASC;
 
 
 
 
 -- 50번 부서의 직원을 출력해라                        -- " ?_?" : 쌍따옴표 쓰는 경우 -> "별 칭 "
SELECT  EMPLOYEE_ID                    "사 번",        -- 별칭, 별명, ALIAS
        FIRST_NAME ||' '|| LAST_NAME    이름,          -- 없이 사용 가능
        DEPARTMENT_ID                AS 부서번호       -- AS : 가독성 때문에 사용
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 50
    ORDER BY FIRST_NAME ASC,LAST_NAME ASC;     -- ||'  '|| 정렬  / 
    
    
/*
SELECT EMPLOYEE_ID "사 번"
       RPAD(FIRST_NAME, 15, ' ') || LAST_NAME AS 이름, // RPAD/ 채우기
       DEPARTMENT_ID AS 부서번호
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY FIRST_NAME ASC, LAST_NAME ASC;
*/
    
    
    
-- 부서가 없는 직원을 출력해라
SELECT      EMPLOYEE_ID
          , FIRST_NAME || ' ' || LAST_NAME ENAME
          , DEPARTMENT_ID
    FROM    EMPLOYEES
    WHERE   DEPARTMENT_ID IS NULL;      -- = NULL ( 작동안함 )  => IS NULL / IS NOT NULL 만 작동
 