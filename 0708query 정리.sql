2.TEMP���� �ڹ�������  �޿��� ���Թ޴� ���� �˻� (��������)

SELECT T1.EMP_ID, T1.EMP_NAME, T1.SALARY
FROM TEMP T1, TEMP T2
WHERE T1.SALARY < T2.SALARY AND
T2.EMP_NAME = '�ڹ���'
;
3.EMP_LEVEL ���� �޿� �������� ���ϰ� TEMP ��� �� �ڱ� ������ 
    ������ ���� �޿��� ���� ���� ��������

SELECT (T1.TO_SAL + T1.FROM_SAL)/2,T2.EMP_ID,T2.EMP_NAME
FROM EMP_LEVEL T1, TEMP T2
WHERE T1.LEV = T2.LEV
AND(T1.TO_SAL + T1.FROM_SAL)/2 < T2.SALARY;


4.TEMP ,TCOM�� EMP_ID�� �����Ͽ� ��� ������ ��������,  TEMP�� �����ϴ� �ڷ� ���� ���

SELECT * FROM TEMP T1, TCOM T2
WHERE T1.EMP_ID = T2.EMP_ID(+)
AND T2.WORK_YEAR(+)<'2020'; // (+)�� ���� ���̺��� �÷��� ������ ��� �� ���ǿ��� ��� (+)�ٿ��� �Ѵ�.





5.EMP_ID ���� �ڽź��� SALARY�� ���� �ο� COUNT

SELECT T1.EMP_NAME, COUNT(T2.EMP_ID) AS ����_��
FROM TEMP T1
LEFT OUTER JOIN TEMP T2
ON T1.SALARY < T2.SALARY
GROUP BY T1.EMP_NAME;



6.  TEMP �� TDEPT CROSS JOIN
SELECT 
    * FROM TEMP
    CROSS JOIN TDEPT;


7.  TEMP �� TDEPT NATURAL JOIN
SELECT 
    * FROM TEMP
    NATURAL JOIN TDEPT;

SELECT EMP_ID, DEPT

9.  NATURAL JOIN ON �� ����Ͽ� ���,�μ�,EMP_LEV ���� ����

SELECT T1.EMP_NAME, T1.DEPT_CODE,
       T2.LEV
FROM TEMP T1 
JOIN EMP_LEVEL T2
ON T1.LEV = T2.LEV;


10.  ���, ����, TEMP.�μ��ڵ�, TDEPT.�μ��ڵ� , �μ����� �������� LEFT OUTER JOIN ����

SELECT T1.EMP_ID, T1.EMP_NAME, T1.DEPT_CODE,
       T2.DEPT_NAME,T2.DEPT_CODE
FROM TEMP T1 
LEFT OUTER JOIN TDEPT T2
ON T1.DEPT_CODE = T2.DEPT_CODE;


11.  10���� FROM���� ���� ���̺�� outer JOIN���� ���� ���̺� �ٲ㼭 ����



12.  ���, ����, TEMP.�μ��ڵ�, TDEPT.�μ��ڵ� , �μ����� �������� RIGHT OUTER JOIN ����

	SELECT T1.EMP_ID, T1.EMP_NAME, T1.DEPT_CODE,
       T2.DEPT_NAME,T2.DEPT_CODE
FROM TEMP T1 
RIGHT OUTER JOIN TDEPT T2
ON T1.DEPT_CODE = T2.DEPT_CODE;

13. ���, ����, TEMP.�μ��ڵ�, TDEPT.�μ��ڵ� , �μ����� �������� FULL OUTER JOIN ����

SELECT T1.EMP_ID, T1.EMP_NAME, T1.DEPT_CODE,
       T2.DEPT_NAME,T2.DEPT_CODE
FROM TEMP T1 
FULL OUTER JOIN TDEPT T2
ON T1.DEPT_CODE = T2.DEPT_CODE;

14. 13������ ����� 2020�� �����ϴ� ������ �˻�

SELECT T1.EMP_ID, T1.EMP_NAME, T1.DEPT_CODE,
       T2.DEPT_NAME,T2.DEPT_CODE
FROM TEMP T1 JOIN TDEPT T2
ON (T1.DEPT_CODE = T2.DEPT_CODE)
AND T1.EMP_ID LIKE '2000%';;

//


15.������̺��� SALARY�� Ȧ.¦�� ��  1:2�� ������ ������ �����ϴµ� Ŀ�̼� ���̺� Ŀ�̼��� ��ϵ� ����� �ش� Ŀ�̼��� �ſ� �޿��� ���� �����ϰ��� �մϴ�.
    ������ ���̺��� ����� ���� �� ��ŭ��  ROW�� �����ϰ� 1������ 12������ ���� �ݾ��� �÷����� ������ �� �ֵ��� �ϼ���. (T2_DATA ���� : EMP_ID, SAL01, SAL02,��.,SAL12)
    ��, SALARY�� ���� �޿��� �Ҽ��� �Ʒ��� �� ������ �ø� ó�� �մϴ�.������

CREATE TABLE T2_DATA
AS
SELECT A.EMP_ID,
    CEIL(SALARY/18) + NVL(COMM,0) SAL01,
    CEIL(SALARY/9)  + NVL(COMM,0) SAL02,
    CEIL(SALARY/18) + NVL(COMM,0) SAL03,
    CEIL(SALARY/9)  + NVL(COMM,0) SAL04,
    CEIL(SALARY/18) + NVL(COMM,0) SAL05,
    CEIL(SALARY/9)  + NVL(COMM,0) SAL06,
    CEIL(SALARY/18) + NVL(COMM,0) SAL07,
    CEIL(SALARY/9)  + NVL(COMM,0) SAL08,
    CEIL(SALARY/18) + NVL(COMM,0) SAL09,
    CEIL(SALARY/9)  + NVL(COMM,0) SAL10,
    CEIL(SALARY/18) + NVL(COMM,0) SAL11,
    CEIL(SALARY/9)  + NVL(COMM,0) SAL12
FROM TEMP A, TCOM B
WHERE B.EMP_ID(+) = A.EMP_ID
AND B.WORK_YEAR(+) = '2020'
ORDER BY 1;





