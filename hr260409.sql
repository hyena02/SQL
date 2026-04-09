SELECT * FROM tab;
----------------------------------------------
SUBQUERY : SQL 문 안에 SQL 문을 넣어서 실행한 방법
         : 반드시 ()안에 있어야한다.
         : () 안에는 ORDER BY를 사용불가
         : WHERE 조건에 맞도록 작성한다.
         : QUERY 실행하는 순서가 중요하다.
            
----------------------------------------------

-- it 부서의 직원정보를 출력하시오--
1)
SELECT  DEPARTMENT_ID       
FROM    DEPARTMENTS
WHERE   DEPARTMENT_NAME = 'IT'
;

2) 60번 부서의 직원정보를 출력
SELECT  EMPLOYEE_ID 사번,
        FIRST_NAME ||' '||LAST_NAME 이름
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 60
;

3)   1)+2)
SELECT  EMPLOYEE_ID 사번,
        FIRST_NAME ||' '||LAST_NAME 이름
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID   = (
            SELECT  DEPARTMENT_ID     부서
            FROM    DEPARTMENTS
            WHERE   DEPARTMENT_NAME = 'IT');
            
4)  1+)2)
SELECT  EMPLOYEE_ID                사번,
        FIRST_NAME||' '||LAST_NAME  이름,
        DEPARTMENT_ID            부서번호
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID IN (
            SELECT  DEPARTMENT_ID
            FROM    DEPARTMENTS
            WHERE   DEPARTMENT_NAME IN('IT', 'Sales')
        );
        


-- 평균월급보다 많은 월급을 받는 사람의 명단 
1)평균월급      --6461.831775700934579439252336448598130841
SELECT  AVG(SALARY)            
FROM    EMPLOYEES
;

2)월급> 평균월급
SELECT  SALARY
        ,EMPLOYEE_ID
        ,FIRST_NAME||' '||LAST_NAME
FROM    EMPLOYEES
WHERE   SALARY >= 6461.831775700934579439252336448598130841
;

3)  1)+2)
SELECT  SALARY, EMPLOYEE_ID , FIRST_NAME||' '||LAST_NAME
FROM    EMPLOYEES
WHERE   SALARY >= (
            SELECT AVG(SALARY) FROM EMPLOYEES
        )
;


-- IT 부서의 평균월급보다 많은 월급을 받는 사람의 명단
1)  IT부서의 부서번호 -60
SELECT DEPARTMENT_ID
FROM    DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT'
;

2)  60번 부서의 평균월급
SELECT  AVG(SALARY)
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID  = 60
;

3)  2)번 보다 월급이 많은 사원의 정보를 출력
SELECT  FIRST_NAME||' '||LAST_NAME
        ,EMPLOYEE_ID
        ,SALARY
FROM    EMPLOYEES
WHERE   SALARY >= 5760
;
   
        

4)  1) + 2)     -- AVG(SALARY) = 5760
SELECT  AVG(SALARY)
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID  =(
            SELECT DEPARTMENT_ID
            FROM    DEPARTMENTS
            WHERE DEPARTMENT_NAME = 'IT'
)
;

5)  1)+2)+3)
SELECT  SALARY
        ,EMPLOYEE_ID
        ,FIRST_NAME||' '||LAST_NAME
FROM    EMPLOYEES
WHERE   SALARY >= (
            SELECT  AVG(SALARY)
            FROM    EMPLOYEES
            WHERE   DEPARTMENT_ID  =(
                        SELECT DEPARTMENT_ID
                        FROM    DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT'
   )
  )
;

-- 50번 부서의 최고 월급자의 이름을 출력
1) 50번부서 사원
SELECT  EMPLOYEE_ID
        ,FIRST_NAME||' '||LAST_NAME
        ,DEPARTMENT_ID
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 50
;

2)
SELECT MAX(SALARY)
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 50
;

3)  1)+2) 
SELECT  FIRST_NAME||' '||LAST_NAME
        ,SALARY
        ,EMPLOYEE_ID
        ,DEPARTMENT_ID
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = 50
AND     SALARY = (
            SELECT  MAX(SALARY)
            FROM    EMPLOYEES
            WHERE   DEPARTMENT_ID=50
    )
