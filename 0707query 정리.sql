1.	���⺰ �ο���, SALARY ���, �ְ� SALARY, ���� SALARY, SALARY ����, �л�, ǥ������

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(TO_CHAR(BIRTH_DATE,'YYYY')), AVG(SALARY), MIN(SALARY), SUM(SALARY), VARIANCE(SALARY), ROUND(STDDEV(SALARY),1)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY');

2.	1���� ��� �� SALARY ����� 5õ���� �̻��� �Ǹ� ��ȸ�ϱ�

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(TO_CHAR(BIRTH_DATE,'YYYY')), AVG(SALARY), MIN(SALARY), SUM(SALARY), VARIANCE(SALARY), ROUND(STDDEV(SALARY),1)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
HAVING AVG(SALARY) >50000000;

3.	���⺰ �ο���, SALARY ���, SALARY ����/�ο��� ? �������  ������ �� �÷��� ������

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(TO_CHAR(BIRTH_DATE,'YYYY')), ROUND(AVG(SALARY),1),  ROUND(SUM(SALARY)/COUNT(TO_CHAR(BIRTH_DATE,'YYYY')),1)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
HAVING AVG(SALARY) >50000000;

4.   UPDATE TEMP
     SET      SALARY = NULL
     WHERE EMP_NAME = 'ȫ�浿';
5.   3�� �ٽ� ���� �� ��� ����
6.     ROLLBACK;
7. ����,��� �� GROUP BY ������ �ο���, ��� SALARY ��������

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(BIRTH_DATE), AVG(SALARY)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
HAVING TO_CHAR(BIRTH_DATE,'YYYY') IS NOT NULL;


SELECT HOBBY, COUNT(HOBBY), AVG(SALARY)
FROM TEMP
GROUP BY HOBBY
HAVING HOBBY IS NOT NULL;

8. HOBBY�� ��� SALARY

SELECT HOBBY,COUNT(HOBBY),
ROUND(AVG(SALARY),1)
FROM TEMP
GROUP BY HOBBY
HAVING HOBBY IS NOT NULL;

9. 8�� ��� SALARY�� �ּ� ��









10. Ư�� ��� P_EMP_ID, ��ȸ���� P_CONDITION  �� �Ű������� �޾� 
   P_CONDITION  �� 1 �̸� �ش� ����� ���� �μ��� ��� �޿��� �������ְ�
   P_CONDITION  �� 2 �̸� �ش� ����� ���� ������ �޿� ����� �������ִ� �Լ� AVG_BY_CASE �ۼ� 

CREATE OR REPLACE FUNCTION SEARCH1(P_EMP_ID NUMBER, P_CONDITION NUMBER) RETURN NUMBER IS
P_LEV VARCHAR2(10); -- ���� ���� ����� ���ϱ� ���� ���� ���� 
P_DEPT_CODE VARCHAR2(10); -- �μ� ���� ����� ���ϱ� ���� ���� ����
P_SAL TEMP.SALARY%TYPE; --���� ���̺��.�÷�%TYPE : �ش� ���̺��� �÷��� ���� ����

