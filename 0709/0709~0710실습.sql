1.	SALARY �� ���������� ���� ������ �̸�,SALARY ��������

SELECT EMP_NAME
FROM TEMP
WHERE SALARY>(SELECT SALARY
              FROM TEMP
              WHERE EMP_NAME = '������');

2.	�μ��� ��浿�� ���� SALARY�� ���������� ���� ���,����,�μ��ڵ�,SALARY ��������

SELECT EMP_NAME,EMP_ID,DEPT_CODE,SALARY
FROM TEMP
WHERE SALARY>(SELECT SALARY
              FROM TEMP
              WHERE EMP_NAME = '������')
              
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM TEMP
                 WHERE EMP_NAME = '��浿');


3.	���� ������ ���� �޴� ����� �̸�, SALARY �˻� (��������)

SELECT EMP_NAME,EMP_ID,DEPT_CODE,SALARY
FROM TEMP
WHERE SALARY>(SELECT SALARY
              FROM TEMP
              WHERE EMP_NAME = '������')
              
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM TEMP
                 WHERE EMP_NAME = '��浿');

4.	�μ��� ���������� ����ϵ� BC0001�μ��� �������޺��ٴ� ū ���� ��������

SELECT DEPT_CODE �μ��ڵ�, MIN(SALARY) �μ���_�������� ?GROUP BY�� MIN(SALARY)�Ͽ� ���� �μ����� �������� HAVING �������� �μ��ڵ� �� �ɷ���
FROM TEMP
GROUP BY DEPT_CODE
HAVING MIN(SALARY) > (SELECT MIN(SALARY)
                        FROM TEMP
                        WHERE DEPT_CODE = 'BC0001');

5.	�� �μ� ���� SALARY�� SALARY�� ���� ���� ���� �˻�

SELECT DEPT_CODE �μ��ڵ�, MIN(SALARY) �μ���_��������
FROM TEMP
GROUP BY DEPT_CODE
HAVING MIN(SALARY) = (SELECT MIN(SALARY)
                        FROM TEMP
                        WHERE SALARY=EMP_ID);

6.	������ ������ ����� �� ������ ��� �� ������ٴ� �޿��� ���� �޴� ��� ���� �������� 

SELECT EMP_ID, SALARY 
FROM TEMP
WHERE SALARY>  ANY
                    (SELECT SALARY
                        FROM TEMP
                        WHERE LEV='����');




7.	������ ����� ��� �������� �޿��� ���� �޴� ��� ���� �������� 

SELECT EMP_ID, SALARY 
FROM TEMP
WHERE SALARY>  ANY
                    (SELECT SALARY
                        FROM TEMP
                        WHERE EMP_ID='19950303');


8.19950303 ������ ��̿� ��̰� ���� ��� ���� ��������
SELECT EMP_ID,  HOBBY
FROM TEMP
WHERE SALARY IN
                    (SELECT SALARY
                        FROM TEMP
                        WHERE EMP_ID='19950303');






2]
1. &SAL �̶�� ġȯ������ �Է¹޾� �������� SALARY�� ���� ��� �˻� ���� �ۼ� �� 
   (���� ���� 50000000, ��50000000��, ��5õ������ �� �־� ���� �����غ��� 

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE SALARY = &SAL;

2. 1�� ġȯ������ �յڷ� ���� ����ǥ �ٿ� �����
   (���� ���� 50000000, ��50000000�� �� �־� ���� �����)

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE SALARY = '&SAL';

3. HOBBY�� &HOBBY�� ���� �Է¹޾�  HOBBY�� �Է°��� ���� ���� �˻� ���� �ۼ� ��
   (���� ���� ���, ����ꡯ �� �־� ���� �����)

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE HOBBY = '&HOBBY';

4. 3�� ġȯ������ �յڷ� ���� ����ǥ �ٿ� �����
   (���� ���� ���, ����ꡯ �� �־� ���� �����)

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE HOBBY = '&HOBBY';


5. �ڱ� ������ ��� �������� �޿��� ���� �������� �������� 

SELECT DEPT_CODE,AVG(SALARY) �μ�����տ���
FROM TEMP 
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > (SELECT AVG(SALARY)
                        FROM TEMP
                        WHERE LEV= '&LEV');

6. ��õ�� �ٹ��ϴ� ���� �������� (�������� �̿�)  
SELECT TT.BOSS_ID ��õ��»�����, T1.EMP_NAME,T1.SALARY
FROM TEMP T1,


(SELECT BOSS_ID
    FROM TDEPT
    WHERE BOSS_ID IN (SELECT BOSS_ID
                        FROM TDEPT
                        WHERE AREA='&����')
                        ) TT
WHERE TT.BOSS_ID = T1.EMP_ID
 ;


3]




1.	TCOM�� ���� �ܿ� COMMISSION�� �޴� ������ ����� �����Ǿ� �ִ�. �� ������ SUB QUERY�� SELECT �Ͽ� �μ� ��Ī���� COMMISSION �� �޴� �ο����� ���� ������ �����

SELECT  COUNT(TCOM1.EMP_ID), T1.DEPT_CODE


FROM TEMP T1,(SELECT EMP_ID
                FROM TCOM
                WHERE WORK_YEAR > 2019) TCOM1
GROUP BY T1.DEPT_CODE
HAVING TCOM1.EMP_ID = T1.EMP_ID; --HAVING ������ SELECT ������ �׷��Լ��� ���ϴ� ���� �־�ߵ�


2.	ġȯ������ ���ڸ� �� ���� �Է¹޾� �Է°�, �Է°�+ 10, �Է°� * 10�� ���ϴ� ����
SELECT SALARY, SALARY+10, SALARY*10
FROM TEMP
WHERE SALARY = '&SAL';
