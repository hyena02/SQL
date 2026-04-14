-------------------------------------------------------------

DDL : data definition language
     구조를 생성(CREATE), 변경(ALTER), 제거(DROP)
     
 
계정생성
 아이디 : SKY
 비밀번호 : 1234
    CMD -----------------------------------------------
    
    Microsoft Windows [Version 10.0.19045.6218]
    (c) Microsoft Corporation. All rights reserved.
    
    C:\Users\GGG>SQLPLUS /NOLOG
    
    SQL*Plus: Release 21.0.0.0.0 - Production on 월 4월 13 14:06:14 2026
    Version 21.3.0.0.0
    
    Copyright (c) 1982, 2021, Oracle.  All rights reserved.
    
    SQL> conn /as sysdba
    연결되었습니다.
    SQL> show user
    USER은 "SYS"입니다
    SQL> ALTER SESSION SET "_ORACLE_SCRIPT"=true;
    
    세션이 변경되었습니다.
    
    SQL> CREATE USER SKY IDENTIFIED BY 1234;
    
    사용자가 생성되었습니다.
    
    SQL> GRANT CONNECT, RESOURCE TO SKY;
    
    권한이 부여되었습니다.
    
    SQL> ALTER USER SKY DEFAULT TABLESPACE
      2  USERS QUOTA UNLIMITED ON USERS;
    
    사용자가 변경되었습니다.
    
    SQL> CONN SKY/1234
    연결되었습니다.
    
    SQL> SHOW USER
    USER은 "SKY"입니다
----------------------------------------------------------------
----------------------------------------------------------------
새 계정 SKY으로 접속한 뒤에 작업     
     

SKY에서 hr계정의 data를 가져온다
SQLPLUS 에서 작업

1. 먼저 hr로 로그인한다
2. hr에서 다른 계정인 SKY에게 SELECT 할 수 있는 권한을 부여한다
3. SKY로 로그인한다
4. SKY에서 hr계정의 EMPLOYEES를 조회한다

    win+r : cmd
       >SQLPLUS hr/1234
    SQL> GRANT SELECT ON EMPLOYEES TO SKY;
    
    C:\Users\GGG>SQLPLUS hr/1234
    
    SQL*Plus: Release 21.0.0.0.0 - Production on 월 4월 13 14:21:23 2026
    Version 21.3.0.0.0
    
    Copyright (c) 1982, 2021, Oracle.  All rights reserved.
    
    마지막 성공한 로그인 시간: 월 4월  13 2026 09:42:02 +09:00
    
    다음에 접속됨:
    Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
    Version 21.3.0.0.0
    
    SQL> GRANT SELECT ON EMPLOYEES TO SKY;
    권한이 부여되었습니다.
    
    SQL> SHOW USER
    USER은 "HR"입니다
    
    SQL> CONN SKY/1234
    연결되었습니다.
    
    SQL> SHOW USER
    USER은 "SKY"입니다
    
    SQL> SELECT * FROM HR.EMPLOYEES;
    109 행이 선택되었습니다.                 <-- 조회 성공(HR.EMPLOYEES)
    
    SQL> SELECT * FROM HR.DEPARTMENTS;       <-- 조회 실패(HR.DEPARTMENTS)
    SELECT * FROM HR.DEPARTMENTS
                     *
    1행에 오류:
    ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
----------------------------------------------------------------------------
----------------------------------------------------------------------------
ORACLE 의 TABLE을 복사하기
HR의 EMPLOYEES TABLE을 복사해서 SKY로 가져온다

[1] 테이블 생성
  1. 테이블 복사
       대상 : 테이블 구조, 데이터(제약 조건의 일부만 복사한다(NOT NULL))
       
    1) 구조, 데이터 다 복사, 제약 조건은 일부만 복사
    CREATE TABLE EMP1
      AS
        SELECT * FROM HR.EMPLOYEES;
        
    2) 구조, 데이터 다 복사, 50번 80번 부서만 복사 -- 59 건
    CREATE TABLE EMP2
      AS
        SELECT * FROM HR.EMPLOYEES
        WHERE    DEPARTMENT_ID IN(50,80);
    3) 구조만 복사
    
    CREATE TABLE EMP3
      AS
        SELECT * FROM HR.EMPLOYEES
        WHERE    1 = 0;
    
    4) 구조만 복사된 TABLE에 데이터 추가
    
    CREATE TABLE EMP4
      AS
        SELECT * FROM HR.EMPLOYEES
        WHERE    1 = 0;
        
    -- DATA 만 추가
     INSERT INTO EMP4
       SELECT * FROM HR.EMPLOYEES;
       
       COMMIT;
       
    5) 일부칼럼만 복사해서 새로운 테이블 생성
    CREATE TABLE EMP5
      AS
        SELECT  EMPLOYEE_ID                EMPID,          
                FIRST_NAME||' '||LAST_NAME ENAME,
                SALARY                     SAL,
                SALARY * COMMISSION_PCT    BONUS,
                MANAGER_ID                 MGR,
                DEPARTMENT_ID              DEPTID
        FROM    HR.EMPLOYEES
        ;

