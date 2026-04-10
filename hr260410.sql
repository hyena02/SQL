-------------------------------------------------------
함수
숫자
1. abs()
2. CEIL(n)과 FLOOR(n)  -> 정수형
   CEIL(n)   : 무조건 올림  
   FLOOR(n)  :        버림
   
   --           11               11             12
    SELECT CEIL(10.123),  CEIL(10.541),  CEIL(11.001)     FROM DUAL;
    SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001)     FROM DUAL;
    --           10              10              11
    --          -11             -11             -12
    SELECT FLOOR(-10.123), FLOOR(-10.541), FLOOR(-11.001)     FROM DUAL;
    SELECT TRUNC(-10.123), TRUNC(-10.541), TRUNC(-11.001)     FROM DUAL;
    --          -10             -10             -11    
 3. ROUND(n,i)와 TRUNC(n1, n2)   
    --      10.2                10.15               10.154
    SELECT ROUND(10.154,1) , ROUND(10.154,2)  ,   ROUND(10.154,3)  FROM DUAL;    -- 숫자값을 특정 위치에서 반올림
    SELECT TRUNC(0, 3),     TRUNC(115.155, -1), TRUNC(115.155, -2) FROM DUAL;    -- 숫자값을 특정 위치에서 절삭(버림)
    --      0                    110                 100
    
    
4. POWER(2, 3)   : 제곱승  : 2의 3승
    SQRT(n)      : 제곱근  : SQUARE ROOT
   
    SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001), POWER(4, 0.5)    FROM DUAL;   --9  	27	  27.0029664...  	1.9999...
    SELECT SQRT(2), SQRT(4) FROM DUAL;  --1.41421...	 2
    
    
    SELECT SORT(-4) FROM DUAL;      -- ORA-00904 : "SORT" : 부적합한 식별자
    SELECT SORT(4)  FROM DUAL;
    
    
5. 나머지 MOD(n2, n1)와 REMAINDER(n2, n1)
    
    SELECT MOD(19,4), MOD(19.123, 4.2)                  FROM DUAL;  --  3 ,	    2.323
    SELECT REMAINDER(19,4), REMAINDER(19.123, 4.2)      FROM DUAL;  -- -1  ,	-1.877
    
6. EXP(n), LN(n) 그리고 LOG(n2, n1)
            
    SELECT EXP(2), LN(2.713), LOG(10, 100)      FROM DUAL;  -- 7.38905... , 0.99805...   ,  2
    
7.  SIN(), COS(), TAN() : DEGREE(도) ->RADIAN (원주율 / 180 * 각도)  ->0.01745
    SIN 30도 -> 0.5
    -- SELECT  SIN(30) : X 라디안 변환해야 됨
    SELECT  SIN(30 * 0.01745) FROM DUAL;
-------------------------------------------------------
-- 문자함수

1. INITCAP(char), LOWER(char), UPPER(char)
    SELECT INITCAP('never say goodbye'), INITCAP('never6say*good가bye')   FROM DUAL;
        --       Never Say Goodbye	            Never6say*Good가Bye
    SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goodbye')         FROM DUAL;
        --         never say goodbye	        NEVER SAY GOODBYE
        
        
2.CONCAT(char1, char2), SUBSTR(char, pos, len), SUBSTRB(char, pos, len)

    SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream'         FROM DUAL;
        --              I Have A Dream	        I Have A Dream
    SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4)            FROM DUAL;  -- 글자기준 , ('',시작위치, 길이)
        --               ABCD	                    G
    SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('가나다라마바사', 1, 4)    FROM DUAL; --  byte 기준 -> 한글 1글자 = 3byte임
        --               ABCD	                    가 
        
3. LTRIM(char, set), RTRIM(char, set)

    SELECT LTRIM('ABCDEFGABC', 'ABC'),             -- DEFGABC
           LTRIM('가나다라', '가'),                -- 나다라
           RTRIM('ABCDEFGABCABC', 'ABC'),          -- ABCDRFG
           RTRIM('가나다라라라라', '라')           -- 가나다       ===> 한번만 X, 연속된 거 전부 제거!!
      FROM DUAL;
      
    -- TRIM : 양쪽공백제거
    -- LEADING : (앞쪽)왼쪽만 제거
    -- TRAILING : 오른쪽 삭제
    SELECT  TRIM(' ABCDEF'),                            -- ABCDEF   : 앞 공백 제거
            LENGTH(TRIM(' ABCDEF')),                    --   6      : 길이
            TRIM(LEADING ' ' FROM ' ABCDEF'),           -- ABCDEF   : 왼쪽 공백 제거 
            LENGTH(TRIM(LEADING ' ' FROM ' ABCDEF'))    --   6      : 왼쪽 공백 제거 후 길이
    FROM  DUAL;
      
    SELECT LTRIM('가나다라', '나'), RTRIM('가나다라', '나')     FROM DUAL;  
