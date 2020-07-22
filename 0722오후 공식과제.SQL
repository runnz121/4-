1]
1. 직원정보에서 부서별,채용 구분 별로 SALARY의 합계, 대상건수, 평균을 구해오는 쿼리

SELECT 
      SUM(SALARY) OVER (PARTITION BY DEPT_CODE,EMP_TYPE ORDER BY SALARY) SUM,
      COUNT(SALARY) OVER (PARTITION BY DEPT_CODE, EMP_TYPE ORDER BY SALARY) COUNT, 
      AVG(SALARY) OVER (PARTITION BY DEPT_CODE,EMP_TYPE ORDER BY SALARY) AVG
FROM TEMP
;
--
SELECT DEPT_CODE, EMP_TYPE, SUM(SALARY)
FROM TEMP
GROUP BY DEPT_CODE, EMP_TYPE;



2. 직원정보에서 부서별,채용 구분 별로 SALARY의 합계, 대상건수, 평균을 구해오되 
   부서별 중간 소계와
   전체 합계를 함께 보여주는 쿼리

SELECT DEPT_CODE,       
       EMP_TYPE,  
      SUM(SALARY),
      COUNT(SALARY), 
      AVG(SALARY) 평균,
      GROUPING(DEPT_CODE) 전체합계,       
      GROUPING(EMP_TYPE) 부서별_중간소계
  
FROM TEMP
GROUP BY ROLLUP(DEPT_CODE, EMP_TYPE);

--
SELECT DEPT_CODE, EMP_TYPE, SUM(SALARY)
FROM TEMP
GROUP BY ROLLUP(DEPT_CODE, EMP_TYPE);



3. 직원정보에서 부서별,채용 구분 별로 SALARY의 합계, 대상건수, 평균을 구해오되 
   부서별 중간 소계, 채용 구분별 소계, 합계를 함께 보여주는 쿼리

   SELECT DEPT_CODE,       
       EMP_TYPE,  
       EMP_ID,
      SUM(SALARY),
      COUNT(SALARY), 
      AVG(SALARY) 평균,
      GROUPING(DEPT_CODE) 전체합계,       
      GROUPING(EMP_TYPE) 부서별_중간소계,
      GROUPING(EMP_ID) 채용별소계
  
FROM TEMP
GROUP BY ROLLUP(DEPT_CODE, EMP_TYPE,EMP_ID);




4. 3번쿼리에서 2번 쿼리를 집합연산자 MINUS를 이용하여 차이 나는 DATA 알아보기 

SELECT DEPT_CODE,       
       EMP_TYPE,  
       EMP_ID,
      SUM(SALARY),
      COUNT(SALARY), 
      AVG(SALARY) 평균,
      GROUPING(DEPT_CODE) 전체합계,       
      GROUPING(EMP_TYPE) 부서별_중간소계,
      GROUPING(EMP_ID) 채용별소계
FROM TEMP
GROUP BY ROLLUP(DEPT_CODE, EMP_TYPE,EMP_ID)

MINUS

SELECT DEPT_CODE,       
       EMP_TYPE,  
       0,
      SUM(SALARY),
      COUNT(SALARY), 
      AVG(SALARY) 평균,
      GROUPING(DEPT_CODE) 전체합계,       
      GROUPING(EMP_TYPE) 부서별_중간소계,
      GROUPING(0)
FROM TEMP
GROUP BY ROLLUP(DEPT_CODE, EMP_TYPE,0);




5. 2번과 3번 쿼리에서 부서코드와 채용구분에 각각 GROUPING 함수를 적용할 경우 
   어떤 값들을 리턴 되는지 확인 
   SELECT DEPT_CODE, EMP



2]
1. 직원정보에서 부서코드, 채용구분, 직급과 SALARY 평균을 가져오되 
   1).부서,채용구분 2).채용구분,직급 3).부서,직급 의 세 가지 조합으로 
   GROUP BY 결과가 나올 수 있도록 GROUPING SET 적용


SELECT DEPT_CODE, 
      EMP_TYPE, 
      LEV,
      AVG(SALARY)

FROM TEMP

GROUP BY GROUPING SETS ((DEPT_CODE, EMP_TYPE),(EMP_TYPE, LEV),(DEPT_CODE, LEV));


   
2. 직원정보에서 부서코드가 A로 시작하는 부서 소속 직원의 
   부서코드, 채용구분, 직급과 SALARY 평균을 가져오되 
   1).부서,채용구분 2).채용구분,직급 의 두 가지 조합으로 
   GROUP BY 결과가 나올 수 있도록 GROUPING SET 적용


SELECT 
    DEPT_CODE,
    EMP_TYPE,
    LEV,
    AVG(SALARY)

FROM TEMP
WHERE SUBSTR(DEPT_CODE,0,1)='A' -- = DEPT_CODE LIKE 'A%'

GROUP BY GROUPING SETS( (DEPT_CODE, EMP_TYPE), (EMP_TYPE,LEV))
;







3. 2번과 같은 결과가 나오는 집합연산자를 이용한 GROUP BY 쿼리 작성

SELECT DEPT_CODE, EMP_TYPE,NULL LEV,AVG(SALARY)
FROM TEMP
GROUP BY DEPT_CODE, EMP_TYPE
HAVING SUBSTR(DEPT_CODE,0,1) ='A'

UNION 


SELECT NULL DEPT_CODE,EMP_TYPE, LEV ,AVG(SALARY)
FROM TEMP
GROUP BY EMP_TYPE, LEV;






3]

1. 직원 정보에서 부서코드,채용구분,직급별 SALARY 합계를 가져오되 
   소계는 부서별로만 나오고 최종 합계가 나오도록 쿼리 작성

SELECT DEPT_CODE,EMP_TYPE,LEV, SUM(SALARY)
FROM TEMP
GROUP BY ROLLUP(DEPT_CODE, (EMP_TYPE, LEV));


2. 1번과 같은 결과가 나오도록 집합연산자를 이용한 쿼리 작성

SELECT DEPT_CODE, EMP_TYPE, LEV, SUM(SALARY)
FROM TEMP
GROUP BY DEPT_CODE,EMP_TYPE,LEV

UNION ALL


SELECT DEPT_CODE,NULL,NULL, SUM(SALARY)
FROM TEMP
GROUP BY DEPT_CODE

UNION ALL

SELECT NULL,NULL,NULL, SUM(SALARY)
FROM TEMP
ORDER BY DEPT_CODE
;

3. 1)부서,채용구분,직급별 2)부서,채용 구분별 3)부서 직급별 4) 부서별의 
   4가지 모두에 대한 SALARY 합계가 나오도록 쿼리 구성

SELECT DEPT_CODE, EMP_TYPE, LEV, SUM(SALARY)
FROM TEMP
GROUP BY DEPT_CODE, ROLLUP(EMP_TYPE),CUBE(LEV);