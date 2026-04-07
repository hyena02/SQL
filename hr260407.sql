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
   
   
   
   
     
-- 직원이름을 성과 이름을 붙혀서 출력
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
    
   
--  4. 직원이름이 GRANT인 직원을 찾으세요
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
    -- IN : 여러 개 중에 하나라도 맞으면 OK (이 안에 있냐 ?) <=> NOT IN(?,?)
    
    
--------------------------------------------------------------------------------------------------------------    
    
-- 중요 데이터 2개 입력
    SELECT COUNT(*)
        FROM EMPLOYEES ;  
                    -- 전체 자료수 출력 (            ( * ) -> NULL 상관없이 무조건 다 셈, 모든 행 개수)
                    --                  (SELECT COUNT(???) -> NULL제외 값이 있는 것만 셈)
        
    SELECT SYSDATE
      FROM DUAL;        
      
    SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS')        -- 오늘날짜 :연/월/일/시/분/초
      FROM DUAL;
     
-- 신입사원 입사 (박보검, 장원영)

    INSERT INTO EMPLOYEES
        VALUES (207, '보검','박','AAAA','1.111.111.0001',
                SYSDATE, 'IT_PROG', NULL, NULL, NULL, NULL);
                
    INSERT INTO EMPLOYEES
        VALUES (208, '원영','카','AAAB','1.111.111.0002',
               SYSDATE, 'IT_PROG', NULL, NULL, NULL, NULL);
 
 SELECT       *  FROM EMPLOYEES;
 SELECT COUNT(*) FROM EMPLOYEES;
 
 UPDATE EMPLOYEES
  SET   EMAIL           = 'AAAC',
        PHONE_NUMBER    = '010-1234-5678'
 WHERE  EMPLOYEE_ID      = 208
 ;
        

        
        
        
COMMIT;
ROLLBACK ;

// cmd - sqlplus -> 명령창확인
    SELECT FIRST_NAME FROM EMPLOYEES
    WHERE EMPLOYEE_ID >206;
    
    
    
    
-- 8. 보너스없는 직원명단 (COMMISSION_PCT 가 없다)
    SELECT E.EMPLOYEE_ID                    사번,
           E.FIRST_NAME||' '||LAST_NAME     이름,
           E.COMMISSION_PCT                  보너스
    FROM EMPLOYEES E
    WHERE E.COMMISSION_PCT IS NULL
    ORDER BY 사번 ASC
    ;
    
-- 9. 전화번호가 010으로 시작하는
    SELECT E.EMPLOYEE_ID                    사번,
            E.FIRST_NAME||' '||LAST_NAME    이름,
            E.PHONE_NUMBER                  전화번호
    FROM    EMPLOYEES E
    WHERE   E.PHONE_NUMBER LIKE '010%'
    ORDER BY 사번 ASC
    ;
    
--10. LAST_NAME 세번째, 네번째 글자가 LL인것을 찾아라
    SELECT  E.EMPLOYEE_ID                   사번,
            E.FIRST_NAME||' '||LAST_NAME    이름
    FROM    EMPLOYEES E
    WHERE   UPPER(LAST_NAME) LIKE '__LL%'
    ORDER BY 사번 ASC
    ;
----------------------------
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM    EMPLOYEES;
WHERE




날짜 26/04/07   : 표현법이 틀림 년/월/일
2026-04-07      : ANSI 표준
04/07/26        : 월/일/년 -> 미국식
07/04/26        : 일/월/년 -> 영국식


SELECT SYSDATE FROM DUAL;   -- 26/04/07
SELECT 7/2 FROM DUAL;       -- 3.5
SELECT 0/2 FROM DUAL;       -- 0
SELECT 2/0 FROM DUAL;       -- 오류 : ORA-01476 : 제수가 0입니다
SELECT SYSTIMESTAMP FROM DUAL' - 26/04/07 15:40:05.687000000 +09:00


  SELECT SYSDATE - 7        -- "일주일 전 날짜"
        ,SYSDATE            -- "오늘날짜"
        ,SYSDATE + 7        -- "일주일 후 날짜"
    FROM DUAL;
    
    
날짜 + n / 날짜 - N : 몇 일 전 / 후 ,
날짜 1 - 날짜 2     : 두 날짜 사이의 차이를 날 수로 계산
날짜 + 날짜  : 오류

SELECT  TO_DATE('26/12/25') -SYSDATE     -- 261.339560185185185185185185185185185185일
FROM DUAL;
  
  -- 소수이하 3자리로 반올림 :ROUND(VAL,3)
  -- 소수이하 3자리로 절사 : TRUNC(VAL, 3)
  -- 15일 기준으로 반올림날짜 : ROUND(SYSDATE, 'MONTH')
SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH')
FROM DUAL;

SELECT NEXT_DAY (SYSDATE, '월요일') FROM DUAL; -- 26/04/01 
SELECT LAST_DAY (SYSDATE)           FROM DUAL; -- 26/04/30
SELECT TRUNC(SYSDATE, 'MONTH')      FROM DUAL; -- 26/04/07

--11. 입사년월이 17년 2월인 사원출력
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM EMPLOYEES
    WHERE TO_CHAR(HIRE_DATE,'YYYY-MM')='2017-02';
    
    
    SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE
    FROM        EMPLOYEES
    WHERE       HIRE_DATE
        BETWEEN '2017-02-01'
        AND     LAST_DAY('2017-02-01')
    ;

--12.''17/02/07' 에 입사한 사람출력

    SELECT E.EMPLOYEE_ID                        사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            TO_CHAR(E.HIRE_DATE, 'YYYY-MM-DD')  입사년월
    FROM    EMPLOYEES E
    WHERE   E.HIRE_DATE = '2017-02-07'     
    ORDER BY 이름 ASC
    ;
    
-- '12/06/07'에 입사한 사람출력
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE    '2026-04-07 00:00:00' <= HIRE_DATE
    AND       HIRE_DATE  <= '2026-04-07 23:59:59'
    ;
    
    
    SELECT E.EMPLOYEE_ID                        사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            TO_CHAR(E.HIRE_DATE, 'YYYY-MM-DD')  입사년월
    FROM    EMPLOYEES E
    WHERE   E.HIRE_DATE = '12-06-07'     
    ORDER BY 이름 ASC
    ;
    
--13.오늘 '26/04/07'에 입사한 사람
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE    '2026-04-07 00:00:00' <= HIRE_DATE
    AND       HIRE_DATE  <= '2026-04-07 23:59:59'
    ;
------------------------------------------------------------------
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE TRUNC (HIRE_DATE) = '2026-04-07 00:00:00';

-- TYPE 변환
--TO_DATE(문자)           -> 날짜
--TO_NUMBER(숫자, '포맷') ->숫자
--TO_CHAR(숫자, '포맷')   ->글자
--포맷 : YYYY-MM-DD HH24:MI:SS DAY AM
    -- YYYY : 연도
    -- MM   : 월
    -- DD   : 일
    -- HH24 : 24시 (HH12 : 12시) /  MI : 분  / SS : 초
    -- DAY  : 요일 , 일요일
    -- DY   : 요일 , 일
    -- AM/PM   : 오전/ 오후
--13.1 입사 후 일주일 이내인 직원명단

    SELECT  E.EMPLOYEE_ID                       사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            TO_CHAR(E.HIRE_DATE, 'YYYY-MM-DD')  입사년월
    FROM    EMPLOYEES E           
    WHERE   SYSDATE - E.HIRE_DATE <=7
    ORDER BY E.HIRE_DATE ASC
    ;

--13.2 화요일 입사자를 출력               
    SELECT  E.EMPLOYEE_ID                       사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            TO_CHAR(E.HIRE_DATE,'YYYY-MM-DD')    입사일,
            TO_CHAR(E.HIRE_DATE, 'DY','NLS_DATE_LANGUAGE=KOREAN') 요일
    FROM    EMPLOYEES E
    WHERE   TO_CHAR(E.HIRE_DATE, 'DY', 'NLS_DATE_LANGUAGE=KOREAN') = '화'
    ORDER BY    이름 ASC
    ;
     
                    
                    
--13.3  08월 입사자의 사번, 이름, 입사일을 입사일 순으로
    SELECT  E.EMPLOYEE_ID                       사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            E.HIRE_DATE                        입사일,
            TO_CHAR(E.HIRE_DATE, 'MM')      입사_월
    FROM    EMPLOYEES E
    WHERE   TO_CHAR(E.HIRE_DATE, 'MM') = 08
    ORDER BY 입사일 ASC
    ;
    
    
