1]

1.	STUDY01과 STUDY02로 CONNECT 하여 두 개 SESSION 생성	

2. TRANSACTION의 시작 과 종료 - DML
   2.1 STUDY01 에서 TI_DATA의 MAX(NO) 확인  

SELECT MAX(NO)
FROM T1_DATA;

	
   2.2 확인된 NO를 조건으로 T1_DATA에서 DELETE 수행 

DELETE FROM T1_DATA;

   2.3 STUDY01 , STUDY02 에서 각각 해당 NO의 데이터 SELECT ? 존재여부확인

SELECT * FROM STUDY01.T1_DATA;

   2.4 STUDY01 에서 COMMIT 수행

   2.5 STUDY01 , STUDY02 에서 해당 NO의 데이터 SELECT로 동일 결과 확인 (트랜잭션 종료 확인)







3. TRANSACTION의 시작 과 종료 - DDL    
   3.1 STUDY01 에서 TI_DATA의 MAX(NO) 확인 

SELECT MAX(NO)
FROM T1_DATA;

   3.2 확인된 NO를 조건으로 T1_DATA에서 DELETE 수행 

DELETE 
FROM T1_DATA

;
   3.3 STUDY01 , STUDY02 에서 각각 해당 NO의 데이터 SELECT ? 존재여부확인

SELECT MAX(NO)
FROM STUDY01.T1_DATA;


   3.4 STUDY01 에서 TEVAL_BACKUP 테이블 DROP

DROP TABLE TTTT_TEST;


   3.5 STUDY01 , STUDY02 에서 해당 NO의 데이터 SELECT로 동일 결과 확인 (트랜잭션 종료 확인) 

SELECT * FROM TTTT_TEST;(DROP은 바로 적용)

2]
   
1. SAVEPOINT
   1.1 STUDY01에서 TI_DATA의 MAX(NO) 확인 

SELECT MAX(NO)
FROM T1_DATA;

   1.2 확인된 NO보다 1  작은 값을 조건으로 T1_DATA에서 DELETE 수행    



   1.3 삭제 여부 확인 후 SAVEPOINT T1_1 수행  

SAVEPOINT A;

   1.4 1.1에서 확인한 NO 값으로 DELETE 수행

SELECT MAX(NO)-1
FROM T1_DATA;

   1.5 삭제여부 확인
   1.6 T1_1 SAVEPOINT로 ROLLABCK 수행 

ROLLBACK TO SAVEPOINT A;

   1.7 ROLLBACK TO T1_1;
   1.8 T1_1 SAVEPOINT 실행 이전 데이터는 아직 삭제 상태고 이후 데이터는 ROLLABACK으로 복구확인
   1.9 ROLLBACK 수행으로 원상 복구