;


-- SALES 부서의 평균월급보다 많은 월급을 받는 사람의 명단
1) SALES 부서의 부서번호
SELECT  DEPARTMENT_ID
        ,DEPARTMENT_NAME
FROM    DEPARTMENTS
WHERE   DEPARTMENT_NAME = UPPER('Sales')
;

2)  1)부서의 평균월급  -8955.882352941176470588235294117647058824
SELECT AVG(SALARY)
FROM    EMPLOYEES
WHERE DEPARTMENT_ID = 80
;

3)  2)보다 많은 월급자의 명단
SELECT EMPLOYEE_ID, SALARY
FROM    EMPLOYEES
WHERE SALARY >= 8955.882352941176470588235294117647058824
;

4) 1)+2)+3)
SELECT  EMPLOYEE_ID, SALARY
FROM    EMPLOYEES
WHERE   SALARY >=(
            SELECT  AVG(SALARY)
            FROM    EMPLOYEES
            WHERE   DEPARTMENT_ID = (
                SELECT DEPARTMENT_ID
                FROM   DEPARTMENTS
                WHERE  UPPER(DEPARTMENT_NAME) = 'SALES'
  )
 )
;
--------------------------------------------------------------------------------
-- employees 테이블에서 job_id별로 가장 낮은 salary가 얼마인지 찾아보고, 
-- 찾아낸 job_id별 salary에 해당하는 직원이 누구인지 다중 열 서브쿼리를 이용해 찾아보세요.
SELECT  *
FROM    EMPLOYEES 
WHERE   (JOB_ID, SALARY) IN (
               SELECT   JOB_ID
                        ,MIN(SALARY) 그룹별급여
               FROM     EMPLOYEES
               GROUP BY JOB_ID
)
ORDER BY A.SALARY DESC
;


-- 상관 서브 쿼리 CORELATIVE SBQUARY      
-- JOB_HISTORY에 있는 부서번호와 DEPARTMENTS에 있는 부서번호가 같은 부서를 찾아서 DEPARTMENTS에 있는 부서번호와 부서명을 출력
-- 사원명과 부서명을 가져오려고 서브쿼리 SELECT절에서 사용

SELECT  DEPARTMENT_ID, DEPARTMENT_NAME                      -- JOB_HISTORY에 한번이라도 등장한 부서만 출력 
FROM    DEPARTMENTS A                                       -- DEPARTMENTS에서 한 행씩 꺼냄(A)- > 그 부서번호를 가지고 JOB_HISTORY에서 같은 부서 있는지 확인 
WHERE   EXISTS(SELECT 1                                     -- EXISTS (서브쿼리) = 결과가 한건이라도 있으면 TRUE
                FROM JOB_HISTORY B
                WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
 )
;
-- SHIPPING 부서의 직원명단
SELECT  EMPLOYEE_ID, FIRST_NAME,LAST_NAME
FROM    EMPLOYEES
WHERE   DEPARTMENT_ID = (           
        SELECT DEPARTMENT_ID    FROM    DEPARTMENTS
        WHERE  UPPER(DEPARTMENT_NAME) = 'SHIPPING'
)
;

----------------------------------------------------------

직원이름, 부서명 -- 출력 줄 수 109줄
-> 합칠 때 그 항목이 TABLE에 있어야 함

1) 카티션 프로덕트 : CROSS JOIN  : 조건이 없는
    109*27(부서명) = 2943줄 출력됨 -> 2TABLE의 조건을 주지않아서

SELECT  FIRST_NAME||','||LAST_NAME
        ,DEPARTMENT_NAME
FROM     EMPLOYEES 
        ,DEPARTMENTS
;

2)내부조인 : 양쪽 다 존재하는 데이터만 출력( NULL 제외 )
    109 - 3(부서번호 NULL) = 106줄 출력
    
SELECT  FIRST_NAME||','||LAST_NAME
        ,DEPARTMENT_NAME
FROM    EMPLOYEES ,DEPARTMENTS
WHERE   EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
;

2-2) TABLE 별칭 부여
SELECT  FIRST_NAME||','||LAST_NAME
        ,DEPARTMENT_NAME
