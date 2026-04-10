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
   
   
   
   
     
------------- 직원이름을 성과 이름을 붙혀서 출력-----------
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
     

 ---------- 부서번호가 90인 직원정보 -------------
    SELECT        EMPLOYEE_ID                  사번,
                  FIRST_NAME ||' '||LAST_NAME  이름,
                  EMAIL                      이메일,
                  DEPARTMENT_ID             부서번호
        FROM      EMPLOYEES                  
        WHERE     DEPARTMENT_ID = 90
        ORDER BY  이름 ASC;




------------ 부서 번호가 60,90인 직원정보-----------
    SELECT          E.EMPLOYEE_ID                        사번,
                    E.FIRST_NAME ||' '|| E.LAST_NAME     이름,
                    E.EMAIL                            이메일,
                    DEPARTMENT_ID                    부서번호
        FROM        EMPLOYEES  E 
        WHERE       DEPARTMENT_ID = 60
        OR          DEPARTMENT_ID = 90  -- OR : 이거나 ,이면 다 + 논리합 // OR 여러개 -> IN( ?, ?, ?,)
        ORDER BY    사번 ASC
        ;
        
-------------------IN 명령어----------------------
    SELECT E.EMPLOYEE_ID                    사번,
        E.FIRST_NAME ||' '|| E.LAST_NAME    이름,
        E.EMAIL                            이메일,
        DEPARTMENT_ID                    부서번호
    FROM EMPLOYEES  E
    WHERE DEPARTMENT_ID    IN (90, 60, 50)
    ORDER BY 사번 ASC  , 이름 ASC                       -- 부서번호순( 부서번호가 같으면 이름순)
    ;
    
    
    
    
----------------------- 1. 월급이 12000 이상인 직원의 번호,이름,이메일,월급을 월급순으로 출력---------------------
    SELECT   E.EMPLOYEE_ID                      사번,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.EMAIL                            이메일,
             E.SALARY                           월급
    FROM     EMPLOYEES E
    WHERE    E.SALARY >= 12000
    ORDER BY 월급 ASC , 이름 ASC
    ;
    
    
----------------------- 2. 월급이 10000~15000 인 직원의 사번,이름 월급 부서번호---------------------
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
    
----------------------- 3. 직업ID가IT_PROG인 직원명단---------------------
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
            
   
-----------------------  4. 직원이름이 GRANT인 직원을 찾으세요---------------------
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

-----------------------  5. 사번, 월급 10% 인상한 월급---------------------
    SELECT      EMPLOYEE_ID                   EMPID,
                FIRST_NAME ||' '||LAST_NAME   ENAME,
                SALARY                        SAL,
                SALARY * 1.1                  SAL2
    FROM        EMPLOYEES E  
    ORDER BY    SALARY * 1.1 DESC
    ;
    
    
    
-----------------------  6. 50번 부서의 직원명단,월급 부서번호---------------------
    SELECT   E.EMPLOYEE_ID                      번호,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.SALARY                           월급,
             E.DEPARTMENT_ID                    부서번호
    FROM     EMPLOYEES E
    WHERE    E.DEPARTMENT_ID = 50
    ORDER BY 이름 ASC 
    ;
    
-----------------------  7. 20,80,60,90번 부서의 직원명단 월급, 부서번호---------------------
    SELECT   E.EMPLOYEE_ID                      번호,
             E.FIRST_NAME ||' '||E.LAST_NAME    이름,
             E.SALARY                           월급,
             E.DEPARTMENT_ID                    부서번호
    FROM     EMPLOYEES E
    WHERE    E.DEPARTMENT_ID IN (20,60,80,90) 
    ORDER BY  부서번호 ASC, 이름 ASC
    ;
                 -- IN : 여러 개 중에 하나라도 맞으면 OK (이 안에 있냐 ?) <=> NOT IN(?,?)
    
    

