--단위당변동원가 = (최고판매량의원가 - 최저판매량의 원가) / (최고판매량 - 최저판매량)
--고정원가 = 최고판매량원가 -(단위당변동원가*최고판매량)


-- 1단계 : 월별/제품별 판매량과 총원가 분리
-- 2단계 : 1단계를 이용하여 여러월의 DATA중 최소 판매량과 최대판매량의 DATA를 제품별로 찾기
--         (일년치를 제품별로 GROUP BY 하고 그 중에 MIN 과 MAX값을 가져온다)
--          1년 중 최소 판매량 최소판매량의 총원가, 1년 중 최대 판매량, 최대판매량 총원가

-- 3단계 : 2단계 정보를 단위당 변동 원가와 고정원가 구하는 식에 대입
--*주의 : 최소(최고) 판매량의 양과 해당월의 총원가는 max, min 적용시 붙어 다녀야 된다.

--단위당 변동원가
--최고판매량 원가 = 최고판매량/매출수량



--1단계

SELECT 
    YYMM_YM,ITEM_CD,
    SUM(DECODE(BUDGET_CD,62099011,PROD_AM)) 매출수량,
    SUM(DECODE(BUDGET_CD,62099101,PROD_AM)) 총원가 
    
FROM TEST17
GROUP BY YYMM_YM,ITEM_CD
;



-- 2단계 : 1단계를 이용하여 여러월의 DATA중 최소 판매량과 최대판매량의 DATA를 제품별로 찾기
--         (일년치를 제품별로 GROUP BY 하고 그 중에 MIN 과 MAX값을 가져온다)
--          1년 중 최소 판매량 최소판매량의 총원가, 1년 중 최대 판매량, 최대판매량 총원가


SELECT 
    ITEM_CD,
    ROUND(MAX(DECODE(BUDGET_CD,'62099011',PROD_AM))) 최대판매량시_아이템판매갯수,
    ROUND(MAX(DECODE(BUDGET_CD,'62099101',PROD_AM))) 최대판매량_총팔린아이탬매출액,
    ROUND(MIN(DECODE(BUDGET_CD,'62099011',PROD_AM))) 최소판매량_아이템판매갯수,
    ROUND(MIN(DECODE(BUDGET_CD,'62099101',PROD_AM))) 최소판매량_총팔린아이탬매출액
    
FROM TEST17
GROUP BY ITEM_CD;


-- 3단계 : 2단계 정보를 단위당 변동 원가와 고정원가 구하는 식에 대입
--*주의 : 최소(최고) 판매량의 양과 해당월의 총원가는 max, min 적용시 붙어 다녀야 된다.

--단위당변동원가 = (최고판매량의원가 - 최저판매량의 원가) / (최고판매량 - 최저판매량)
--고정원가 = 최고판매량원가 -(단위당변동원가*최고판매량)
--최고판매량 원가 = 최고판매량/매출수량


--2단계
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
             
--3단계
SELECT ITEM_CD AS 제품,
    DECODE(Q2,Q1,NULL,ROUND(C2 - C1)/(Q2-Q1)) AS 단위당변동원가,
    DECODE(Q2,Q1,NULL,ROUND(C2-((C2-C1)/(Q2-Q1))*Q2)) AS 고정원가

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
               
     -- 과제1

SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION my_friend(p_emp_id NUMBER)
RETURN NUMBER IS
    p_birth_date DATE;
    f_emp_id NUMBER;
BEGIN
    -- 매개변수로 주어진 사번의 생일을 p_birth_date에 입력
    SELECT  BIRTH_DATE
    INTO    p_birth_date
    FROM    TEMP
    WHERE   EMP_ID = p_emp_id;
    
    -





