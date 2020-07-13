1]

 1. TEMP ���̺� NOT NULL �� �÷��� ���������� INSERT ���� �ۼ� 
      �������� Ȯ�� �� ROLLBACK;

INSERT INTO TEMP (EMP_ID, EMP_NAME, DEPT_CODE, USE_YN)
VALUES ('11111','����','AAD004','Y');



�÷� ��ȸ
USER_TAB_COLUMNS;
SELECT COLUMN_NAME || ','
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TEMP'
ORDER BY COLUMN_ID;


 2. 1���� ���忡 BIRTH_DATE�� SYSDATE�� �Է��ϴ� ���� �߰�
     �������� Ȯ�� �� ROLLBACK;

INSERT INTO TEMP (EMP_ID, EMP_NAME, DEPT_CODE, USE_YN,BIRTH_DATE)
VALUES ('11111','����','AAD004','Y',SYSDATE);




 3. TEMP�� ���� ���� ���̺� ����� TEMP���� SELECT �� ��� INSERT
      �������� Ȯ�� �� ROLLBACK;

CREATE TABLE TEMP01
AS
SELECT * FROM TEMP;


CREATE TABLE TEMP01
AS
SELECT


 4.  ������� ��ȭ��ȣ�� DBA_OBJECTS �� ROW����, SALARY�� ���� ������ ����ġ�� ����  
      �������� Ȯ�� �� COMMIT;

UPDATE TEMP

SET TEL = (SELECT COUNT(*)
            FROM SYS.DBA_OBJECTS),
            
    SALARY = (SELECT TO_SAL
                FROM EMP_LEVEL
                WHERE EMP_LEVEL.LEV = TEMP.LEV)
   
WHERE EMP_NAME = '�����';


2]
1.TEMP�� DEPT_CODE���� TDEPT�� DEPT_CODE�� �����ϴ� FOREIGN KEY ����

ALTER TABLE TEMP
ADD CONSTRAINT FK1_TEMP_DEPT_CODE FOREIGN KEY (DEPT_CODE)
REFERENCES TDEPT(DEPT_CODE); --TEMP DEPT_CODE�� TDEPT�� DEPT_CODE�� �ٶ󺻴�

Ȯ�� :
SELECT * FROM TEMP WHERE DEPT_CODE NOT IN(SELECT DEPT_CODE FROM TDEPT);

2.EMP_ID = 19970112 ����� DEPT_CODE �� �μ��ڵ忡 �������� �ʴ� �ڵ�� ����
    (���Ἲ ����Ȯ��)

UPDATE  TEMP
SET DEPT_CODE = '155551'
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM TEMP
                    WHERE EMP_ID = '19970122');



3.TEMP ���� EMP_ID = 19970112 ��� ����
     ���� ���� Ȯ�� ��  ROLLBACK;

DELETE TEMP
WHERE EMP_ID = 19970112;


4.  �μ���ġ�� ��õ�� �μ��� ���ϴ� ���� ����
     ���� ���� Ȯ�� ��  ROLLBACK;

DELETE TEMP
WHERE DEPT_CODE IN (SELECT DEPT_CODE
                    FROM    TDEPT
                    WHERE  TDEPT.AREA = '��õ');


5.�μ����̺��� �μ��ڵ尡 ��AA0001�� �� �μ� ���� (����Ȯ��)

DELETE TDEPT
WHERE DEPT_CODE = 'AA0001';


6.TEMP �� ������ ���̺��� TEMP���� �μ��ڵ尡 ��AA0001�� �� ��츸 SELECT �ؼ�
    CREATE. �ٽ� TEMP �� ROW�� ���� ���� ���̺� ������ INSERT ������ SALARY�� ������  

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

    1. TEMP���� ��̰� NULL �� ��츸 TEMP1�� CREATE TABLE TEMP1 ��.. SELECT ..��

CREATE TABLE TEMP_HOBBY_NULL
AS
SELECT * FROM TEMP
WHERE TEMP.HOBBY IS NULL;

    2. TEMP �ڷ� �� TEMP1�� �ִ� �ڷ�� EVAL_YN ��  ��Y���� �����ϰ� ���� �ڷ�� TEMP �ڷḦ �״�� INSERT
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