-------------------------------------------------------    
4.LPAD(expr1, n, expr2), RPAD(expr1, n, expr2)  -- 실무에서 숫자 자리 맞추기 , 출력 정렬하기에 쓰임

    CREATE TABLE ex4_1 (
           phone_num VARCHAR2(30));             --> hr / 테이블(필터링됨)에 생성됨
    INSERT INTO ex4_1 VALUES ('111-1111');
    INSERT INTO ex4_1 VALUES ('111-2222');
    INSERT INTO ex4_1 VALUES ('111-3333');      --> 추가 후 SELECT
    
    SELECT *FROM ex4_1;
    
    SELECT LPAD(phone_num, 12, '(02)')          --> L/RPAD(문자열, 총길이, 채울문자) 
                FROM ex4_1;                              
    
5. REPLACE(char, search_str, replace_str), TRANSLATE(expr, FROM_str, to_str)
    SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너')      -- REPLACE(문자열, 찾을 문자열, 바꿀문자열)
          FROM DUAL;
          
          
    SELECT  LTRIM(' ABC DEF '),                 --ABC DEF
             RTRIM(' ABC DEF '),                -- ABC DEF
             REPLACE(' ABC DEF ', ' ', '')      --ABCDEF
        FROM DUAL;
        
     SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS rep,
           TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS trn
      FROM DUAL;
      
      
6. INSTR(str, substr, pos, occur), LENGTH(chr), LENGTHB(chr)

    SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1,           --4
           INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2,        --18
           INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3      --32
      FROM DUAL;
7. 
-------------------------------------------------------
날짜함수
1. SYSDATE, SYSTIMESTAMP
2. ADD_MONTHS (date, integer)
3. MONTHS_BETWEEN(date1, date2)
4. LAST_DAY(date)
5. ROUND(date, format), TRUNC(date, format)
6. NEXT_DAY (date, char)
-------------------------------------------------------
-- https://thebook.io/006696/0110/
-- 변환함수 
1. TO_CHAR (숫자 혹은 날짜, format) -> 문자

    SELECT TO_CHAR(123456789,  '999,999,999')        FROM DUAL;  --   123,456,789   -- 9 -> 없으면 공백 / 0 없으면 0으로채움
    SELECT TO_CHAR(1234567,   '99,999,999')          FROM DUAL;  --     1,234,567   -- . -> 소수점      / , -> 단위
    SELECT TO_CHAR(1234567,   '00,000,000')          FROM DUAL;  --    01,234,567   
    SELECT TO_CHAR(123.45678, '99,990.000')          FROM DUAL;  --       123.457   -- 소수 이하 자동 반올림 : 3자리로
    SELECT TO_CHAR(123456789, '$999,999,999')        FROM DUAL;  --  $123,456,789
    SELECT TO_CHAR(123456789, 'L999,999,999')        FROM DUAL;  -- ￦123,456,789
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')            FROM DUAL;  -- 2026-04-10
    
2. TO_NUMBER(expr, format)  -> 숫자

3. TO_DATE(char, format) -> 날짜 , TO_TIMESTAMP(char, format)

4. GREATEST(expr1, expr2, …), LEAST(expr1, expr2, …)

    SELECT GREATEST(1, 2, 3, 2),
              LEAST(1, 2, 3, 2)
    FROM DUAL
    ;
    
5. DECODE (expr, search1, result1, search2, result2, …, default)

    SELECT prod_id,
             DECODE(channel_id, 3, 'Direct',
                                9, 'Direct',
                                5, 'Indirect',
                                4, 'Indirect',
                                   'Others') 
    FROM sales
    WHERE rownum < 10
    ;

-------------------------------------------------------
JOIN / UNION 
JOIN : 컬럼 연결 = 가로
    - LEFT JOIN : 왼쪽 다 살림
UNION : 중복 제거 합치기 = 세로
-- 직원정보, 담당업무
SELECT  FIRST_NAME||' '||LAST_NAME    직원정보
        ,JOB_ID                       담당업무
FROM    EMPLOYEES
;