SELECT * FROM TAB;

----------------------------------------
  2. SQL DEVELOPER 메뉴에서 TABLE 생성
      SKY 계정
         테이블 메뉴 클릭 -> 새 TABLE 클릭 -> TABLE EMP6 생성 :
         
              EMPID NUMBER(8,2)     NOT NULL  PRIMARY KEY
            , ENAME VARCHAR2(46) 
            , TEL   VARCHAR2(20)    NOT NULL 
            , EMAIL VARCHAR2(320)   NOT NULL 
            


         
  3. SCRIPT 로 생성
     CREATE TABLE EMP7 
    (
      EMPID NUMBER(8,2)     NOT NULL 
    , ENAME VARCHAR2(46) 
    , TEL   VARCHAR2(20)    NOT NULL 
    , EMAIL VARCHAR2(320)   NOT NULL 
    , CONSTRAINT EMP7_PK    PRIMARY KEY 
      (
        EMPID 
      )
      ENABLE 
    );
    
[2] 테이블 제거 - 영구적으로 구조와 데이터가 제거된다
  CREATE TABLE EMP1
    AS
      SELECT * FROM EMPLOYEES;
  DROP TABLE EMP1;
    -- DROP 되는 테이블이 부모 테이블일 경우 자식을 먼저 지워야 제거가 가능
  
  DROP TABLE EMPLOYEES; -- 삭제안됨
    -- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
    
    테이블이 삭제 되지 않는다 : 부모키를 가진 부모 테이블은 자식테이블에 데이터가 있다면

    DROP TABLE EMPLOYEES CASCADE;  -- 부모 자식관계를 데이터를 전체 삭제
    
[3] 구조변경 (ALTER)
    1. 칼럼 추가
    
       ALTER TABLE EMP5
         ADD ( LOC VARCHAR2(6) ); -- 추가된 칼럼은 NULL 로 채워짐
        
    2. 칼럼 제거
       ALTER TABLE EMP5
         DROP COLUMN LOC;
         
    3. 테이블 이름 변경 -- ORACLE 명령어
       RENAME EMP4 TO NEWEMP;
       
    4. 칼럼 속성 변경 -- 크기를 늘려주거나 줄인다.
       ALTER TABLE EMP5
         MODIFY (ENAME VARCHAR(60)); -- 46->60
     줄일 때 데이터의 내용이 있으면 내용이 줄어들 수 있다
       
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
테이블을 생성하고 데이터를 파일에 가져온다

CREATE TABLE ZIPCODE
(
    ZIPCODE VARCHAR2(7)              -- 우편번호
    ,SIDO    VARCHAR2(6)             -- 시도
    ,GUGUN   VARCHAR2(26)            -- 구군
    ,DONG    VARCHAR2(78)            -- 읍면동리,건물명
    ,BUNJI   VARCHAR2(26)            -- 번지
    ,SEQ     NUMBER(5)   PRIMARY KEY -- 일련번호
)
;

테이블 생성 후 ZIPCODE 테이블 선택 ->  오른쪽 마우스 버튼 - 데이터 임포트 클릭  - ZIPCODE_UTF8.CSV 선택

SELECT * FROM ZIPCODE;

SELECT COUNT(*) FROM ZIPCODE;   -- 52,144

SELECT COUNT(*) FROM ZIPCODE    -- 3,605
WHERE SIDO = '부산';


-- SIDO 별 우편번호 갯수
SELECT    SIDO 시도, COUNT(ZIPCODE) 우편번호갯수
FROM      ZIPCODE
GROUP BY  SIDO
;

SELECT COUNT(ZIPCODE), COUNT(DISTINCT ZIPCODE)   -- 52144 / 31840
FROM   ZIPCODE;

SELECT '[' || ZIPCODE || ']' ||
        SIDO  ||' '||
        GUGUN ||' '||
        DONG  ||' '||
        BUNJI ||' ' AS ADDRESS
FROM    ZIPCODE
WHERE   DONG LIKE '%부전2동%'
ORDER BY  SEQ ASC
;


