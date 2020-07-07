--�����纯������ = (�ְ��Ǹŷ��ǿ��� - �����Ǹŷ��� ����) / (�ְ��Ǹŷ� - �����Ǹŷ�)
--�������� = �ְ��Ǹŷ����� -(�����纯������*�ְ��Ǹŷ�)


-- 1�ܰ� : ����/��ǰ�� �Ǹŷ��� �ѿ��� �и�
-- 2�ܰ� : 1�ܰ踦 �̿��Ͽ� �������� DATA�� �ּ� �Ǹŷ��� �ִ��Ǹŷ��� DATA�� ��ǰ���� ã��
--         (�ϳ�ġ�� ��ǰ���� GROUP BY �ϰ� �� �߿� MIN �� MAX���� �����´�)
--          1�� �� �ּ� �Ǹŷ� �ּ��Ǹŷ��� �ѿ���, 1�� �� �ִ� �Ǹŷ�, �ִ��Ǹŷ� �ѿ���

-- 3�ܰ� : 2�ܰ� ������ ������ ���� ������ �������� ���ϴ� �Ŀ� ����
--*���� : �ּ�(�ְ�) �Ǹŷ��� ��� �ش���� �ѿ����� max, min ����� �پ� �ٳ�� �ȴ�.

--������ ��������
--�ְ��Ǹŷ� ���� = �ְ��Ǹŷ�/�������



--1�ܰ�

SELECT 
    YYMM_YM,ITEM_CD,
    SUM(DECODE(BUDGET_CD,62099011,PROD_AM)) �������,
    SUM(DECODE(BUDGET_CD,62099101,PROD_AM)) �ѿ��� 
    
FROM TEST17
GROUP BY YYMM_YM,ITEM_CD
;



-- 2�ܰ� : 1�ܰ踦 �̿��Ͽ� �������� DATA�� �ּ� �Ǹŷ��� �ִ��Ǹŷ��� DATA�� ��ǰ���� ã��
--         (�ϳ�ġ�� ��ǰ���� GROUP BY �ϰ� �� �߿� MIN �� MAX���� �����´�)
--          1�� �� �ּ� �Ǹŷ� �ּ��Ǹŷ��� �ѿ���, 1�� �� �ִ� �Ǹŷ�, �ִ��Ǹŷ� �ѿ���


SELECT 
    ITEM_CD,
    ROUND(MAX(DECODE(BUDGET_CD,'62099011',PROD_AM))) �ִ��Ǹŷ���_�������ǸŰ���,
    ROUND(MAX(DECODE(BUDGET_CD,'62099101',PROD_AM))) �ִ��Ǹŷ�_���ȸ������Ƹ����,
    ROUND(MIN(DECODE(BUDGET_CD,'62099011',PROD_AM))) �ּ��Ǹŷ�_�������ǸŰ���,
    ROUND(MIN(DECODE(BUDGET_CD,'62099101',PROD_AM))) �ּ��Ǹŷ�_���ȸ������Ƹ����
    
FROM TEST17
GROUP BY ITEM_CD;


-- 3�ܰ� : 2�ܰ� ������ ������ ���� ������ �������� ���ϴ� �Ŀ� ����
--*���� : �ּ�(�ְ�) �Ǹŷ��� ��� �ش���� �ѿ����� max, min ����� �پ� �ٳ�� �ȴ�.

--�����纯������ = (�ְ��Ǹŷ��ǿ��� - �����Ǹŷ��� ����) / (�ְ��Ǹŷ� - �����Ǹŷ�)
--�������� = �ְ��Ǹŷ����� -(�����纯������*�ְ��Ǹŷ�)
--�ְ��Ǹŷ� ���� = �ְ��Ǹŷ�/�������


--2�ܰ�
SELECT ITEM_CD,   
         MIN(Q) AS Q1,
         MAX(Q) AS Q2,
        (MIN(Q + C/10000000000) - MIN(Q))*10000000000 AS C1,      
        (MAX(Q + C/10000000000) - MAX(Q))*10000000000 AS C2
FROM (
    SELECT YYMM_YM,
            ITEM_CD,
            ROUND(SUM(DECODE(BUDGET_CD,'62099011',PROD_AM))) Q,
            ROUND(SUM(DECODE(BUDGET_CD,'62099101',PROD_AM))) C
            FROM TEST17
            WHERE YYMM_YM >= TO_CHAR(TO_NUMBER(SUBSTR('199803',1,4))-1)
                ||SUBSTR('199803',5,2)
            AND YYMM_YM < '199803'
            GROUP BY 
                YYMM_YM,
                ITEM_CD
            )
            GROUP BY
                ITEM_CD;
             
--3�ܰ�
SELECT ITEM_CD AS ��ǰ,
    DECODE(Q2,Q1,NULL,ROUND(C2 - C1)/(Q2-Q1)) AS �����纯������,
    DECODE(Q2,Q1,NULL,ROUND(C2-((C2-C1)/(Q2-Q1))*Q2)) AS ��������

FROM(SELECT ITEM_CD, 
        MIN(Q) AS Q1,
        MAX(Q) AS Q2,
        (MIN(Q + C/10000000000) - MIN(Q))*10000000000 AS C1,      
        (MAX(Q + C/10000000000) - MAX(Q))*10000000000 AS C2
FROM (
    SELECT YYMM_YM,
            ITEM_CD,
            ROUND(SUM(DECODE(BUDGET_CD,'62099011',PROD_AM))) Q,
            ROUND(SUM(DECODE(BUDGET_CD,'62099101',PROD_AM))) C
            FROM TEST17
            WHERE YYMM_YM >= TO_CHAR(TO_NUMBER(SUBSTR('199803',1,4))-1)
                ||SUBSTR('199803',5,2)
            AND YYMM_YM < '199803'
            GROUP BY 
                YYMM_YM,
                ITEM_CD
            )
            GROUP BY
                ITEM_CD
                )
               ;
               
     -- ����1

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION my_friend(p_emp_id NUMBER)
RETURN NUMBER IS
    p_birth_date DATE;
    f_emp_id NUMBER;
BEGIN
    -- �Ű������� �־��� ����� ������ p_birth_date�� �Է�
    SELECT  BIRTH_DATE
    INTO    p_birth_date
    FROM    TEMP
    WHERE   EMP_ID = p_emp_id;
    
    -





- p_birth_date���� ������ ���� ����� ������������ ����, 1��° ���(my_friend)�� ����� f_emp_id�� �Է�
SELECT  EMP_ID
    INTO    f_emp_id
    FROM    (SELECT ROWNUM NO, EMP_ID FROM TEMP WHERE BIRTH_DATE < p_birth_date ORDER BY BIRTH_DATE DESC)
    WHERE   ROWNUM = 1;
    
    -- f_emp_id�� ����
    RETURN  f_emp_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN -1;
    WHEN OTHERS THEN
    RAISE;
END;
                   

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

         1. DBA_TABLES���� ���̺���� �ҹ��ڷ� �� ���̺� ã�� 
2. DBA_OBJECTS���� NAME�� �ҹ��ڰ� ���Ե� ���̺� ã�� 
3. ����� �μ��ڵ带 �������� �μ��ڵ�� ù ��° �ڸ��� �빮�ڰ� ��������

SELECT EMP_ID,INITCAP(DEPT_CODE) FROM TEMP;

4. ����� ��̸� �������� ��̴� ���� ���� 10�ڸ��� ǥ���ϰ�  ���� ���ڸ��� ��*�� �� ä�� ��

SELECT EMP_ID,HOBBY, LPAD(HOBBY,10,'*') FROM TEMP;

5. ����� ��̸� �������� ��̴� ���� ���� 10�ڸ��� ǥ���ϰ� ���� ���ڸ��� ��*�� �� ä�� ��

SELECT EMP_ID,HOBBY, RPAD(HOBBY,10,'*') FROM TEMP;

6. ���, �μ��ڵ� ���� �� �ڸ� ��������

SELECT EMP_ID,SUBSTR(DEPT_CODE,0,2) FROM TEMP;

7. ���, �μ��ڵ� ��° �ڸ� ���� ��� ��������

SELECT EMP_ID,SUBSTR(DEPT_CODE,3) FROM TEMP;

8. ���, �μ��ڵ� ��°���� 4�ڸ� ��������

SELECT EMP_ID,SUBSTR(DEPT_CODE,4) FROM TEMP;

9. ���, �μ��ڵ�, �μ��ڵ忡 0�� ���ʷ� ��Ÿ���� �ڸ� ��������


10. �μ� ���̺��� �ڵ�, ��Ī, ��Ī �� �������� �̶� ���ڴ� ��**�� �� ġȯ�Ͽ� ��������  

SELECT DEPT_CODE,DEPT_NAME,REPLACE(DEPT_NAME, '����', '**') FROM TDEPT;

11. ASCII �� 89���� �ش�Ǵ� ���ڴ�? 

SELECT CHR(89) FROM DUAL;

12. ��!��, SPACE, ��~�� �� �ش��ϴ� ASCII �ڵ� �� �о����

SELECT ASCII('!') FROM DUAL; 33
SELECT ASCII(' ') FROM DUAL; 32
SELECT ASCII('~') FROM DUAL;126

13. ���, SALARY/12 �� �Ҽ����Ʒ� �� ��°, 1�� �ڸ�, 100�� �ڸ��� �ݿø� �� �� ��������

SELECT EMP_ID, ROUND(SALARY/12,2),ROUND(SALARY/12,0),ROUND(SALARY/12,-2) FROM TEMP;


14. ���, SALARY/12 �� �Ҽ����Ʒ� �� ��°, 1�� �ڸ�, 100�� �ڸ� ���� ����� ���� 