-- 중요 데이터 2개 입력
    SELECT COUNT(*)
        FROM EMPLOYEES ;  
                    -- 전체 자료수 출력 (            ( * ) -> NULL 상관없이 무조건 다 셈, 모든 행 개수)
                    --                  (SELECT COUNT(???) -> NULL제외 값이 있는 것만 셈)
        
    SELECT SYSDATE
      FROM DUAL;        
      
    SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD HH24:MI:SS')        -- 오늘날짜 :연/월/일/시/분/초
      FROM DUAL;
     
----------------------- 신입사원 입사 (박보검, 장원영)---------------------

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
    
    
    
    
----------------------- 8. 보너스없는 직원명단 (COMMISSION_PCT 가 없다)---------------------
    SELECT E.EMPLOYEE_ID                    사번,
           E.FIRST_NAME||' '||LAST_NAME     이름,
           E.COMMISSION_PCT                  보너스
    FROM EMPLOYEES E
    WHERE E.COMMISSION_PCT IS NULL
    ORDER BY 사번 ASC
    ;
    
----------------------- 9. 전화번호가 010으로 시작하는---------------------
    SELECT E.EMPLOYEE_ID                    사번,
            E.FIRST_NAME||' '||LAST_NAME    이름,
            E.PHONE_NUMBER                  전화번호
    FROM    EMPLOYEES E
    WHERE   E.PHONE_NUMBER LIKE '010%'
    ORDER BY 사번 ASC
    ;
    
-----------------------10. LAST_NAME 세번째, 네번째 글자가 LL인것을 찾아라---------------------
    SELECT  E.EMPLOYEE_ID                   사번,
            E.FIRST_NAME||' '||LAST_NAME    이름
    FROM    EMPLOYEES E
    WHERE   UPPER(LAST_NAME) LIKE '__LL%'
    ORDER BY 사번 ASC
    ;



-----------------------11. 입사년월이 17년 2월인 사원출력---------------------
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

-----------------------12.''17/02/07' 에 입사한 사람출력------------------------------------------

    SELECT E.EMPLOYEE_ID                        사번,
            E.FIRST_NAME||' '||LAST_NAME        이름,
            TO_CHAR(E.HIRE_DATE, 'YYYY-MM-DD')  입사년월
    FROM    EMPLOYEES E
    WHERE   E.HIRE_DATE = '2017-02-07'     
    ORDER BY 이름 ASC
    ;
    
-------------------- '12/06/07'에 입사한 사람출력------------------------------------------
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
    
-----------------------13.오늘 '26/04/07'에 입사한 사람---------------------
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
               