- p_birth_date보다 생일이 빠른 사람을 내림차순으로 정렬, 1번째 사람(my_friend)의 사번을 f_emp_id에 입력
SELECT  EMP_ID
    INTO    f_emp_id
    FROM    (SELECT ROWNUM NO, EMP_ID FROM TEMP WHERE BIRTH_DATE < p_birth_date ORDER BY BIRTH_DATE DESC)
    WHERE   ROWNUM = 1;
    
    -- f_emp_id를 리턴
    RETURN  f_emp_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN -1;
    WHEN OTHERS THEN
    RAISE;
END;
                   

1.	생년별 인원수, SALARY 평균, 최고 SALARY, 최저 SALARY, SALARY 총합, 분산, 표준편차

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(TO_CHAR(BIRTH_DATE,'YYYY')), AVG(SALARY), MIN(SALARY), SUM(SALARY), VARIANCE(SALARY), ROUND(STDDEV(SALARY),1)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY');

2.	1번의 결과 중 SALARY 평균이 5천만원 이상이 건만 조회하기

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(TO_CHAR(BIRTH_DATE,'YYYY')), AVG(SALARY), MIN(SALARY), SUM(SALARY), VARIANCE(SALARY), ROUND(STDDEV(SALARY),1)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
HAVING AVG(SALARY) >50000000;

3.	생년별 인원수, SALARY 평균, SALARY 총합/인원수 ? 결과관찰  마지막 두 컬럼이 같은지

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(TO_CHAR(BIRTH_DATE,'YYYY')), ROUND(AVG(SALARY),1),  ROUND(SUM(SALARY)/COUNT(TO_CHAR(BIRTH_DATE,'YYYY')),1)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
HAVING AVG(SALARY) >50000000;

4.   UPDATE TEMP
     SET      SALARY = NULL
     WHERE EMP_NAME = '홍길동';
5.   3번 다시 실행 후 결과 관찰
6.     ROLLBACK;
7. 생년,취미 별 GROUP BY 적용해 인원수, 평균 SALARY 가져오기

SELECT TO_CHAR(BIRTH_DATE,'YYYY'), COUNT(BIRTH_DATE), AVG(SALARY)
FROM TEMP
GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
HAVING TO_CHAR(BIRTH_DATE,'YYYY') IS NOT NULL;


SELECT HOBBY, COUNT(HOBBY), AVG(SALARY)
FROM TEMP
GROUP BY HOBBY
HAVING HOBBY IS NOT NULL;

8. HOBBY별 평균 SALARY

SELECT HOBBY,COUNT(HOBBY),
ROUND(AVG(SALARY),1)
FROM TEMP
GROUP BY HOBBY
HAVING HOBBY IS NOT NULL;

9. 8번 평균 SALARY의 최소 값









10. 특정 사번 P_EMP_ID, 조회조건 P_CONDITION  두 매개변수를 받아 
   P_CONDITION  이 1 이면 해당 사번이 속한 부서의 평균 급여를 리턴해주고
   P_CONDITION  이 2 이면 해당 사번과 같은 직급의 급여 평균을 리턴해주는 함수 AVG_BY_CASE 작성 

CREATE OR REPLACE FUNCTION SEARCH1(P_EMP_ID NUMBER, P_CONDITION NUMBER) RETURN NUMBER IS
P_LEV VARCHAR2(10); -- 직급 연봉 평균을 구하기 위한 변수 지정 
P_DEPT_CODE VARCHAR2(10); -- 부서 연봉 평균을 구하기 위한 변수 지정
P_SAL TEMP.SALARY%TYPE; --변수 테이블명.컬럼%TYPE : 해당 테이블의 컬럼과 같은 유형