--13.4 부서번호 80이 아닌 직원
    SELECT  E.EMPLOYEE_ID                       사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            E.DEPARTMENT_ID                    부서번호
    FROM    EMPLOYEES E
    WHERE   E.DEPARTMENT_ID >80
    OR      E.DEPARTMENT_ID <80
    ORDER BY 부서번호 ASC, 사번 ASC
    ;
    
    
                /*    
            --화요일 입사자를 출력
                SELECT  E.EMPLOYEE_ID                       사번,
                        E.FIRST_NAME||' '||LAST_NAME        이름,
                        TO_CHAR(E.HIRE_DATE, 'YYYY-MM-DD')  날짜,
                        DECODE(TO_CHAR(E.HIRE_DATE,'D'), 1, '일'
                                                       , 2, '월'
                                                       , 3, '화'           
                                                       , 4, '수'
                                                       , 5, '목'                                           
                                                       , 6, '금'                                           
                                                       , 7, '토') "요일"                                                                                  
                FROM    EMPLOYEES E
                WHERE   TO_CHAR(E.HIRE_DATE, 'D')= 3
                ORDER BY    이름 ASC
                ;
                
                -------------------------------------------------------------

                WHERE TO_CHAR(E.HIRE_DATE, 'DY', 'NLS_DATE_LANGUAGE=KOREAN') = '화'
                WHERE TO_CHAR(E.HIRE_DATE, 'DY', 'NLS'
            */  
               
    
--------------------------------------------------------

날짜 26/04/07   : 표현법이 틀림 년/월/일
2026-04-07      : ANSI 표준
04/07/26        : 월/일/년 -> 미국식
07/04/26        : 일/월/년 -> 영국식


SELECT SYSDATE FROM DUAL;   -- 26/04/07
SELECT 7/2 FROM DUAL;       -- 3.5
SELECT 0/2 FROM DUAL;       -- 0
SELECT 2/0 FROM DUAL;       -- 오류 : ORA-01476 : 제수가 0입니다
SELECT SYSTIMESTAMP FROM DUAL' - 26/04/07 15:40:05.687000000 +09:00

  SELECT SYSDATE - 7        -- "일주일 전 날짜"
        ,SYSDATE            -- "오늘날짜"
        ,SYSDATE + 7        -- "일주일 후 날짜"
    FROM DUAL;


날짜 + n / 날짜 - N : 몇 일 전 / 후 ,
날짜 1 - 날짜 2     : 두 날짜 사이의 차이를 날 수로 계산
날짜 + 날짜  : 오류



SELECT  TO_DATE('26/12/25') -SYSDATE     -- 261.339560185185185185185185185185185185일
FROM DUAL;
  
  -- 소수이하 3자리로 반올림 :ROUND(VAL,3)
  -- 소수이하 3자리로 절사 : TRUNC(VAL, 3)
  -- 15일 기준으로 반올림날짜 : ROUND(SYSDATE, 'MONTH')
SELECT SYSDATE, ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH')
FROM DUAL;

SELECT NEXT_DAY (SYSDATE, '월요일') FROM DUAL; -- 26/04/01 
SELECT LAST_DAY (SYSDATE)           FROM DUAL; -- 26/04/30
SELECT TRUNC(SYSDATE, 'MONTH')      FROM DUAL; -- 26/04/07



--11. 입사년월이 17년 2월인 사원출력
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM EMPLOYEES
    WHERE TO_CHAR(HIRE_DATE,'YYYY-MM')='2017-02';
    
    
    
    SELECT      EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE
    FROM        EMPLOYEES
    WHERE       HIRE_DATE
        BETWEEN '2017-02-01'
        AND     LAST_DAY('2017-02-01')
    ;

-- '12/06/07'에 입사한 사람출력
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE    '2026-04-07 00:00:00' <= HIRE_DATE
    AND       HIRE_DATE  <= '2026-04-07 23:59:59'
    ;
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE TRUNC (HIRE_DATE) = '2026-04-07 00:00:00';

-- TYPE 변환
--TO_DATE(문자)           -> 날짜
--TO_NUMBER(숫자, '포맷') ->숫자
--TO_CHAR(숫자, '포맷')   ->글자
--포맷 : YYYY-MM-DD HH24:MI:SS DAY AM
    -- YYYY : 연도
    -- MM   : 월
    -- DD   : 일
    -- HH24 : 24시 (HH12 : 12시) /  MI : 분  / SS : 초
    -- DAY  : 요일 , 일요일
    -- DY   : 요일 , 일
    -- AM/PM   : 오전/ 오후


--13.2 화요일 입사자를 출력
SELECT   EMPLOYEE_ID,
         FIRST_NAME, 
         LAST_NAME, 
         TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'),
         TO_CHAR(HIRE_DATE, 'DAY')
FROM     EMPLOYEES
WHERE    TO_CHAR(HIRE_DATE,'DY')='화'
ORDER BY HIRE_DATE ASC;

COMMIT;



    