FROM     EMPLOYEES   E    -- TABLE에 별칭 부여하면 별칭으로만 써야함
        ,DEPARTMENTS D
WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

3-1)모든 직원을 출력하라 / 직원의 부서번호가 NULL이라도 출력해야한다 : 109줄
    LEFT OUTER JOIN
    (+) :  기준(직원)이 되는 조건의 반대방향에 붙인다
            NULL이 출력 될 곳
            데이터 없어도 NULL로 채워지는 쪽 (부족한 쪽)
SELECT  FIRST_NAME||','||LAST_NAME
        ,DEPARTMENT_NAME
FROM     EMPLOYEES   e                 
        ,DEPARTMENTS d
WHERE   e.DEPARTMENT_ID = d.DEPARTMENT_ID (+)  
;

3-2) RIGHT OUTER JOIN
SELECT  FIRST_NAME||','||LAST_NAME
        ,DEPARTMENT_NAME
FROM     EMPLOYEES   e                
        ,DEPARTMENTS d
WHERE   d.DEPARTMENT_ID(+) = e.DEPARTMENT_ID
;


4) RIGHT OUTER JOIN
    모든 부서를 출력하라  -- 122: (109 -3(NULL) ) + (27 - 11) 
    / 직원정보가 없더(NULL)라도 출력해야한다

--> 122줄 출력 
SELECT  FIRST_NAME||','||LAST_NAME
        ,DEPARTMENT_NAME
FROM     EMPLOYEES   e                 
        ,DEPARTMENTS d
WHERE   e.DEPARTMENT_ID(+)  = d.DEPARTMENT_ID  
;

5) FULL OUTER JOIN - OLD 문법에 존재하지 않는 명령
   모든 직원과 모든 부서를 출력하라

------------------------------------------------------------------
표준 SQL 문법
1. CROSS JOIN   -> 2943
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
 FROM   EMPLOYEES E CROSS JOIN DEPARTMENTS D
 ;
 
2. INNER JOIN  -> 106( NULL 미포함 )
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM    EMPLOYEES E INNER JOIN DEPARTMENTS D 
 ON     E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

3. OUTER JOIN
    1) LEFT  OUTER JOIN -> 109
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM    EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

    2) RIGHT OUTER JOIN -> 106 + 16개의 DEPARTMENT_ID(직원NULL)
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM    EMPLOYEES E RIGHT JOIN DEPARTMENTS D
ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

    3) FULL  OUTER JOIN   = LEFT(직원기준) + RIGHT(부서기준) - INNER(겹치는것)
                            -> 125 : 109명(NULL 포함) + 16개(직원없는 부서)
SELECT  E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM    EMPLOYEES E FULL JOIN DEPARTMENTS D
ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

-- 직원이름, 담당업무(JOB_TITLE)
    -- 정상적으로 매칭된 직원만(양쪽다있는 데이터만 출력)-교집합
SELECT  E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, J.JOB_TITLE
FROM    EMPLOYEES E INNER JOIN JOBS J
ON      E.JOB_ID = J.JOB_ID
;
    -- 직원 전체 조회용(직원기준으로 JOB_TITLE없으면 NULL)-직원
SELECT  E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, J.JOB_TITLE
FROM    EMPLOYEES E LEFT JOIN JOBS J
ON      E.JOB_ID = J.JOB_ID
;
    -- 둘다 전부-전체
SELECT  E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, J.JOB_TITLE
FROM    EMPLOYEES E FULL JOIN JOBS J
ON      E.JOB_ID = J.JOB_ID
;

-- 부서명, 부서위치 (CITY, STREET_ADDRESS)  부서명 총27 (LOCATION_ID NULL없어서 걍 JOIN)
SELECT  D.DEPARTMENT_NAME,L.CITY, L.STREET_ADDRESS
FROM    DEPARTMENTS D  JOIN LOCATIONS L
ON      D.LOCATION_ID = L.LOCATION_ID
ORDER BY D.DEPARTMENT_NAME
;


-- 직원명, 부서명, 부서위치(CITY,STREET_ADDRESS)
    -- EMPLOYEES 기준, 부서없으면 NULL, 위치 없으면 NULL
