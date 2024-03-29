--테이블 생성할 때 NOT NULL 설정
CREATE TABLE TABLE_NOTNULL(
    LOGIN_ID    VARCHAR2(20) NOT NULL,
    LOGIN_PASS  VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);

DESC TABLE_NOTNULL;

-- 제약 조건이 NOT NULL인 열에 NULL값 넣어보기
INSERT INTO TABLE_NOTNULL
    VALUES('TEST_ID_01',NULL,'010-1234-5678'); --NULL 오류
    
-- 제약 조건이 없는 TEL 열에 NULL값 넣어보기
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PASS)
    VALUES('TEST_ID_01','1234');

-- NOT NULL 데이터 중복 데이터 입력하기
INSERT INTO TABLE_NOTNULL (LOGIN_ID, LOGIN_PASS)
    VALUES('TEST_ID_02','1234');
    
-- NOT NULL 제약 조건이 지정된 열 데이터를 NULL 값으로 업데이트하기
UPDATE TABLE_NOTNULL
    SET LOGIN_PASS =NULL
    WHERE LOGIN_ID = 'TEST_ID_01'; --NULL 오류

-- 제약 조건 살펴보기(SCOTT 계정)
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
    FROM USER_CONSTRAINTS;
    
-- 테이블을 생성할 때 제약 조건에 이름 지정하기
CREATE TABLE TABLE_NOTNULL2(
    LOGIN_ID    VARCHAR(20) CONSTRAINT TBLNN2_LGNID_NN NOT NULL,
    LOGIN_PWD   VARCHAR(20) CONSTRAINT TBLNN2_LGNPW_NN NOT NULL,
    TEL         VARCHAR(20)
);

-- 이미 생성한 테이블에 제약 조건 추가하기
-- TEL 열에 NOT NULL 제약 조건 추가하기
ALTER TABLE TABLE_NOTNULL
    MODIFY(TEL NOT NULL);
    -- 열에 NULL 값이 있는 경우 수정 안됨
    
-- TEL 열 데이터 수정하기
UPDATE TABLE_NOTNULL
    SET TEL='010-1234-5678';
    
    
-- 제약 조건에 이름 지정해서 추가하기
ALTER TABLE TABLE_NOTNULL2
    MODIFY (TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);
    
-- 이미 생성된 제약 조건 이름 변경하기
ALTER TABLE TABLE_NOTNULL2
    RENAME CONSTRAINT TBLNN_TEL_NN TO TBLNN2_TEL_NN;
    
-- 제약 조건 삭제
ALTER TABLE TABLE_NOTNULL2
    DROP CONSTRAINT TBLNN2_TEL_NN;
    
--제약 조건 지정하기(테이블을 생성할 때)
CREATE TABLE TABLE_UNIQUE(
    LOGIN_ID    VARCHAR2(20) UNIQUE,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME LIKE 'TABLE_UNIQUE%';
    
-- TABLE_UNIQUE 테이블에 데이터 입력하기
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('TEST_ID_01', 'PWD01', '010-1234-5678');
    
-- UNIQUE 제약 조건이 지정된 열에 NULL 값 입력하기
INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES(NULL, 'PWD01', '010-1234-5678');
    
SELECT *
    FROM TABLE_UNIQUE;
    
-- TABLE_UNIQUE 테이블 데이터 수정하기
UPDATE TABLE_UNIQUE
    SET LOGIN_ID = 'TEST_ID_01'
    WHERE LOGIN_ID IS NULL; -- 중복 오류
    
-- 테이블을 생성할 때 UNIQUE 제약 조건 설정하기
CREATE TABLE TABLE_UNIQUE2(
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TBLUNQ2_LGNID_UNQ UNIQUE,
    LOGIN_PWD   VARCHAR2(20) CONSTRAINT TBLUNQ2_LGNPW_NN NOT NULL,
    TEL         VARCHAR2(20)
);

--이미 생성된 테이블 열에 UNIQUE 제약 조건 추가하기
ALTER TABLE TABLE_UNIQUE
    MODIFY(TEL UNIQUE);
    
UPDATE TABLE_UNIQUE
    SET TEL = NULL;
    
--UNIQUE 제약 조건 이름 직접 지정하기
ALTER TABLE TABLE_UNIQUE2
    MODIFY (TEL CONSTRAINT TBLUNQ_TEL_UNQ UNIQUE);
    
-- UNIQUE 제약 조건 이름 수정하기
ALTER TABLE TABLE_UNIQUE2
    RENAME CONSTRAINT TBLUNQ_TEL_UNQ TO TBLUNQ2_TEL_UNQ;
    
--UNIQUE 제약 조건 삭제
ALTER TABLE TABLE_UNIQUE2
    DROP CONSTRAINT TBLUNQ2_TEL_UNQ;
    
-- 테이블을 생성할 때 특정 열에 PRIMARY KEY 설정
CREATE TABLE TABLE_PK(
    LOGIN_ID    VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);
    
--
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME LIKE 'TABLE_PK%';
    
-- 자동 생성된 INDEX 확인하기
SELECT INDEX_NAME, TABLE_OWNER, TABLE_NAME
    FROM USER_INDEXES
    WHERE TABLE_NAME LIKE 'TABLE_PK%';
    
-- 제약 조건의 이름을 직접 지정하여 테이블 생성하기
CREATE TABLE TABLE_PK2(
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TBLPK2_LGNID_PK PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) CONSTRAINT TBLPK2_LGNPW_NN NOT NULL,
    TEL         VARCHAR2(20)
);