BEGIN
     --주어진 매개변수를 부서연봉, 직급 연봉 변수에 대입
    SELECT DEPT_CODE, LEV -- SELECT N개 선택시
    INTO P_DEPT_CODE, P_LEV --변수도 N개 들어와야된다.
    FROM TEMP
    WHERE EMP_ID = P_EMP_ID;
 --주어진 매개변수가 P_DEPT_SAL,P_LEV_SAL에 대입됨 
 --주어진 매개변수(P_EMP_ID값을 EMP_ID 컬럼에서 찾아서 해당 ROW의 컬럼값(DEPT_CODE, LEV)에서 조회하여 P_DEPT_CODE, P_LEV 변수에 각각 넣는다
 --P_DEPT_SAL 은 DEPT_CODE 컬럼에서, P_LEV_SAL 은 LEV 컬럼값을 가져온다
 
 
 
     
--매개변수로 주어진 CONDITION 의 경우가1,2인 경우
    SELECT AVG(SALARY) -- SELECT 에 컬럼이 올 필요 없음 애초에 평균의 조건값을 여기에 적어준다.
    INTO P_SAL
    FROM TEMP
    WHERE DECODE(P_CONDITION,1,P_DEPT_CODE,2,P_LEV)=DECODE(P_CONDITION,1,DEPT_CODE,2,LEV);
    
-- WHERE은 연산자가 와야된다.
-- IF OR 연산자가 올때
-- P_CONDITION 이 1 인 경우 P_DEPT_CODE가 출력, 2인 경우 P_LEV를 출력) = P_CONDITION 이 1 인 경우 DEPT_CODE컬럼에서 같은 값으로 치부
-- 2인 경우 LEV 컬럼에서 같은 값으로 치부한다
-- 즉 P_DEPT_CODE = DEPT_CODE, P_LEV = LEV 라는 조건을 걸어주는거임 아래 주석문 참고
    
    
 
-- SELECT AVG(SALARY)
-- INTO P_SAL
-- FROM TEMP
-- WHERE DEPT_CODE = P_DEPT_CODE;
    
-- SELECT AVG(SALARY)
-- INTO P_SAL
-- FROM TEMP
-- WHERE LEV = P_LEV;
    




RETURN --값을 RETURN P_SAL 을 리턴
    
P_SAL;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
    RETURN -1;
    WHEN OTHERS THEN
    RAISE;
END;





11. 10번을 검증할 수 있는 SQL 작성 후 검증

SELECT SEARCH1(20050404,1) FROM DUAL;
SELECT SEARCH1(20050404,2) FROM DUAL;

12. 생년별 최고 SALARY, MAX(ID) 를 읽어 오기 
SELECT TO_CHAR(BIRTH_DATE,'YYYY'),         
        MAX(SALARY+(EMP_ID/100000000)) MAXX,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8) MAXX_ID,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),1,8) MAXX_SAL
        FROM TEMP
         GROUP BY TO_CHAR(BIRTH_DATE,'YYYY'
        HAVING SUBSTR(MAX(SALARY+(EMP_ID/100000000)),10) > 0;

13. 12번 결과가 테이블에서 같은 레코드인지 아닌지 CHECK하기


14  12번 뒤에 SALARY와 EMP_ID 연결해서 MAX값 구하기 

SELECT TO_CHAR(BIRTH_DATE,'YYYY'),         
        MAX(SALARY+(EMP_ID/100000000)) MAXX,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8) MAXX_ID,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),1,8) MAXX_SAL,
        TO_CHAR('사번'||':'||SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8)) || '연봉'||':'||SUBSTR(MAX(SALARY+(EMP_ID/100000000)),1,8) MAXXX
        FROM TEMP
        
        GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
        
        HAVING SUBSTR(MAX(SALARY+(EMP_ID/100000000)),10) > 0;




15. 생년별 최고 SALARY ID, 최고금액, 최저SALARY ID, 최저금액 가져오기
   (SUB QUERY 없이 INLINE VIEW를 사용하되 TEMP TABLE ACCESS는 한 번만 가능)