/* 직원사번, 입사일*/
-- 2026년 04월 07일 10시 05분 04초 오전 수요일 -> 한자로 출력하기  日, 月, 火, 水, 木, 金, 土
ALTER SESSION SET NLS_DATE_FORMAT='YYYY時 MM分 DD秒 HH時 MI分 SS秒';
SELECT TO_CHAR('2026',-04-07 10:05:04','YYYY-MM-DD HH24:MI:SS')


FROM DUAL;




















SELECT 
    TO_CHAR(SYSDATE, 'YYYY"年" MM"月" DD"日" HH12"時" MI"分" SS"秒" ') || 
    -- 오전/오후 한자 변환
    DECODE(TO_CHAR(SYSDATE, 'AM', 'NLS_DATE_LANGUAGE=KOREAN'), '오전', '午前', '午後') || ' ' ||
    -- 요일 한자 변환
    DECODE(TO_CHAR(SYSDATE, 'D'), 
        1, '日', 2, '月', 3, '火', 4, '水', 5, '木', 6, '金', 7, '土') || '曜日' 
    AS 한자날짜
FROM DUAL;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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



----------------------11. 입사년월이 17년 2월인 사원출력-----------------
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

--------------------- '26/04/07'에 입사한 사람출력----------------------
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE    '2026-04-07 00:00:00' <= HIRE_DATE
    AND       HIRE_DATE  <= '2026-04-07 23:59:59'
    ;
    
    
    
 --------------------- '26/04/07'에 입사한 사람출력---------------------  
    ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
    
    SELECT   EMPLOYEE_ID, FIRST_NAME, LAST_NAME,HIRE_DATE
    FROM     EMPLOYEES
    WHERE TRUNC (HIRE_DATE) = '2026-04-07 00:00:00';



------------------------13.2 화요일 입사자를 출력-----------------------
SELECT   EMPLOYEE_ID,
         FIRST_NAME, 
         LAST_NAME, 
         TO_CHAR(HIRE_DATE, 'YYYY-MM-DD'),
         TO_CHAR(HIRE_DATE, 'DAY')
FROM     EMPLOYEES
WHERE    TO_CHAR(HIRE_DATE,'DY')='화'
ORDER BY HIRE_DATE ASC;


SELECT SYSDATE FROM DUAL;
-----어제입사 직원
SELECT EMPLOYEE_ID , HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = '15/09/21';           -- 명령 실행 전 !


ALTER SESSION SET NLS_DATE_FORMAT = "YYYY-MM-DD HH24:MI:SS";    -- 이 설정을 하면 이 출력을해야함 !!

SELECT EMPLOYEE_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE = '2014-02-17';         -- 명령 실행 후 !



--------------------------------------------------------------------------------------------
------------------------앞으로 날짜 표현은 다음과 같이 표현하자!!---------------------------
SELECT  EMPLOYEE_ID, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM    EMPLOYEES
WHERE   TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') = '2026-04-07'; 
--------------------------------------------------------------------------------------------


-- 입사후 일주일 이내인 직원명단
SELECT      EMPLOYEE_ID, TO_DATE(HIRE_DATE, 'YYYY-MM-DD')
FROM        EMPLOYEES
WHERE       HIRE_DATE >= SYSDATE - 7
;

--08월 입사자의 사번, 이름, 입사일을 입사일 순으로
SELECT  EMPLOYEE_ID                      "사 번",      
        FIRST_NAME||' '||LAST_NAME       이름,
        TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일
FROM    EMPLOYEES
WHERE   TO_CHAR(HIRE_DATE, 'MM') = '08'               
ORDER BY 입사일 ASC
;                           

-- 부서번호 80 이 아닌 직원
SELECT      EMPLOYEE_ID, DEPARTMENT_ID
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID <> 80     --   != 같지 않다   
ORDER BY    EMPLOYEE_ID ASC
;

-- =, <>, >, >=, <, <=, BETWEEN ~AND
-- +, -, *, /, MOD(7, 2) 


--  /* 직원사번, 입사일*/ 2026년 04월 07일 10시 05분 04초 오전 수요일 -> 한자로 출력하기  日, 月, 火, 水, 木, 金, 土
-- 午前	午後 日 月 火 水 木 金 土 年 月 日 時 分 秒 曜日
SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS DAY AM')
        TO_CHAR(SYSDATE, 'AM')
FROM DUAL;

-- 1) TO_CHAR 활용
SELECT  SYSDATE,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS DAY AM') 날짜1,               -- 아무FORMAT안했을때
--      TO_CHAR(SYSDATE, 'YYYY년 MM월 DD일  HH24시MI분SS초 DAY AM') 날짜2,    -- ORA-01821 : 날짜 형식이 부적합합니다.
        TO_CHAR(SYSDATE, 'YYYY"年" MM"月" DD"日"  HH24"時"MI"分"SS"秒" DAY AM') 날짜2,
        TO_CHAR(SYSDATE, 'AM')
FROM DUAL;

-- 2) IF를 구현    
-- 2-1) NVL(), NVL2()   
        --  사번, 이름, 월급, COMMISSION_PCT( NULL -> 0으로 출력 )
SELECT  EMPLOYEE_ID                 사번, 
        FIRST_NAME||' '||LAST_NAME  이름, 
        SALARY                      월급,
        NVL(COMMISSION_PCT,0)       보너스  ---> NVL(COMMISSION_PCT가 NULL이면 0을 찍는다)
FROM    EMPLOYEES
;