-- 직원명, 담당업무, 담당업무 히스토리
SELECT  EMPLOYEE_ID, JOB_ID
FROM    EMPLOYEES
UNION
SELECT EMPLOYEE_ID, JOB_ID
FROM    JOB_HISTORY
;

SELECT *
FROM    
    (
        SELECT  EMPLOYEE_ID, JOB_ID
        FROM    EMPLOYEES
    UNION
        SELECT EMPLOYEE_ID, JOB_ID
        FROM    JOB_HISTORY
    )       --   INLINE WIEW : ORDER BY 사용할 수 있다. - FROM 뒤에 사용
ORDER BY EMPLOYEE_ID ASC
;
      
-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
SELECT   *
FROM     
    (
        SELECT    EMPLOYEE_ID             사번
                , TO_CHAR(HIRE_DATE,'YYYY-MM-DD')업무시작일
                , '재직중'              업무종료일
                , JOB_ID                담당업무
                , DEPARTMENT_ID         부서번호
        FROM    EMPLOYEES
  UNION
        SELECT  EMPLOYEE_ID             사번
                , TO_CHAR(START_DATE, 'YYYY-MM-DD')업무시작일
                , TO_CHAR(END_DATE, 'YYYY-MM-DD')  업무종료일
                , JOB_ID                담당업무
                , DEPARTMENT_ID         부서번호
        FROM    JOB_HISTORY
    )
ORDER BY  사번 ASC, 업무시작일 ASC
;

-- 사번, 직원명, 업무시작일, 업무종료일, 담당업무명, 부서이름  --UNION? JOIN? ??
SELECT  *
FROM
    (
    )
ORDER BY 사번 ASC
;


---------------------------------------------------------------
1. VIEW : 뷰  --SQL 문을 저장해 놓고 TABLE 처럼 호출해서 사용하는 객체
 
    1) INLINE   VIEW :  SELECT 할때만 VIEW로 작동 : 임시 존재
     
 SELECT *
 FROM   
    (
    SELECT  EMPLOYEE_ID                  사번
            ,FIRST_NAME||' '||LAST_NAME  이름
            ,EMAIL  || '@GREEN.COM'      이메일
            ,PHONE_NUMBER                전화번호
    FROM    EMPLOYEES
    ORDER BY 이름        
    ) T
 WHERE T.사번 IN(100,101,102);
     
     
SELECT  *
FROM   
    (
    SELECT  DEPARTMENT_ID       부서번호
            ,COUNT(SALARY)      CNT_SAL
            ,SUM(SALARY)        SUM_SAL
            ,ROUND(AVG(SALARY),1)AVG_SAL
    FROM    EMPLOYEES
    GROUP BY    DEPARTMENT_ID
    ) T
WHERE       T.AVG_SAL >= 4000
ORDER BY    부서번호 ASC
;


    2)일반적인 VIEW : 영구저장된 객체
         VIEW 생성 - 영구보관
     
     
 CREATE OR REPLACE VIEW "HR"."VIEW_EMP"("사번","이름","이메일","전화번호")
 AS 
        SELECT  EMPLOYEE_ID              사번
            ,FIRST_NAME||' '||LAST_NAME  이름
            ,EMAIL  || '@GREEN.COM'      이메일
            ,PHONE_NUMBER                전화번호
        FROM    EMPLOYEES
        ORDER BY 이름   
 ;
SELECT  *
FROM    VIEW_EMP
WHERE   이름 LIKE '%King%'
;
  


---------------------------------------------
2. WITH -- 가상의 테이블 생성

    WITH A ("사번","이름","이메일","전화번호")
    AS
        (
        SELECT  EMPLOYEE_ID              사번
                ,FIRST_NAME||' '||LAST_NAME  이름
                ,EMAIL  || '@GREEN.COM'      이메일
                ,PHONE_NUMBER                전화번호
        FROM    EMPLOYEES
        ORDER BY 이름  
        )
    SELECT * FROM A
    ;

---------------------------------------------
SELF JOIN

-- 직원번호, 직속상사번호
SELECT EMPLOYEE_ID  직원번호, MANAGER_ID 직속상사번호
FROM EMPLOYEES;

-- 직원이름, 직속상사이름,
-- 상사정보 : E1, 부하정보: E2 - 테이블복사
SELECT  E2.FIRST_NAME||' '||E2.LAST_NAME 직원이름
        ,E1.FIRsT_NAME||' '||E1.LAST_NAME 직속상사이름
FROM    EMPLOYEES E1, EMPLOYEES E2
WHERE   E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY    E1.EMPLOYEE_ID
; -- 106명  