SELECT      E.FIRST_NAME||''||E.LAST_NAME, D.DEPARTMENT_NAME,L.CITY||','|| L.STREET_ADDRESS
FROM        EMPLOYEES E 
LEFT JOIN   DEPARTMENTS D 
    ON          E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN   LOCATIONS L
    ON          D.LOCATION_ID   = L.LOCATION_ID
;
    

-- 직원명, 부서명, 국가, 부서위치(CITY,STREET_ADDRESS)

SELECT    E.FIRST_NAME||','||E.LAST_NAME, D.DEPARTMENT_NAME,L.CITY, L.STREET_ADDRESS, C.COUNTRY_NAME
FROM      EMPLOYEES E
LEFT JOIN DEPARTMENTS D
    ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
    ON      D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES C
    ON      L.COUNTRY_ID = C.COUNTRY_ID
;
SELECT    E.FIRST_NAME||','||E.LAST_NAME, D.DEPARTMENT_NAME,L.CITY, L.STREET_ADDRESS, C.COUNTRY_NAME
FROM      EMPLOYEES E
LEFT JOIN DEPARTMENTS D
    ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
    ON      D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES C
    ON      L.COUNTRY_ID = C.COUNTRY_ID
;

-- 부서명, 국가 : 모든 부서 : 27줄 이상
SELECT    D.DEPARTMENT_NAME, C.COUNTRY_NAME
FROM      DEPARTMENTS D 
LEFT JOIN    LOCATIONS L
    ON      D.LOCATION_ID = L.LOCATION_ID
FULL JOIN COUNTRIES C
    ON      L.COUNTRY_ID = C.COUNTRY_ID
;
        

-- 직원명, 부서위치 단 IT부서만
SELECT      E.FIRST_NAME||','||E.LAST_NAME, L.CITY, L.STREET_ADDRESS, D.DEPARTMENT_NAME, JOB_ID
FROM        EMPLOYEES E
JOIN   DEPARTMENTS D
    ON          E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN   LOCATIONS L
    ON          D.LOCATION_ID = L.LOCATION_ID
WHERE       UPPER(JOB_ID) = 'IT_PROG'
;

SELECT FIRST_NAME||','||LAST_NAME, DEPARTMENT_ID
FROM    EMPLOYEES
WHERE DEPARTMENT_ID = 60
;

SELECT *
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';



-- 부서명별 월급평균
SELECT  E.DEPARTMENT_ID
        , ROUND(AVG(SALARY),2)
        ,D.DEPARTMENT_NAME
FROM    EMPLOYEES E
LEFT JOIN    DEPARTMENTS D
    ON      E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME
ORDER BY DEPARTMENT_ID ASC
;

1) 부서번호
SELECT  DEPARTMENT_ID
        ,ROUND(AVG(SALARY),2)
FROM    EMPLOYEES E
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID
;

2) 부서명, 월급평균
SELECT  DEPARTMENT_NAME
        ,ROUND(AVG(SALARY),2)
FROM    EMPLOYEES E
JOIN    DEPARTMENTS D 
    ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
ORDER BY D.DEPARTMENT_NAME
;

3)모든 부서명, 월급평균  
    월급 평균이 NULL '직원없음'
SELECT      DEPARTMENT_NAME     부서명,    
--          ,NVL(ROUND(AVG(SALARY),2),0)                    -- 월급평균  0 으로 정상출력
--          ,NVL(ROUND(AVG(SALARY),2),'직원없음')           -- ORA-01722 : 수치가 부적합합니다.
            DECODE(ROUND(AVG(SALARY),2), 0, '직원없음',ROUND(AVG(SALARY),2)) 월급평균
FROM        EMPLOYEES E
RIGHT JOIN  DEPARTMENTS D 
    ON  E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY    D.DEPARTMENT_NAME
ORDER BY    D.DEPARTMENT_NAME
;