SELECT TO_CHAR(BIRTH_DATE,'YYYY'),         
       
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),-8) MAXX_ID,
        SUBSTR(MAX(SALARY+(EMP_ID/100000000)),0,8) MAXX_SAL,
       
        SUBSTR(MIN(SALARY+(EMP_ID/1000000000)),-8) MINN_ID,
        SUBSTR(MIN(SALARY+(EMP_ID/100000000)),0,8) MINN_SAL
        
        FROM TEMP
        GROUP BY TO_CHAR(BIRTH_DATE,'YYYY')
        HAVING SUBSTR(MAX(SALARY+(EMP_ID/100000000)),8) > 0;

         1. DBA_TABLES에서 테이블명이 소문자로 된 테이블 찾기 
2. DBA_OBJECTS에서 NAME에 소문자가 포함된 테이블 찾기 
3. 사번과 부서코드를 가져오되 부서코드는 첫 번째 자리만 대문자가 나오도록

SELECT EMP_ID,INITCAP(DEPT_CODE) FROM TEMP;

4. 사번과 취미를 가져오되 취미는 우측 정렬 10자리로 표시하고  앞의 빈자리는 ‘*’ 로 채울 것

SELECT EMP_ID,HOBBY, LPAD(HOBBY,10,'*') FROM TEMP;

5. 사번과 취미를 가져오되 취미는 좌측 정렬 10자리로 표시하고 뒤의 빈자리는 ‘*’ 로 채울 것

SELECT EMP_ID,HOBBY, RPAD(HOBBY,10,'*') FROM TEMP;

6. 사번, 부서코드 앞의 두 자리 가져오기

SELECT EMP_ID,SUBSTR(DEPT_CODE,0,2) FROM TEMP;

7. 사번, 부서코드 셋째 자리 이후 모두 가져오기

SELECT EMP_ID,SUBSTR(DEPT_CODE,3) FROM TEMP;

8. 사번, 부서코드 셋째부터 4자리 가져오기

SELECT EMP_ID,SUBSTR(DEPT_CODE,4) FROM TEMP;

9. 사번, 부서코드, 부서코드에 0이 최초로 나타나는 자리 가져오기


10. 부서 테이블에서 코드, 명칭, 명칭 중 ‘지원’ 이란 글자는 ‘**’ 로 치환하여 가져오기  

SELECT DEPT_CODE,DEPT_NAME,REPLACE(DEPT_NAME, '지원', '**') FROM TDEPT;

11. ASCII 값 89번에 해당되는 문자는? 

SELECT CHR(89) FROM DUAL;

12. ‘!’, SPACE, ’~’ 에 해당하는 ASCII 코드 값 읽어오기

SELECT ASCII('!') FROM DUAL; 33
SELECT ASCII(' ') FROM DUAL; 32
SELECT ASCII('~') FROM DUAL;126

13. 사번, SALARY/12 를 소수점아래 두 번째, 1의 자리, 100의 자리로 반올림 한 값 가져오기

SELECT EMP_ID, ROUND(SALARY/12,2),ROUND(SALARY/12,0),ROUND(SALARY/12,-2) FROM TEMP;


14. 사번, SALARY/12 를 소수점아래 두 번째, 1의 자리, 100의 자리 까지 남기고 절사 

SELECT EMP_ID, TRUNC(SALARY/12,2),TRUNC(SALARY/12,0),TRUNC(SALARY/12,-2) FROM TEMP;


15. ROW번호, EMP_ID, EMP_NAME, ROW 번호를 3으로 나눈 값, 
  3으로 나눈 값 보다 큰 가장 작은 정수, 3으로 나눈 값보다 작은 가장 큰 정수를 가져오기

SELECT ROWNUM, EMP_ID, ROWNUM/3, ROUND(GREATEST(ROWNUM/3)), ROUND(LEAST(ROWNUM/3)) FROM TEMP;


16. 11을 제곱한 값, 4제곱한 값, 556의 제곱근 알아내기

SELECT POWER(11,2), POWER(4,2), SQRT(556) FROM DUAL;

17. -100, 100을 함수 두개를 중첩으로 사용하여 모두 1로 바꾸기