SELECT  EMPLOYEE_ID                 사번, 
        FIRST_NAME||' '||LAST_NAME  이름, 
        SALARY                      월급,
        NVL2(COMMISSION_PCT,            SALARY + (SALARY * COMMISSION_PCT), SALARY)       보너스  
    --> NVL2( NULL인지 아닌지 검사할 대상, VALUE_IF_NOT_NULL              ,VALUE_IF_NULL)

FROM    EMPLOYEES
;


-- 2-2) NULLIF()       둘을 비교해서 같으면 NULL, 다르면 EXPR1

-- 2-3) DECODE(expr, search1, result1,
--                   search2, result2,
--                   …, 
--                   default)
/*
DECODE는       expr과 search1을 비교해 두 값이 같으면 result1을, 
      ELSE 다시 search2와 비교해 값이 같으면 result2를 반환하고, 
          계속 비교한 뒤 같은 값이 없으면 default 값을 반환한다.
*/
-- 사번, 부서번호(단 부서번호가 NULL이면 '부서없음')
SELECT  EMPLOYEE_ID                                         사번,
        --NVL(DEPARTMENT_ID,'부서없음')       부서번호
        DECODE(DEPARTMENT_ID,NULL,'부서없음',DEPARTMENT_ID) 부서번호
FROM    EMPLOYEES 
;

-- 午前	午後 日 月 火 水 木 金 土 年 月 日 時 分 秒 曜日
SELECT  TO_CHAR(SYSDATE, 'AM'),
        DECODE(TO_CHAR(SYSDATE, 'AM'),'오전','午前','午後')
FROM DUAL;

SELECT  TO_CHAR(SYSDATE, 'DD')
        DECODE(TO_CHAR(SYSDATE, 'DD'), 1, '日'
                                     , 2, '月'
                                     , 3, '火'
                                     , 4, '水'
                                     , 5, '木'
                                     , 6, '金'
                                     , 7,'土'
                                     )
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY') || '年'
    || TO_CHAR(SYSDATE, 'MM')   || '月'
    || TO_CHAR(SYSDATE, 'DD')   || '日'
    || TO_CHAR(SYSDATE, 'HH12') || '時'
    || TO_CHAR(SYSDATE, 'MI')   || '分'
    || TO_CHAR(SYSDATE, 'SS')   || '秒'
    || CASE TO_CHAR(SYSDATE, 'DY')
        WHEN '일' THEN '日'
        WHEN '월' THEN '月'
        WHEN '화' THEN '火'
        WHEN '수' THEN '水'
        WHEN '목' THEN '木'
        WHEN '금' THEN '金'
        WHEN '토' THEN '土'   
        END                     || '曜日'
    || DECODE( TO_CHAR(SYSDATE, 'AM '),'오전','午前','午後')
FROM DUAL;

---------------------------------------------------------------

-- DECODE로
-- 사번 , 이름, 부서명(DEPARTMENTS 표 안에있는 DEPARTMENT_NAME
SELECT  DEPARTMENT_ID                       사번,
        FIRST_NAME||' '||LAST_NAME          이름,
        DECODE(DEPARTMENT_ID, 60, 'IT',
                              90, 'Executive',
                              80, 'Sales'
                                , '그 외'
        )                                   부서명
FROM    EMPLOYEES
;

-- GREATEST 문법 해보세용~~: https://thebook.io/006696/0118/

-- 사번, 이름, 부서명 : 모든 부서명, NULL : 부서없음
SELECT  EMPLOYEE_ID                                 사번,
        FIRST_NAME||' '||LAST_NAME                  이름,
        DECODE(DEPARTMENT_ID, 10,'Administration'
                            , 20,'Marketing'
                            , 30,'Purchasing'
                            , 40,'Human Resources'
                            , 50,'Shipping'
                            , 60,'IT'
                            , 70,'Public Relations'
                            , 80,'Sales'
                            , 90,'Executive'
                            , 100,'Finance'
                            , 110,'Accounting'
                                 ,'부서없음'
        )                                           부서명  
FROM    EMPLOYEES
;

--NULL이 계산에 포함되면 결과는 NULL
-- 직원명단, 직원의 월급, 보너스 출력 -> 연봉출력    ->F5로
SELECT  EMPLOYEE_ID                                         사번,
        FIRST_NAME||' '||LAST_NAME                          이름,
        SALARY                                      "직원의 월급",
        NVL(SALARY*COMMISSION_PCT,0)                     "보너스",
        SALARY * 13 + SALARY*COMMISSION_PCT                 "연봉",
        SALARY * 13 + NVL(SALARY*COMMISSION_PCT,0)     "연봉출력"
FROM EMPLOYEES
;


-- 3) CASE WHEN THEN END
--WHEN 점수 BETWEEN 90 AND 100      THEN 'A'
--WHEN 90 < = 점수 AND 점수 <= 100 THEN 'A'


-- 사번 , 이름, 부서명
SELECT  EMPLOYEE_ID                     사번,
        FIRST_NAME||' '||LAST_NAME      이름, 
        CASE DEPARTMENT_ID
            WHEN    60  THEN    'IT'
            WHEN    80  THEN    'Salse'
            WHEN    90  THEN    'Executive'
            ELSE                '그외'
        END                             부서명
FROM    EMPLOYEES
;

----------
SELECT  EMPLOYEE_ID                  사번,
        FIRST_NAME||' '||LAST_NAME   이름, 
        CASE 
            WHEN    DEPARTMENT_ID = 60  THEN    'IT'
            WHEN    DEPARTMENT_ID = 80  THEN    'Salse'
            WHEN    DEPARTMENT_ID = 90  THEN    'Executive'
            ELSE                                '그외'        --순서대로 출력됨
        END                          부서명
FROM    EMPLOYEES
;

-------------
/*
 집계함수 : AGGREGATE 함수
 모든 집계함수는 NULL 값을 포함하지 않는다
 SUM(), AVG(), MIN(), MAX(), COUNT(), STDDEV(),VARIANCE()
 합계   평균   최대   최소    줄수    표준편차   분산
 그루핑 : GROUP BY
 ~별 인원수
*/
SELECT *                    FROM EMPLOYEES;            --모두 출력
SELECT COUNT(*)             FROM EMPLOYEES;            --COUNT(*)      : 109 : ROW 줄 수 
SELECT COUNT(EMPLOYEE_ID)   FROM EMPLOYEES;            --COUNT(어쩌고) : 109 
SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES;            --COUNT(어쩌고) : 106  ->               !!!NULL이 빠져서!!

SELECT COUNT(EMPLOYEE_ID)   FROM EMPLOYEES
 WHERE DEPARTMENT_ID        IS NULL;                   -- 3 출력
SELECT EMPLOYEE_ID          FROM EMPLOYEES
 WHERE DEPARTMENT_ID        IS NULL;                   -- 3명의 EMPLOYEE_ID 출력


-- 전체 직원의 월급 합
SELECT COUNT(SALARY)        FROM EMPLOYEES;            --COUNT(SALARY) :     107
SELECT SUM(SALARY)          FROM EMPLOYEES;            --SUM(SALARY)   :  691416    결과값 한줄
SELECT AVG(SALARY)          FROM EMPLOYEES;            --AVG(SALARY)   :  6461.~
SELECT MAX(SALARY)          FROM EMPLOYEES;            --MAX(SALARY)   :   24000    결과값 한줄
SELECT MIN(SALARY)          FROM EMPLOYEES;            --MIN(SALARY)   :    2100    결과값 한줄

SELECT SUM(SALARY) / COUNT(SALARY) FROM EMPLOYEES;      --6461.831775700934579439252336448598130841
SELECT SUM(SALARY) / COUNT(*)      FROM EMPLOYEES;      --6343.266055045871559633027522935779816514  =>NULL 때문에/    퇴사자가있다면 같이계산됨

-- 60번 부서의 평균월급  => 5760
SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE   DEPARTMENT_ID = 60
;
-- EMPLOYEES 테이블의 부서수를 알고 싶다   =>106
SELECT  COUNT(DEPARTMENT_ID)
FROM    EMPLOYEES
;