-- 직원의 근무연수
-- MONTH_BETWEEN(날짜1,날짜2) : 날짜1 - 날짜2 : 월단위로
-- ADD_MONTH(날짜, N) : 날짜+N개월 / 날짜-N개월
SELECT  FIRST_NAME||','||LAST_NAME                        직원명
        ,TO_CHAR(HIRE_DATE,'YYYY-MM-DD')                  입사일
        ,TRUNC(HIRE_DATE,'MONTH')                         입사월의첫번째날
        ,TO_CHAR(LAST_DAY(HIRE_DATE))                     입사월의마지막날
        ,TRUNC( SYSDATE - HIRE_DATE)                      근무일수
        ,TRUNC((SYSDATE - HIRE_DATE) / 365.2422 )         근무연수
        ,TRUNC( MONTHS_BETWEEN(SYSDATE , HIRE_DATE) / 12) 근무연수
FROM    EMPLOYEES
;




-- 60번 부서 최소월급과 같은 월급자의 명단출력
2) 1) 월급을 받는 사람의 이름


SELECT  FIRST_NAME||','||LAST_NAME  이름
        ,DEPARTMENT_ID              부서번호
        ,SALARY                     월급
FROM    EMPLOYEES
WHERE   SALARY = (
            SELECT MIN(SALARY)
            FROM   EMPLOYEES
            WHERE  DEPARTMENT_ID = 60
        )
;


-- 부서명, 부서장의 이름
SELECT  E.FIRST_NAME||','||E.LAST_NAME  이름
        ,D.DEPARTMENT_ID  부서번호
        ,D.DEPARTMENT_NAME
        ,J.JOB_ID
        ,J.JOB_TITLE
FROM    DEPARTMENTS  D
JOIN    EMPLOYEES  E   
    ON  D.MANAGER_ID = E.EMPLOYEE_ID
JOIN    JOBS    J
    ON      E.JOB_ID = J.JOB_ID
;


1) INNER JOIN : 양쪽 다 존재하는 데이터만 출력 -11
SELECT  D.DEPARTMENT_ID                  부서명
        ,E.FIRST_NAME||','|| E.LAST_NAME  부서장의 이름
FROM    DEPARTMENTS D
JOIN    EMPLOYEES E 
    ON      D.DEPARTMENT_ID = E.DEPARTMENT_ID
    ;
2) 모든 부서에 대해 출력 --27
SELECT  D.DEPARTMENT_NAME       부서명,
        E.FIRST_NAME||' '||E.LAST_NAME  부서장의 이름
FROM    DEPARTMENTS D 
LEFT JOIN EMPLOYEES E
    ON     D.MANAGER_ID = E.EMPLOYEE_ID
;



----------------------------------------------------------------------
----------------------------------------------------------------------
결합연산자 - 줄 단위 결합
    조건 - 두 테이블의 칸 수와 타입이 동일해야한다
    1) UNION        중복 제거
    2) UNION ALL    중복 포함
    3) INTERSECT    교집합 : 공통부분
    4) MINUS        차집합 : A-B
    
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;   --34
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;   --45
    
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 80
UNION
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

-- 칼럼 수와 칼럼들의 TYPE이 같으면 합쳐진다 -> 주의할 것  : 의미없는 결합 그냥쌉가능 샤갈~~~~~~
SELECT EMPLOYEE_ID, FIRST_NAME FROM EMPLOYEES
UNION
SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;
----------------------------------------------------------------------
---------------------------------------------------------------------



-- 직원정보, 담당업무 (
SELECT  E.EMPLOYEE_ID             사번
        ,E.FIRST_NAME||','||E.LAST_NAME  이름
        ,E.EMAIL              이메일
        ,E.PHONE_NUMBER 전화번호
        ,J.JOB_TITLE
FROM    EMPLOYEES E
JOIN    JOBS    J
    ON      E.JOB_ID = J.JOB_ID
;

-- 직원명, 담당업무, 담당업무 히스토리

-- 사번, 업무시작일, 업무종료일, 담당업무, 부서번호
SELECT  E.EMPLOYEE_ID    
        ,H.START_DATE
        ,H.END_DATE
        ,J.JOB_TITLE
        ,H.DEPARTMENT_ID
FROM    EMPLOYEES   E
JOIN    JOB_HISTORY H
    ON      E.EMPLOYEE_ID = H.EMPLOYEE_ID
JOIN    JOBS J
    ON      H.JOB_ID = J.JOB_ID
ORDER BY EMPLOYEE_ID
;






