SELECT  E2.FIRST_NAME||' '||E2.LAST_NAME 직원이름
        ,E1.FIRsT_NAME||' '||E1.LAST_NAME 직속상사이름
FROM    EMPLOYEES E1
    RIGHT JOIN    EMPLOYEES E2
            ON    E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY    E1.EMPLOYEE_ID
;  -- 109명

SELECT   E2.EMPLOYEE_ID          직원사번
        ,E2.FIRST_NAME||' '||E2.LAST_NAME 직원이름
        ,E1.FIRsT_NAME||' '||E1.LAST_NAME 직속상사이름
FROM    EMPLOYEES E1
RIGHT JOIN    EMPLOYEES E2
        ON    E1.EMPLOYEE_ID = E2.MANAGER_ID
ORDER BY    E2.EMPLOYEE_ID ASC
;  -- 109명


---------------------------------------------
-- 계층형쿼리, CASCADING
    계층형쿼리 : HIRERACHY
LEVEL : 예약어 , 계층형쿼리의 레벨을 구하는


SELECT   E.EMPLOYEE_ID                 직원번호
        ,LPAD(' ', 3 * (LEVEL-1))|| '└ ' || E.FIRST_NAME || ' ' || LAST_NAME  직원명
        ,LEVEL
        ,D.DEPARTMENT_NAME             부서명
FROM    EMPLOYEES E
JOIN    DEPARTMENTS D
  ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
    START WITH  E.MANAGER_ID IS NULL
    CONNECT BY PRIOR E.EMPLOYEE_ID = E.MANAGER_ID
;



----------------------------------------------------
    EQUI JOIN   등가 조인 : 조인 조건이 = 인것들
NOT-EQUI JOIN 비등가 조인 : 조인 조건이 = 이 아닌 것


직원등급
 월급          등급
20000    초과    S
15001 ~ 20000    A
10001 ~ 15000    B
 5001 ~ 10000    C
 3001 ~  5000    D
    0 ~  3000    E

SELECT   EMPLOYEE_ID                 직원번호
        ,FIRST_NAME||' '||LAST_NAME  직원명
        ,SALARY                      월급
        ,CASE
            WHEN SALARY > 20000                    THEN 'S'
            WHEN SALARY BETWEEN 15001 AND 20000    THEN 'A'
            WHEN SALARY BETWEEN 10001 AND 15000    THEN 'B'
            WHEN SALARY BETWEEN  5001 AND 10000    THEN 'C'
            WHEN SALARY BETWEEN  3001 AND  5000    THEN 'D'
            WHEN SALARY BETWEEN     0 AND  3000    THEN 'E'
            ELSE                                        '등급없음'
        END
FROM    EMPLOYEES
;
-- 등급 테이블 생성
DROP   TABLE SALGRADE; -- TABLE 삭제명령


CREATE TABLE SALGRADE
    (
        GRADE   VARCHAR2(1) PRIMARY KEY
        ,LOSAL  NUMBER(11)
        ,HISAL  NUMBER(11)   
    );
    
INSERT INTO SALGRADE VALUES ('S', 20001 ,99999999999);
INSERT INTO SALGRADE VALUES ('A', 15001,20000);
INSERT INTO SALGRADE VALUES ('B', 10001, 15000);
INSERT INTO SALGRADE VALUES ('C',  5001, 10000);
INSERT INTO SALGRADE VALUES ('D',  3001, 5000);
INSERT INTO SALGRADE VALUES ('E',     0, 3000);
COMMIT;

DELETE FROM SALGRADE;






SELECT  EMPLOYEE_ID                직원번호
       ,FIRST_NAME||' '||LAST_NAME 직원명
       ,SALARY                     월급
       ,NVL(SG.GRADE, '등급없음')  등급
FROM   EMPLOYEES  E
LEFT JOIN   SALGRADE SG
       ON   E.SALARY BETWEEN SG.LOSAL AND SG.HISAL
ORDER BY E.EMPLOYEE_ID ASC
;
------------------------------------------------------------------------------------
-- 분석함수와 WINDOW 함수
------------------------------------------------------------------------------------

1. ROW_NUMBER() : 줄번호 출력 (1,2,3,4,5...)


    SELECT  EMPLOYEE_ID, FIRST_NAME, LAST_NAME,SALARY
    FROM    EMPLOYEES
    ORDER BY    SALARY DESC NULLS LAST
    ;
    
    DESC NULLS LAST  - NULL 맨 밑으로
    DESC NULLS FIRST - NULL 맨 위로
    
