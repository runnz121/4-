1.	SALARY 가 강감찬보다 많은 직원의 이름,SALARY 가져오기

SELECT EMP_NAME
FROM TEMP
WHERE SALARY>(SELECT SALARY
              FROM TEMP
              WHERE EMP_NAME = '강감찬');

2.	부서가 김길동과 같고 SALARY가 강감찬보다 많은 사번,성명,부서코드,SALARY 가져오기

SELECT EMP_NAME,EMP_ID,DEPT_CODE,SALARY
FROM TEMP
WHERE SALARY>(SELECT SALARY
              FROM TEMP
              WHERE EMP_NAME = '강감찬')
              
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM TEMP
                 WHERE EMP_NAME = '김길동');


3.	가장 월급을 많이 받는 사람의 이름, SALARY 검색 (서브쿼리)

SELECT EMP_NAME,EMP_ID,DEPT_CODE,SALARY
FROM TEMP
WHERE SALARY>(SELECT SALARY
              FROM TEMP
              WHERE EMP_NAME = '강감찬')
              
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM TEMP
                 WHERE EMP_NAME = '김길동');

4.	부서별 최저월급을 출력하되 BC0001부서의 최저월급보다는 큰 값만 가져오기

SELECT DEPT_CODE 부서코드, MIN(SALARY) 부서별_최저월급 ?GROUP BY로 MIN(SALARY)하여 최저 부서월급 정해준후 HAVING 조건으로 부서코드 값 걸러줌
FROM TEMP
GROUP BY DEPT_CODE
HAVING MIN(SALARY) > (SELECT MIN(SALARY)
                        FROM TEMP
                        WHERE DEPT_CODE = 'BC0001');

5.	각 부서 최저 SALARY와 SALARY가 같은 직원 정보 검색

SELECT DEPT_CODE 부서코드, MIN(SALARY) 부서별_최저월급
FROM TEMP
GROUP BY DEPT_CODE
HAVING MIN(SALARY) = (SELECT MIN(SALARY)
                        FROM TEMP
                        WHERE SALARY=EMP_ID);

6.	직급이 차장인 사람들 중 누구든 어느 한 사람보다는 급여를 많이 받는 사원 정보 가져오기 

SELECT EMP_ID, SALARY 
FROM TEMP
WHERE SALARY>  ANY
                    (SELECT SALARY
                        FROM TEMP
                        WHERE LEV='차장');




7.	직급이 사원인 어느 누구보다 급여를 많이 받는 사원 정보 가져오기 

SELECT EMP_ID, SALARY 
FROM TEMP
WHERE SALARY>  ANY
                    (SELECT SALARY
                        FROM TEMP
                        WHERE EMP_ID='19950303');


8.19950303 직원의 취미와 취미가 같은 사원 정보 가져오기
SELECT EMP_ID,  HOBBY
FROM TEMP
WHERE SALARY IN
                    (SELECT SALARY
                        FROM TEMP
                        WHERE EMP_ID='19950303');






2]
1. &SAL 이라는 치환변수를 입력받아 변수값과 SALARY가 같은 사원 검색 쿼리 작성 후 
   (변수 값에 50000000, ‘50000000’, ‘5천만원’ 을 넣어 각각 실행해보기 

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE SALARY = &SAL;

2. 1번 치환변수를 앞뒤로 작은 따옴표 붙여 재실행
   (변수 값에 50000000, ‘50000000’ 을 넣어 각각 재실행)

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE SALARY = '&SAL';

3. HOBBY를 &HOBBY를 통해 입력받아  HOBBY와 입력값이 같은 정보 검색 쿼리 작성 후
   (변수 값에 등산, ‘등산’ 을 넣어 각각 재실행)

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE HOBBY = '&HOBBY';

4. 3번 치환변수를 앞뒤로 작은 따옴표 붙여 재실행
   (변수 값에 등산, ‘등산’ 을 넣어 각각 재실행)

SELECT EMP_ID,EMP_NAME,SALARY
FROM TEMP
WHERE HOBBY = '&HOBBY';


5. 자기 직급의 평균 연봉보다 급여가 적은 직원정보 가져오기 

SELECT DEPT_CODE,AVG(SALARY) 부서별평균연봉
FROM TEMP 
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > (SELECT AVG(SALARY)
                        FROM TEMP
                        WHERE LEV= '&LEV');

6. 인천에 근무하는 직원 가져오기 (서브쿼리 이용)  
SELECT TT.BOSS_ID 인천사는사람사번, T1.EMP_NAME,T1.SALARY
FROM TEMP T1,


(SELECT BOSS_ID
    FROM TDEPT
    WHERE BOSS_ID IN (SELECT BOSS_ID
                        FROM TDEPT
                        WHERE AREA='&지역')
                        ) TT
WHERE TT.BOSS_ID = T1.EMP_ID
 ;


3]




1.	TCOM에 연봉 외에 COMMISSION을 받는 직원의 사번이 보관되어 있다. 이 정보를 SUB QUERY로 SELECT 하여 부서 명칭별로 COMMISSION 을 받는 인원수를 세는 문장을 만들기

SELECT  COUNT(TCOM1.EMP_ID), T1.DEPT_CODE


FROM TEMP T1,(SELECT EMP_ID
                FROM TCOM
                WHERE WORK_YEAR > 2019) TCOM1
GROUP BY T1.DEPT_CODE
HAVING TCOM1.EMP_ID = T1.EMP_ID; --HAVING 절에는 SELECT 절에들어간 그룹함수를 비교하는 값을 넣어야됨


2.	치환변수로 숫자를 한 번만 입력받아 입력값, 입력값+ 10, 입력값 * 10을 구하는 쿼리
SELECT SALARY, SALARY+10, SALARY*10
FROM TEMP
WHERE SALARY = '&SAL';
