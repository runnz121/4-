1. 뷰의 정의 
    뷰의 개념 테이블인 다른 VIEW을 기초로 한 가상의 테이블
    데이터를 저장하지 않고 질의 문자를 저장

2. 뷰의 정의
    1.데이터 접근제한
    2.복잡한 쿼리문을 간단하게 수행 가능
    3.데이터 독립성 제공
    4.같은 데이터에 대한 다양한 관점 제공

3. 뷰의 종류
    1 단순뷰
        1.오직 하나의 테이블에 데이터가 유래
        2.데이터 그룹 또는 함수 불포함
        3.뷰릍 통해 DML수행 가능

    2.복합뷰
        1.다중 테이블에서 데이터가 유래
        2.데이터 그룹 또는 함수를 포함
        3.뷰를 통한 DML을 항상 허용하지 않음


4. 뷰의 생성
    CREATE VIEW 이름
    AS SELECT * 
    FROM 테이블
    WHERE 조건

    뷰의 구조 및 이름 확인
    SELECT * 
    FROM USER_VIEWS;

    뷰의 수정
    CREATE OR REPLACE VIEW 이름 (컬럼)
            AS SELECT 
            FROM
            WHERE


    ALTER VIEW는 안됨!!


    복합뷰 = DML 수정 안됨
    단순뷰 = DML 수정 가능

    1. DELETE 수행 못함
        그룹함수
        GROUP BY절
        DISTINCT
        ROWNUM

    2. UPDATE를 수행할 수 없는 경우
        그룹함수
        GROUP BY절
        DISTICT
        ROWNUM
        표현식으로 정의

    4. INSERT를 수행할 수 없음
        그룹함수
        GROUP BY절
        DISTINCT
        ROWNUM
        표현식으로 정의
        선택되지 않은 NOT NULL이 기본테이블에 있는 경우

5. WITH CHECK OPTION
    뷰생성시 제시된 조건에 만족하는 값만 입력받을 수 있도록 뷰생성시 제서 조건옵션
    CREATE OR REPACE VIEW 이름
            AS SELECT * 
            FROM 테이블
            WHERE 조건
            WITH CHECK OPTION CONSTRAINT

6.DML 연산의 부정
    WITH READ ONLY 옵션으로 뷰를 생성하면 뷰에 대해 DML연산을 수행 불가능
    READ ONLY 뷰에 DML 수행 못함

7.DROP VIEW 뷰명

CREATE VIEW TEMP_VIEW1
    AS SELECT *
    FROM TEMP
    WHERE EMP_ID LIKE '2002%';
    
SELECT * FROM TEMP_VIEW1;
