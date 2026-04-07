 SELECT * FROM tab;  -- 테이블 목록
/*
     SELECT       칼럼명1 별명1,    칼럼명2 별명2, 칼럼명3 별명3, 
         FROM     테이블명
         WHERE    조건
         ORDER BY 정렬할 칼럼1 ASC, 정렬할칼럼2 DESC,
         
    -- 조건 : = / !=(<>,^=)
    --              >,<,>=,<=
    --              NOT, AND, OR         
         
         
*/
   
   
   
   
     
--직원이름을 성과 이름을 붙혀서 출력
    SELECT      FIRST_NAME, LAST_NAME, FIRST_NAME||'  '||LAST_NAME EMPNAME
     FROM       EMPLOYEES
     -- ORDER BY   FIRST_NAME||'  '||LAST_NAME
     -- ORDER BY   EMPNAME
     ORDER BY   3       --3번째 칼럼을 기준으로 
     ;


 
    SELECT        EMPLOYEE_ID                  사번,
                  FIRST_NAME ||' '||LAST_NAME  이름,
                  EMAIL                      이메일,
                  DEPARTMENT_ID             부서번호
        FROM      EMPLOYEES                  
        WHERE     DEPARTMENT_ID = 60
        ORDER BY  이름 ASC;
     

 -- 부서번호가 90인 직원정보 
    SELECT        EMPLOYEE_ID                  사번,
                  FIRST_NAME ||' '||LAST_NAME  이름,
                  EMAIL                      이메일,
                  DEPARTMENT_ID             부서번호
        FROM      EMPLOYEES                  
        WHERE     DEPARTMENT_ID = 90
        ORDER BY  이름 ASC;
        


-- 부서 번호가 60,90인 직원정보
    SELECT          E.EMPLOYEE_ID                        사번,
                    E.FIRST_NAME ||' '|| E.LAST_NAME     이름,
                    E.EMAIL                            이메일,
                    DEPARTMENT_ID                    부서번호
        FROM        EMPLOYEES  E 
        WHERE       DEPARTMENT_ID = 60
        OR          DEPARTMENT_ID = 90  -- OR : 이거나 ,이면 다 + 논리합 // OR 여러개 -> IN( ?, ?, ?,)
        ORDER BY    사번 ASC
        ;
        
--IN 명령어
    SELECT E.EMPLOYEE_ID                    사번,
        E.FIRST_NAME ||' '|| E.LAST_NAME    이름,
        E.EMAIL                            이메일,
        DEPARTMENT_ID                    부서번호
    FROM EMPLOYEES  E
    WHERE DEPARTMENT_ID    IN (90, 60, 50)
    ORDER BY 사번 ASC  , 이름 ASC                       -- 부서번호순( 부서번호가 같으면 이름순)
    ;
    
    
    
    
-- 1. 월급이 12000 이상인 직원의 번호,이름,이메일,월급을 월급순으로 출력
    SELECT   E.EMPLOYEE_ID                      사번,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.EMAIL                            이메일,
             E.SALARY                           월급
    FROM     EMPLOYEES E
    WHERE    E.SALARY >= 12000
    ORDER BY 월급 ASC , 이름 ASC
    ;
    
    
-- 2. 월급이 10000~15000 인 직원의 사번,이름 월급 부서번호
    SELECT   E.EMPLOYEE_ID                      사번,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.EMAIL                            이메일,
             E.SALARY                           월급
    FROM     EMPLOYEES E
    WHERE    10000 <= E.SALARY 
    AND      E.SALARY <= 15000      
    ORDER BY 월급 ASC , 이름 ASC
    ;  
    /*
        WHERE    SALARY     BETWEEN 10000 AND 15000   
        WHERE    SALARY NOT BETWEEN 10000 AND 15000  
    */    
    
-- 3. 직업ID가IT_PROG인 직원명단
    SELECT   E.EMPLOYEE_ID                      사번,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.EMAIL                            이메일,
             E.JOB_ID                           직업ID
             
    FROM     EMPLOYEES E
    WHERE    UPPER(E.JOB_ID) = 'IT_PROG'
    ORDER BY 이름 ASC
    ;
    /*
            WHERE   E.JOB_ID LIKE 'IT%'
    
    XXXXX   WHERE   E.EMPLOYEE_ID = 'IT_PROG' OR 'it_prog' XXXXX
            WHERE   UPPER(E.HOB_ID) = 'IT_PROG'
            WHERE   LOWER(E.HOB_ID) = 'IT_PROG'
    */  
    
   
--    4.직원이름이 GRANT인 직원을 찾으세요
    SELECT   E.EMPLOYEE_ID                      사번,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.EMAIL                            이메일
    FROM     EMPLOYEES E
--    WHERE    E.FIRST_NAME ='GRANT'
--    OR       E.LAST_NAME  ='GRANT'
    WHERE    UPPER(E.FIRST_NAME) LIKE '%GRANT%'
    OR       UPPER(E.LAST_NAME) LIKE '%GRANT%'
    ORDER BY 사번 ASC
    ;

--  5. 사번, 월급 10% 인상한 월급
    SELECT      EMPLOYEE_ID                   EMPID,
                FIRST_NAME ||' '||LAST_NAME   ENAME,
                SALARY                        SAL,
                SALARY * 1.1                  SAL2
    FROM        EMPLOYEES E  
    ORDER BY    SALARY * 1.1 DESC
    ;
    
    
    
--  6. 50번 부서의 직원명단,월급 부서번호
    SELECT   E.EMPLOYEE_ID                      번호,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.SALARY                           월급,
             E.DEPARTMENT_ID                    부서번호
    FROM     EMPLOYEES E
    WHERE    E.DEPARTMENT_ID = 50
    ORDER BY 이름 ASC 
    ;
    
--  7. 20,80,60,90번 부서의 직원명단 월급, 부서번호
    SELECT   E.EMPLOYEE_ID                      번호,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.SALARY                           월급,
             E.DEPARTMENT_ID                    부서번호
    FROM     EMPLOYEES E
    WHERE    E.DEPARTMENT_ID IN (20,60,80,90)
    ORDER BY  부서번호 ASC, 이름 ASC
    ;
    
    
    
    
    
    
    