-- DEPT_PK 테이블 생성
CREATE TABLE DEPT_PK(
    DEPTNO  NUMBER(2) CONSTRAINT DEPTFKK_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13)
);

DESC DEPT_PK;

--EMP_FK 테이블 생성
CREATE TABLE EMP_FK(
    EMPNO       NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(9),
    MGR         NUMBER(4),
    HIREDATE    DATE,
    SAL         NUMBER(7,2),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK 
                    REFERENCES DEPT_PK(DEPTNO)
);

-- EMP_FK 테이블에 데이터 삽입하기 (DEPTNO 데이터가 아직 DEPT_PK  테이블에 없을 때)
INSERT INTO EMP_FK
    VALUES(9999,'TEST_NAME','TEST_JOB',NULL, 
        TO_DATE('2001/01/01','YYYY/MM/DD'), 3000, NULL,10);

-- DEPT_PK 에 데이터 삽입하기
INSERT INTO DEPT_PK
    VALUES(10,'TEST_DNAME','TEST_LOC');

-- DEPT_FK 테이블의 10번 부서 데이터 삭제하기
DELETE FROM DEPT_PK
    WHERE DEPTNO =10; --외래키 오류
    

    
/*
    1. 현재 삭제하려는 열 값을 참조하는 데이터를 먼저 삭제한다.
        EX_ EMP_FK 테이블의 DEPTNO가 10번인 데이터를 삭제한 후 DEPT_PK 테이블의 10번 부서 삭제
        
    2. 현재 삭제하려는 열 값을 참조하는 데이터를 수정한다.
        EX_ EMP_FK 테이블의 DEPTNO 10번인 데이터를 다른 부서번호 또는 NULL 로 변경한 후
            DEPT_PK 테이블의 10번 부서 삭제
    3. 현재 삭제하려는 열을 참조하는 자식 테이블의 FOREIGN KEY 제약 조건을 해제한다.
        
*/

-- ON DELETE CASCADE
-- 열 데이터를 삭제할 때 이 데이터를 참조하고 있는 데이터(행 전체)도 함께 삭제
CREATE TABLE EMP_FK(
    EMPNO       NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(9),
    MGR         NUMBER(4),
    HIREDATE    DATE,
    SAL         NUMBER(7,2),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK 
                    REFERENCES DEPT_PK(DEPTNO)ON DELETE CASCADE
);

DELETE FROM DEPT_PK
    WHERE DEPTNO =10; --DEPT_PK 데이터와 참조하고 있는 EMP_FK 데이터 삭제

DROP TABLE EMP_FK;
-- ON DELETE SET NULL
-- 열 데이터를 삭제할 때 이 데이터를 참조하는 데이터를 NULL 로 수정

CREATE TABLE EMP_FK(
    EMPNO       NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME       VARCHAR2(10),
    JOB         VARCHAR2(9),
    MGR         NUMBER(4),
    HIREDATE    DATE,
    SAL         NUMBER(7,2),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK 
                    REFERENCES DEPT_PK(DEPTNO)ON DELETE SET NULL
);

DELETE FROM DEPT_PK
    WHERE DEPTNO =10;

--테이블 생성할 때 CHECK 제약 조건 설정하기
CREATE TABLE TABLE_CHECK(
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD)>3),
    TEL         VARCHAR2(20)
);

INSERT INTO TABLE_CHECK
    VALUES('TEST_ID','123','010-1234-5678');-- 체크 오류!
    
INSERT INTO TABLE_CHECK
    VALUES('TEST_ID','1234','010-1234-5678');    
    
-- 테이블을 생성할 때 DEFAULT 제약 조건 설정하기
CREATE TABLE TABLE_DEFAULT(
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TBLCK2_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) DEFAULT '1234',
    TEL         VARCHAR2(20)
);

-- DEFAULT로 지정한 기본값이 입력되는 INSERT문 확인
INSERT INTO TABLE_DEFAULT
    VALUES('TEST_ID', NULL, '010-1234-5678');
    
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL)
    VALUES('TEST_ID2', '010-1234-5678');
    
-- 14장 연습문제
CREATE TABLE DEPT_CONST(
    DEPTNO  NUMBER(2) CONSTRAINT DEPTCONST_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14) CONSTRAINT DEPTCONST_DNAME_UNQ UNIQUE,
    LOC     VARCHAR2(13) CONSTRAINT DEPTCONST_LOC_NN NOT NULL
);

CREATE TABLE EMP_CONST(
    EMPTNO      NUMBER(4) CONSTRAINT EMPCONST_EMPNO_PK PRIMARY KEY,
    ENNAME      VARCHAR2(10) CONSTRAINT EMPCONST_ENAME_NN NOT NULL,
    JOB         VARCHAR2(9),
    TEL         VARCHAR2(20) CONSTRAINT EMPCONST_TELL_UNQ UNIQUE,
    HIREDATE    DATE,
    SAL         NUMBER(7,2) CONSTRAINT EMPCONST_SAL_CHK CHECK(SAL BETWEEN 1000 AND 9999),
    COMM        NUMBER(7,2),
    DEPTNO      NUMBER(2) CONSTRAINT EMPCONST_DEPTNO_FK REFERENCES DEPT_CONST(DEPTNO)
);

SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME LIKE '%_CONST'
    ORDER BY TABLE_NAME;