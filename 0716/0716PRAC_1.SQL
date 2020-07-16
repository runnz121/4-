--temp1 table drop;
--temp table을 복사해 temp1 생성;

--1]

--1. TEMP1에서 직급이 ‘과장’인 사람의 모든 정보를 보여주는 VIEW 작성 (VEMP1)

CREATE VIEW VEMP1
    AS SELECT *
    FROM TEMP1
    WHERE LEV = '과장';
    
SELECT * FROM VEMP1;


--2. TEMP1에서 모든 직원의 정보를 보여주되 생년월일, SALARY, 전화번호, 평가여부, 직급, 채용형태 
--등 민감한 정보는 보이지 않길 바랍니다. 
--이들을 제외한 나머지 정보만 볼 수 있도록 VEMP2 VIEW 생성. 
CREATE OR REPLACE VIEW VEMP3
    AS SELECT EMP_ID AS 사번, EMP_NAME AS 성명, DEPT_CODE AS 부서코드, USE_YN AS 근무여부, HOBBY AS 취미, LEV AS 직급
    FROM TEMP1;
   
    
SELECT * FROM VEMP3;


--3. 2번과 동일한 정보를 보여주는 VEMP3 VIEW를 만들되 컬럼명이 한글로 사번, 성명, 부서코드, 근무여부, 취미, 직급 이라고 나오도록 VIEW 생성

CREATE OR REPLACE VIEW VEMP2
    AS SELECT EMP_ID AS 사번, EMP_NAME AS 성명, DEPT_CODE AS 부서코드, USE_YN AS 근무여부, HOBBY AS 취미, LEV AS 직급
    FROM TEMP1;
   
    
SELECT * FROM VEMP2;

--4. VEMP3에서 취미가 농구인사람 검색하는 쿼리 작성

SELECT * FROM VEMP2
WHERE 취미 = '농구';

SELECT * FROM VEMP2;
--5. USER_VIEWS를 통해 현재까지 생성한 VIEW 목록 확인 


SELECT * FROM USER_VIEWS;


--2]
--1. 부서코드,부서명, 최고SALARY를 받는 사번, 최고SALARY, 최소SALARY를 받는 
--사번, 최소SALARY 를 보여주는 VEMP5 VIEW를 만듭니다. 

CREATE VIEW VEMPP (부서코드, 부서명, MAXSALARY, MINSALARY)
            AS SELECT T.DEPT_CODE, D.DEPT_NAME, MAX(T.SALARY), MIN(T.SALARY)
            FROM TDEPT D, TEMP T
            WHERE D.DEPT_CODE = T.DEPT_CODE
            GROUP BY T.DEPT_CODE,D.DEPT_NAME;
            
SELECT * FROM VEMPP;

--2. TEMP1 EMP_ID 에 ALTER TABLE 명령으로 RPRIMARY KEY 생성


ALTER TABLE TEMP1
ADD CONSTRAINTS EMP_ID_PK PRIMARY KEY (EMP_ID);


--3. VEMP1에 ‘차장’ INSERT 문장 1개 수행 후 TEMP1에 실제 INSERT 되었는지 확인 후 ROLLBACK;
INSERT INTO VEMP1 (LEV)
        VALUES ('차장');


--4. VEMP2에 있는 컬럼은 모두 값 부여하여 VEMP2를 이용한 INSERT 후 TEMP1 확인 후 ROLLBACK;

INSERT INTO VEMP1 VALUES(11121,'차장','1991/10/05','A0001',123,'Y',010,'농구',20000000,'차장','A')


--5. 4번에 SALARY 추가하여 INSERT 문장 작성 후 실행하여 오류 확인 


--6. VEMP3를 통한 INSERT 수행 성공여부 확인 후 ROLLBACK;



--3]
--1. 부서코드,부서명, 최고SALARY를 받는 사번, 최고SALARY, 최소SALARY를 받는 사번, 최소SALARY 를 보여주는 VEMP5 VIEW를 만듭니다. 


--1. TEMP와 TDEPT를 조인하여 TEMP의 사번,성명,부서코드,사용여부 와 TDEPT의 부서명을 가져오는
--    VEMP6 VIEW 만들기


--2. VEMP6를 통한 INSERT 성공 확인 후 ROLLBACK;


--3. VEMP1을 통한 차장 직급 전부 삭제 후 성공여부 확인 및 ROLLBACK;


--5. VEMP1을 WITH CHECK OPTION 으로 REPLACE



--4]
--1. VEMP1의 모든 DATA 차장으로 UPDATE 수행 후 성공여부 확인


--2. VEMP1을 WITH READ ONLY 옵션으로 변경 재 생성


--3. VEMP1에 과장 1건 INSERT 수행 후 성공여부 확인


--4. VEMP2 제거