SELECT EMP_ID, TRUNC(SALARY/12,2),TRUNC(SALARY/12,0),TRUNC(SALARY/12,-2) FROM TEMP;


15. ROW��ȣ, EMP_ID, EMP_NAME, ROW ��ȣ�� 3���� ���� ��, 
  3���� ���� �� ���� ū ���� ���� ����, 3���� ���� ������ ���� ���� ū ������ ��������

SELECT ROWNUM, EMP_ID, ROWNUM/3, ROUND(GREATEST(ROWNUM/3)), ROUND(LEAST(ROWNUM/3)) FROM TEMP;


16. 11�� ������ ��, 4������ ��, 556�� ������ �˾Ƴ���

SELECT POWER(11,2), POWER(4,2), SQRT(556) FROM DUAL;

17. -100, 100�� �Լ� �ΰ��� ��ø���� ����Ͽ� ��� 1�� �ٲٱ�

SELECT SIGN(ABS(-100)),SIGN(100) FROM DUAL;


18. ���, SALARY, SALARY�� õ������ ���� ������ ��������

SELECT EMP_ID, SALARY, MOD(SALARY,10000000) FROM TEMP;

19. TEMP ���̺��� ���ڵ带 ������� �� ���� ���� ��ȣ ���� ��, ���, ���� ��������



20. ���,����,�����, ����Ͽ� 55���� ���� ��¥, ����Ͽ� 55���� �� ��¥ ��������

SELECT EMP_ID, EMP_NAME, BIRTH_DATE, TO_DATE(ADD_MONTHS(BIRTH_DATE,-55),'YYYY-MM-DD')FROM TEMP;


21. ���ƿ��� �Ͽ��ϰ� ����� ��¥�� ã�Ƴ���

SELECT EMP_ID, EMP_NAME, BIRTH_DATE, NEXT_DAY(BIRTH_DATE, '�����')FROM TEMP;
SELECT EMP_ID, EMP_NAME, BIRTH_DATE, NEXT_DAY(BIRTH_DATE, '�Ͽ���')FROM TEMP;

22. EMP_ID,EMP_NAME, ����Ͽ� �ش�Ǵ� ����� ������ ���� ã��

SELECT EMP_ID, EMP_NAME, BIRTH_DATE, LAST_DAY(TO_DATE(BIRTH_DATE,'YYYY-MM-DD'))FROM TEMP;

23. ����ð���  ��1980-01-25 00:00:00��, ��1980-JAN-25 000000�� �� ���� ������ ���ڷ� �����ֱ�

SELECT TO_CHAR(SYSDATE,'YYYY-Mon-DD HH24MISS','NLS_DATE_LANGUAGE=ENGLISH') FROM DUAL;

24. EMP_ID, EMP_NAME, SALARY/12, SALARY/12�� �Ҽ��� �Ʒ� �� �ڸ����� �����ֱ�  

SELECT EMP_ID, EMP_NAME, SALARY/12, ROUND(SALARY/12,2) FROM TEMP;

25. EMP_ID, EMP_NAME, HOBBY, HOBBY�� NULL�̸� ��0��, �ƴϸ� ��1�� �� ���

SELECT EMP_ID, EMP_NAME, HOBBY, NVL(SIGN(ASCII(HOBBY)),0) FROM TEMP;

26. EMP_ID, EMP_NAME, TEL, HOBBY, EMP_TYPE, TEL ������ TEL, ������ HOBBY, �׵� ������ EMP_TYPE�� �����ֱ�       
           

20. SALARY �� 4õ������ 6õ���� ������ �ڷ� �˻��ϱ� (BETWEEN �˻�)

SELECT *FROM TEMP WHERE SALARY BETWEEN 40000000 AND 60000000;

21. ��̰� �뷡,���,�ٵ� �� 1������ ���� �˻��ϱ� (IN �˻�)

SELECT *FROM TEMP WHERE REGEXP_LIKE(HOBBY, '�뷡|���|�ٵ�');

22. ���� ���̡� �� ���� �˻�

SELECT * FROM TEMP WHERE  EMP_NAME LIKE '%��_%';

23. ���� ���̡� ��� ���ڰ� �� ���� �˻�

SELECT * FROM TEMP WHERE  EMP_NAME LIKE '%��%';

24. ���� �� ��° ���ڰ� ���桯 �� ��� �˻�

SELECT * FROM TEMP WHERE  EMP_NAME LIKE '%_��_%';

25. ��̰� NULL �� ���� �˻�

SELECT * FROM TEMP WHERE HOBBY IS NULL;

26. SALARY �� 5õ���� ���� ū ȫ�� �˻�

SELECT * FROM TEMP WHERE (SALARY >50000000 AND EMP_NAME LIKE'%ȫ_%');

27. SALARY �� 5õ���� ���� ũ�ų� ȫ���� ���� �˻�

SELECT * FROM TEMP WHERE (SALARY >50000000 OR EMP_NAME LIKE'%ȫ_%');


    
    