1.1 자료를 10개만 출력
1) OLD 문법 : ROWNUM - 의사칼럼(Pseudo Column : 테이블에 없는 컬럼인데 있는것처럼 쓰는 가짜 컬럼)

    SELECT   ROWNUM, EMPLOYEE_ID, FIRST_NAME, LAST_NAME,SALARY
    FROM     EMPLOYEES
    WHERE    ROWNUM BETWEEN 1 AND 10
    ORDER BY SALARY DESC NULLS LAST      --> ORDER BY보다 먼저 실행됨
    ;
    
    SELECT ROWNUM, T.*
    FROM   
        (
            SELECT   ROWNUM, EMPLOYEE_ID, FIRST_NAME, LAST_NAME,SALARY
            FROM     EMPLOYEES
            ORDER BY SALARY DESC NULLS LAST
        ) T
    WHERE ROWNUM <= 10
    ;
2) NEW 문법 : ROW_NUMBER() 
    SELECT *
    FROM
        (
        SELECT   ROW_NUMBER()  OVER (ORDER BY SALARY DESC NULLS LAST)  RN
                ,EMPLOYEE_ID
                ,FIRST_NAME
                ,LAST_NAME,SALARY
        FROM     EMPLOYEES
        ) T
    WHERE T.RN BETWEEN 1 AND 10;
    ;

3) ORACLE 12C 부터는 OFFSET    -- 11 부터 10개 : ORW_NUMBER 보다 속도가 빠르다. (OFFSET 11 은 0부터 시작 기준이다)
    SELECT   *
    FROM     EMPLOYEES
    ORDER BY SALARY DESC NULLS LAST
        OFFSET   10 ROWS FETCH NEXT 10 ROWS ONLY -- 몇개버리고 몇개 가져올지
    ;
------------------------------------------------------------------------------------
2. RANK()       : 석차        (1,2,2,4,5,6,7,...)

 )) 월급순으로 석차를 출력
    SELECT * FROM 
        (
        SELECT   EMPLOYEE_ID    사번
                ,FIRST_NAME||' '||LAST_NAME     이름
                ,SALARY     월급
                ,RANK() OVER(ORDER BY SALARY DESC NULLS LAST)       석차
        FROM    EMPLOYEES
        ) T
    WHERE  석차 BETWEEN 1 AND 10
    ;
    
------------------------------------------------------------------------------------    
3. DENSE_RANK() : 석차        (1,2,2,3,4,5,5,6,...)
 )) 월급순으로 석차를 출력(1등~10등)
    SELECT * FROM 
        (
        SELECT   EMPLOYEE_ID    사번
                ,FIRST_NAME||' '||LAST_NAME     이름
                ,SALARY     월급
                ,DENSE_RANK() OVER(ORDER BY SALARY DESC NULLS LAST)       석차        -- DENSE_RANK : 동점자 전부 포함 -> 10까지 전부 가져오는조건
        FROM    EMPLOYEES
        ) T
    WHERE  석차 BETWEEN 1 AND 10
    ;
------------------------------------------------------------------------------------
4. NTILE()      : 데이터를 'N개 그룹'으로 나눠주는 함수
        NTILE(그룹개수) OVER (ORDER BY 기준)
        
    SELECT  EMPLOYEE_ID
       ,SALARY
       ,NTILE(3) OVER (ORDER BY SALARY DESC NULLS LAST) 
    FROM EMPLOYEES
    ;

4-1. RANK랑 같이 쓰는거
    SELECT  EMPLOYEE_ID                                 사번
           ,FIRST_NAME||' '||LAST_NAME                  이름
           ,SALARY                                      월급
           ,RANK() OVER (ORDER BY SALARY DESC)          순위
           ,NTILE(4) OVER (ORDER BY SALARY DESC)        등급
    FROM EMPLOYEES;
------------------------------------------------------------------------------------
5. LISTAGG() 여러줄을 한줄짜리 문자열로 변경


    SELECT DEPARTMENT_ID FROM EMPLOYEES;
    
    SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;
    
    SELECT LISTAGG(DISTINCT DEPARTMENT_ID, ',')  -- WITHIN 없 ->무작위로         
        FROM EMPLOYEES;                         
    
    SELECT LISTAGG(DISTINCT DEPARTMENT_ID, ',')  -- WITHIN 있 -> 정렬   
        WITHIN GROUP(ORDER BY DEPARTMENT_ID DESC)
        FROM EMPLOYEES
    ;
--------------------------------------------------    


 