SELECT SIGN(ABS(-100)),SIGN(100) FROM DUAL;


18. 사번, SALARY, SALARY를 천만으로 나눈 나머지 가져오기

SELECT EMP_ID, SALARY, MOD(SALARY,10000000) FROM TEMP;

19. TEMP 테이블의 레코드를 순서대로 세 개씩 같은 번호 붙인 값, 사번, 성명 가져오기



20. 사번,성명,출생일, 출생일에 55개월 더한 날짜, 출생일에 55개월 뺀 날짜 가져오기

SELECT EMP_ID, EMP_NAME, BIRTH_DATE, TO_DATE(ADD_MONTHS(BIRTH_DATE,-55),'YYYY-MM-DD')FROM TEMP;


21. 돌아오는 일요일과 목요일 날짜로 찾아내기

SELECT EMP_ID, EMP_NAME, BIRTH_DATE, NEXT_DAY(BIRTH_DATE, '목요일')FROM TEMP;
SELECT EMP_ID, EMP_NAME, BIRTH_DATE, NEXT_DAY(BIRTH_DATE, '일요일')FROM TEMP;

22. EMP_ID,EMP_NAME, 출생일에 해당되는 년월의 마지막 일자 찾기

SELECT EMP_ID, EMP_NAME, BIRTH_DATE, LAST_DAY(TO_DATE(BIRTH_DATE,'YYYY-MM-DD'))FROM TEMP;

23. 현재시간을  ‘1980-01-25 00:00:00’, ‘1980-JAN-25 000000’ 와 같은 형식의 문자로 보여주기

SELECT TO_CHAR(SYSDATE,'YYYY-Mon-DD HH24MISS','NLS_DATE_LANGUAGE=ENGLISH') FROM DUAL;

24. EMP_ID, EMP_NAME, SALARY/12, SALARY/12를 소수점 아래 두 자리까지 보여주기  

SELECT EMP_ID, EMP_NAME, SALARY/12, ROUND(SALARY/12,2) FROM TEMP;

25. EMP_ID, EMP_NAME, HOBBY, HOBBY가 NULL이면 ‘0’, 아니면 ‘1’ 을 출력

SELECT EMP_ID, EMP_NAME, HOBBY, NVL(SIGN(ASCII(HOBBY)),0) FROM TEMP;

26. EMP_ID, EMP_NAME, TEL, HOBBY, EMP_TYPE, TEL 있으면 TEL, 없으면 HOBBY, 그도 없으면 EMP_TYPE을 보여주기       
           

20. SALARY 가 4천만원과 6천만원 사이인 자료 검색하기 (BETWEEN 검색)

SELECT *FROM TEMP WHERE SALARY BETWEEN 40000000 AND 60000000;

21. 취미가 노래,등산,바둑 중 1가지인 직원 검색하기 (IN 검색)

SELECT *FROM TEMP WHERE REGEXP_LIKE(HOBBY, '노래|등산|바둑');

22. 성이 ‘이’ 인 직원 검색

SELECT * FROM TEMP WHERE  EMP_NAME LIKE '%이_%';

23. 성명에 ‘이’ 라는 문자가 들어간 직원 검색

SELECT * FROM TEMP WHERE  EMP_NAME LIKE '%이%';

24. 성명 두 번째 글자가 ‘길’ 인 사람 검색

SELECT * FROM TEMP WHERE  EMP_NAME LIKE '%_길_%';

25. 취미가 NULL 인 직원 검색

SELECT * FROM TEMP WHERE HOBBY IS NULL;

26. SALARY 가 5천만원 보다 큰 홍씨 검색

SELECT * FROM TEMP WHERE (SALARY >50000000 AND EMP_NAME LIKE'%홍_%');

27. SALARY 가 5천만원 보다 크거나 홍씨인 직원 검색

SELECT * FROM TEMP WHERE (SALARY >50000000 OR EMP_NAME LIKE'%홍_%');


    
    