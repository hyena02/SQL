-------------------------------------------------------------

DDL : data definition language
     구조를 생성, 변경, 제거
     
CREATE  
ALTER   
DROP    
     
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