SELECT  DEPARTMENT_ID   
FROM    EMPLOYEES       
;

-- 중복을 제거(DISTINCT)한 부서의 수를 출력
-- 중복을 제거 한 부서 번호 LIST      : NULL 출력(O)
SELECT  DISTINCT(DEPARTMENT_ID)        
FROM    EMPLOYEES       
;
-- 중복을 제거 한 부서 번호 LIST의 수 : NULL 출력(X)  
SELECT  COUNT(DISTINCT(DEPARTMENT_ID))
FROM    EMPLOYEES       
;

-- 직원이 근무하는 부서의 수 : 부서장이 있는 부서수 : DEPARTMENTS
SELECT  COUNT(DEPARTMENT_ID) 
FROM DEPARTMENTS
WHERE MANAGER_ID IS NOT NULL ;

-- 반올림 반내림 하는 법
SELECT  7/2,                -- 3.5
        ROUND(156.456, 2), ROUND(156.456, -2),  -- 156.46       /200 
        TRUNC(156.456, 2), ROUND(156.456, -2)   -- 156.45       /100  
FROM DUAL;


-- 직원수, 월급합, 월급평균, 최대월급, 최소월급
SELECT  COUNT(EMPLOYEE_ID)      "직원수",
        SUM(SALARY)             "월급합",
        ROUND(AVG(SALARY),3)    "월급평균", -- 소
        MAX(SALARY)             "최대월급",
        MIN(SALARY)             "최소월급"
FROM EMPLOYEES
;

-- 부서 60번 부서 인원수 , 월급합, 월급평균
SELECT  COUNT(EMPLOYEE_ID)  "부서인원수",
        SUM(SALARY)         "월급함",
        AVG(SALARY)         "월급평균"
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 60
;


-- 부서 50,60,80 부서가 아닌 인원수, 월급합, 월급평균    ---- 25	201716	8770.26
/*------------------!!결과값 오류!!-------------------
SELECT  COUNT(DEPARTMENT_ID)     "인원수",
        SUM(SALARY)              "월급함",
        ROUND(AVG(SALARY), 2)    "월급평균"
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID NOT IN(50,60,80)           -- = 22 / 194716 / 8850.73  
;

SELECT  COUNT(DEPARTMENT_ID)     "인원수",
        SUM(SALARY)              "월급함",
        ROUND(AVG(SALARY), 2)    "월급평균"
FROM    EMPLOYEES
WHERE NOT  (DEPARTMENT_ID = 50
AND         DEPARTMENT_ID = 60
AND         DEPARTMENT_ID = 80)                  -- = 106 / 684416 / 6456.75
;
*/
SELECT  COUNT(*)     "인원수",
        SUM(SALARY)              "월급함",
        ROUND(AVG(SALARY), 2)    "월급평균"
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID NOT IN(50,60,80)
OR      DEPARTMENT_ID IS NULL
;
SELECT  COUNT(*)        인원수,
        SUM(SALARY)      월급합,
        ROUND(AVG(SALARY),3)      월급평균
FROM    EMPLOYEES           
WHERE DEPARTMENT_ID IS NOT NULL
AND   DEPARTMENT_ID NOT IN(50, 60, 80)
; 
---------------------------------------------------------------------
부서별 사원수
SELECT      DEPARTMENT_ID       부서번호,       -- DEPARTMENT_ID는 한줄이아니긴함
            COUNT(EMPLOYEE_ID)  사원수
FROM        EMPLOYEES
GROUP BY    DEPARTMENT_ID   
ORDER BY    부서번호 ASC
;
    -- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다   "not a single-group group function"  = GROUP BY            

--일반칼럼과 직계함수는 같이 사용할 수 없다
--  => GROUP BY를 사용해야 가능

-- 부서별 월급 합, 월급 평균
SELECT      DEPARTMENT_ID        부서번호,
            SUM(SALARY)            월급합,
            ROUND(AVG(SALARY), 2) 월급평균
FROM        EMPLOYEES
GROUP BY    DEPARTMENT_ID
ORDER BY    월급평균 ASC
;