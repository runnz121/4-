1]

1.	STUDY01�� STUDY02�� CONNECT �Ͽ� �� �� SESSION ����	

2. TRANSACTION�� ���� �� ���� - DML
   2.1 STUDY01 ���� TI_DATA�� MAX(NO) Ȯ��  

SELECT MAX(NO)
FROM T1_DATA;

	
   2.2 Ȯ�ε� NO�� �������� T1_DATA���� DELETE ���� 

DELETE FROM T1_DATA;

   2.3 STUDY01 , STUDY02 ���� ���� �ش� NO�� ������ SELECT ? ���翩��Ȯ��

SELECT * FROM STUDY01.T1_DATA;

   2.4 STUDY01 ���� COMMIT ����

   2.5 STUDY01 , STUDY02 ���� �ش� NO�� ������ SELECT�� ���� ��� Ȯ�� (Ʈ����� ���� Ȯ��)







3. TRANSACTION�� ���� �� ���� - DDL    
   3.1 STUDY01 ���� TI_DATA�� MAX(NO) Ȯ�� 

SELECT MAX(NO)
FROM T1_DATA;

   3.2 Ȯ�ε� NO�� �������� T1_DATA���� DELETE ���� 

DELETE 
FROM T1_DATA

;
   3.3 STUDY01 , STUDY02 ���� ���� �ش� NO�� ������ SELECT ? ���翩��Ȯ��

SELECT MAX(NO)
FROM STUDY01.T1_DATA;


   3.4 STUDY01 ���� TEVAL_BACKUP ���̺� DROP

DROP TABLE TTTT_TEST;


   3.5 STUDY01 , STUDY02 ���� �ش� NO�� ������ SELECT�� ���� ��� Ȯ�� (Ʈ����� ���� Ȯ��) 

SELECT * FROM TTTT_TEST;(DROP�� �ٷ� ����)

2]
   
1. SAVEPOINT
   1.1 STUDY01���� TI_DATA�� MAX(NO) Ȯ�� 

SELECT MAX(NO)
FROM T1_DATA;

   1.2 Ȯ�ε� NO���� 1  ���� ���� �������� T1_DATA���� DELETE ����    



   1.3 ���� ���� Ȯ�� �� SAVEPOINT T1_1 ����  

SAVEPOINT A;

   1.4 1.1���� Ȯ���� NO ������ DELETE ����

SELECT MAX(NO)-1
FROM T1_DATA;

   1.5 �������� Ȯ��
   1.6 T1_1 SAVEPOINT�� ROLLABCK ���� 

ROLLBACK TO SAVEPOINT A;

   1.7 ROLLBACK TO T1_1;
   1.8 T1_1 SAVEPOINT ���� ���� �����ʹ� ���� ���� ���°� ���� �����ʹ� ROLLABACK���� ����Ȯ��
   1.9 ROLLBACK �������� ���� ����
