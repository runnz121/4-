1]

 1. TEMP 테이블에 NOT NULL 인 컬럼만 선택적으로 INSERT 문장 작성 
      성공여부 확인 후 ROLLBACK;

INSERT INTO TEMP (EMP_ID, EMP_NAME, DEPT_CODE, USE_YN)
VALUES ('11111','피피','AAD004','Y');



컬럼 조회
USER_TAB_COLUMNS;
SELECT COLUMN_NAME || ','
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TEMP'
ORDER BY COLUMN_ID;


 2. 1번에 문장에 BIRTH_DATE를 SYSDATE로 입력하는 구문 추가
     성공여부 확인 후 ROLLBACK;

INSERT INTO TEMP (EMP_ID, EMP_NAME, DEPT_CODE, USE_YN,BIRTH_DATE)
VALUES ('11111','피피','AAD004','Y',SYSDATE);




 3. TEMP와 동일 구조 테이블 만들고 TEMP에서 SELECT 한 결과 INSERT
      성공여부 확인 후 ROLLBACK;

CREATE TABLE TEMP01
AS
SELECT * FROM TEMP;


CREATE TABLE TEMP01
AS
SELECT


 4.  연흥부의 전화번호는 DBA_OBJECTS 의 ROW수로, SALARY는 현재 직급의 상한치로 변경  
      성공여부 확인 후 COMMIT;

UPDATE TEMP

SET TEL = (SELECT COUNT(*)
            FROM SYS.DBA_OBJECTS),
            
    SALARY = (SELECT TO_SAL
                FROM EMP_LEVEL
                WHERE EMP_LEVEL.LEV = TEMP.LEV)
   
WHERE EMP_NAME = '연흥부';


2]
1.TEMP의 DEPT_CODE에서 TDEPT의 DEPT_CODE를 참조하는 FOREIGN KEY 생성

ALTER TABLE TEMP
ADD CONSTRAINT FK1_TEMP_DEPT_CODE FOREIGN KEY (DEPT_CODE)
REFERENCES TDEPT(DEPT_CODE); --TEMP DEPT_CODE가 TDEPT의 DEPT_CODE를 바라본다

확인 :
SELECT * FROM TEMP WHERE DEPT_CODE NOT IN(SELECT DEPT_CODE FROM TDEPT);

2.EMP_ID = 19970112 사번의 DEPT_CODE 를 부서코드에 존재하지 않는 코드로 변경
    (무결성 에러확인)

UPDATE  TEMP
SET DEPT_CODE = '155551'
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM TEMP
                    WHERE EMP_ID = '19970122');



3.TEMP 에서 EMP_ID = 19970112 사번 삭제
     삭제 여부 확인 후  ROLLBACK;

DELETE TEMP
WHERE EMP_ID = 19970112;


4.  부서위치가 인천인 부서에 속하는 직원 삭제
     삭제 여부 확인 후  ROLLBACK;

DELETE TEMP
WHERE DEPT_CODE IN (SELECT DEPT_CODE
                    FROM    TDEPT
                    WHERE  TDEPT.AREA = '인천');


5.부서테이블에서 부서코드가 ‘AA0001’ 인 부서 삭제 (에러확인)

DELETE TDEPT
WHERE DEPT_CODE = 'AA0001';


6.TEMP 와 동일한 테이블을 TEMP에서 부서코드가 ‘AA0001’ 인 경우만 SELECT 해서
    CREATE. 다시 TEMP 전 ROW를 새로 만든 테이블에 없으면 INSERT 있으면 SALARY를 반으로  

CREATE TABLE TEMP02
AS
SELECT * FROM TEMP
WHERE TEMP.DEPT_CODE = 'AA0001';


MERGE INTO TEMP02
    USING TEMP
    ON (TEMP02.EMP_ID = TEMP.EMP_ID)
    WHEN MATCHED THEN 
        UPDATE SET
           TEMP02.SALARY = TEMP.SALARY/2   
      
    WHEN NOT MATCHED THEN
        INSERT 
        VALUES(TEMP.EMP_ID,
               TEMP.EMP_NAME,
               TEMP.BIRTH_DATE,
               TEMP.DEPT_CODE,
               TEMP.EMP_TYPE,
               TEMP.USE_YN,
               TEMP.TEL,
               TEMP.HOBBY,
               TEMP.SALARY,
               TEMP.LEV,
               TEMP.EVAL_YN               
               );

3]

    1. TEMP에서 취미가 NULL 인 경우만 TEMP1에 CREATE TABLE TEMP1 ….. SELECT ..로

CREATE TABLE TEMP_HOBBY_NULL
AS
SELECT * FROM TEMP
WHERE TEMP.HOBBY IS NULL;

    2. TEMP 자료 중 TEMP1에 있는 자료는 EVAL_YN 을  ‘Y’로 변경하고 없는 자료는 TEMP 자료를 그대로 INSERT
MERGE INTO TEMP01
    USING TEMP
    ON (TEMP01.EMP_ID = TEMP.EMP_ID)
    WHEN MATCHED THEN
        UPDATE SET
        TEMP01.EVAL_YN = 'Y'
        
    WHEN NOT MATCHED THEN
        INSERT
        VALUES(TEMP.EMP_ID,
               TEMP.EMP_NAME,
               TEMP.BIRTH_DATE,
               TEMP.DEPT_CODE,
               TEMP.EMP_TYPE,
               TEMP.USE_YN,
               TEMP.TEL,
               TEMP.HOBBY,
               TEMP.SALARY,
               TEMP.LEV,
               TEMP.EVAL_YN               
               );