BEGIN
     --�־��� �Ű������� �μ�����, ���� ���� ������ ����
    SELECT DEPT_CODE, LEV -- SELECT N�� ���ý�
    INTO P_DEPT_CODE, P_LEV --������ N�� ���;ߵȴ�.
    FROM TEMP
    WHERE EMP_ID = P_EMP_ID;
 --�־��� �Ű������� P_DEPT_SAL,P_LEV_SAL�� ���Ե� 
 --�־��� �Ű�����(P_EMP_ID���� EMP_ID �÷����� ã�Ƽ� �ش� ROW�� �÷���(DEPT_CODE, LEV)���� ��ȸ�Ͽ� P_DEPT_CODE, P_LEV ������ ���� �ִ´�
 --P_DEPT_SAL �� DEPT_CODE �÷�����, P_LEV_SAL �� LEV �÷����� �����´�
 
 
 
     
--�Ű������� �־��� CONDITION �� ��찡1,2�� ���
    SELECT AVG(SALARY) -- SELECT �� �÷��� �� �ʿ� ���� ���ʿ� ����� ���ǰ��� ���⿡ �����ش�.
    INTO P_SAL
    FROM TEMP
    WHERE DECODE(P_CONDITION,1,P_DEPT_CODE,2,P_LEV)=DECODE(P_CONDITION,1,DEPT_CODE,2,LEV);
    
-- WHERE�� �����ڰ� �;ߵȴ�.
-- IF OR �����ڰ� �ö�
-- P_CONDITION �� 1 �� ��� P_DEPT_CODE�� ���, 2�� ��� P_LEV�� ���) = P_CONDITION �� 1 �� ��� DEPT_CODE�÷����� ���� ������ ġ��
-- 2�� ��� LEV �÷����� ���� ������ ġ���Ѵ�
-- �� P_DEPT_CODE = DEPT_CODE, P_LEV = LEV ��� ������ �ɾ��ִ°��� �Ʒ� �ּ��� ����
    
    
 
-- SELECT AVG(SALARY)
-- INTO P_SAL
-- FROM TEMP
-- WHERE DEPT_CODE = P_DEPT_CODE;
    
-- SELECT AVG(SALARY)
-- INTO P_SAL
-- FROM TEMP
-- WHERE LEV = P_LEV;
    




RETURN --���� RETURN P_SAL �� ����
    
P_SAL;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN -1;
    WHEN OTHERS THEN
    RAISE;
END;





11. 10���� ������ �� �ִ� SQL �ۼ� �� ����

SELECT SEARCH1(20050404,1) FROM DUAL;
SELECT SEARCH1(20050404,2) FROM DUAL;

12. ���⺰ �ְ� SALARY, MAX(ID) �� �о� ���� 
SELECT TO_CHAR(BIRTH_DATE,'YYYY'),         
        MAX(SALARY+(EMP_ID/100000000)) MAXX,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8) MAXX_ID,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),1,8) MAXX_SAL
        FROM TEMP
         GROUP BY TO_CHAR(BIRTH_DATE,'YYYY'
        HAVING SUBSTR(MAX(SALARY+(EMP_ID/100000000)),10) > 0;

13. 12�� ����� ���̺��� ���� ���ڵ����� �ƴ��� CHECK�ϱ�


14  12�� �ڿ� SALARY�� EMP_ID �����ؼ� MAX�� ���ϱ� 

SELECT TO_CHAR(BIRTH_DATE,'YYYY'),         
        MAX(SALARY+(EMP_ID/100000000)) MAXX,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8) MAXX_ID,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),1,8) MAXX_SAL,
        TO_CHAR('���'||':'||SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8)) || '����'||':'||SUBSTR(MAX(SALARY+(EMP_ID/100000000)),1,8) MAXXX
        FROM TEMP
        
        GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
        
        HAVING SUBSTR(MAX(SALARY+(EMP_ID/100000000)),10) > 0;




15. ���⺰ �ְ� SALARY ID, �ְ�ݾ�, ����SALARY ID, �����ݾ� ��������
   (SUB QUERY ���� INLINE VIEW�� ����ϵ� TEMP TABLE ACCESS�� �� ���� ����)

SELECT TO_CHAR(BIRTH_DATE,'YYYY'),         
       
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8) MAXX_ID,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),0,8) MAXX_SAL,
       
        SUBSTR(MIN(SALARY+(EMP_ID/1000000000)),-8) MINN_ID,
        SUBSTR(MIN(SALARY+(EMP_ID/100000000)),0,8) MINN_SAL
        
        FROM TEMP
        GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
        HAVING SUBSTR(MAX(SALARY+(EMP_ID/100000000)),8) > 0;

