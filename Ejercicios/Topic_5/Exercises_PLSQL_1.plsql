-- TABLES
CREATE TABLE TAXPAYER (
    COD_PAYER VARCHAR2(4) PRIMARY KEY,
    NAME VARCHAR2(15),
    NIF VARCHAR2(9) NOT NULL
);
CREATE TABLE LANDREGISTRY (
    REFERENCE NUMBER(3) PRIMARY KEY,
    STR_TYPE VARCHAR2(2) CONSTRAINT CRTL_STRTYPE CHECK(STR_TYPE IN ('AV','ST','SQ')),
    STREET VARCHAR(20) NOT NULL,
    STR_NUMBER NUMBER(4) CONSTRAINT CRTL_STRNUM CHECK(STR_NUMBER BETWEEN 1 AND 2000),
    POST_CODE NUMBER(5) CONSTRAINT CTRL_POST CHECK(POST_CODE BETWEEN 07000 AND 07999),
    VALUE NUMBER(9) CONSTRAINT CRTL_VALUE CHECK(VALUE>0),
    TAX_RATE NUMBER(2) CONSTRAINT CRTL_TAXRATE CHECK(TAX_RATE BETWEEN 2 AND 6)
);
CREATE TABLE ESTATE_OWNER (
    PAYER VARCHAR2(4),
    ESTATE NUMBER(3),
    PRIMARY KEY(PAYER, ESTATE),
    FOREIGN KEY (ESTATE) REFERENCES LANDREGISTRY(REFERENCE),
    FOREIGN KEY (PAYER) REFERENCES TAXPAYER(COD_PAYER)
);

CREATE TABLE Department (
    Department_Code VARCHAR(2) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    City VARCHAR(20) NOT NULL,
    CONSTRAINT Department_PK PRIMARY KEY (Department_Code)
);
CREATE TABLE Staff (
    Employee_Code VARCHAR(4) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Job VARCHAR(30),
    Salary NUMBER,
    Department_Code VARCHAR(2),
    Start_Date DATE,
    CONSTRAINT Staff_PK PRIMARY KEY (Employee_Code),
    CONSTRAINT Department_FK FOREIGN KEY (Department_Code) REFERENCES Department(Department_Code)
);

CREATE TABLE factorial (
    num NUMBER(2),
    fact NUMBER(8)
);


-- INSERTS
INSERT INTO TAXPAYER VALUES ('A368','ZAMBRANA','21651220X');
INSERT INTO TAXPAYER VALUES ('B413','TORANDELL','62760601T');
INSERT INTO TAXPAYER VALUES ('B545','SANCHEZ','85801101P');
INSERT INTO TAXPAYER VALUES ('C552','RODRIGUEZ','19851015B');
INSERT INTO TAXPAYER VALUES ('D663','POAQUIZA','02820201F');
INSERT INTO TAXPAYER VALUES ('D765','OTERO','39770601K');
INSERT INTO TAXPAYER VALUES ('F998','ORTIZ','49900101P');
INSERT INTO TAXPAYER VALUES ('F003','NEGRE','92741201R');
INSERT INTO TAXPAYER VALUES ('H008','MULET','26720515A');
INSERT INTO TAXPAYER VALUES ('L087','MARCOS','38900201H');
INSERT INTO TAXPAYER VALUES ('M190','LOPEZ','43680901U');
INSERT INTO TAXPAYER VALUES ('M820','LLULL','38900201H');
INSERT INTO TAXPAYER VALUES ('M617','LIN','43680901U');
INSERT INTO LANDREGISTRY VALUES (384,'AV','TIGRE',198,07023,33000000,4);
INSERT INTO LANDREGISTRY VALUES (273,'AV','LION',25,07403,25000000,5);
INSERT INTO LANDREGISTRY VALUES (105,'AV','CHEETAH',86,07036,36000000,4);
INSERT INTO LANDREGISTRY VALUES (386,'AV','TIGRE',190,07023,21000000,4);
INSERT INTO LANDREGISTRY VALUES (201,'AV','LION',13,07403,30000000,5);
INSERT INTO LANDREGISTRY VALUES (244,'AV','CHEETAH',8,07036,13000000,4);
INSERT INTO LANDREGISTRY VALUES (014,'ST','WORM',25,07123,17000000,3);
INSERT INTO LANDREGISTRY VALUES (419,'ST','BUTERFLY',7,07060,12000000,2);
INSERT INTO LANDREGISTRY VALUES (011,'ST','WORM',3,07123,10000000,3);
INSERT INTO LANDREGISTRY VALUES (825,'ST','BEDBUG',104,07201,9000000,2);
INSERT INTO LANDREGISTRY VALUES (217,'ST','BEETLE',16,07199,13000000,3);
INSERT INTO LANDREGISTRY VALUES (404,'ST','BEDBUG',57,07201,11000000,2);
INSERT INTO LANDREGISTRY VALUES (823,'ST','SPIDER',42,07666,27000000,3);
INSERT INTO LANDREGISTRY VALUES (017,'ST','WORM',32,07123,9000000,3);
INSERT INTO LANDREGISTRY VALUES (015,'ST','BUTERFLY',35,07060,8000000,2);
INSERT INTO LANDREGISTRY VALUES (114,NULL,'OCTOPUS',13,07023,16000000,3);
INSERT INTO LANDREGISTRY VALUES (003,NULL,'SQUID',25,07036,12000000,3);
INSERT INTO LANDREGISTRY VALUES (965,'SQ','PARIS',NULL,07943,30000000,2);
INSERT INTO LANDREGISTRY VALUES (057,'SQ','LONDON',NULL,07932,34000000,2);
INSERT INTO ESTATE_OWNER VALUES ('A368',384);
INSERT INTO ESTATE_OWNER VALUES ('B413',273);
INSERT INTO ESTATE_OWNER VALUES ('B545',105);
INSERT INTO ESTATE_OWNER VALUES ('C552',386);
INSERT INTO ESTATE_OWNER VALUES ('D663',201);
INSERT INTO ESTATE_OWNER VALUES ('D765',244);
INSERT INTO ESTATE_OWNER VALUES ('A368',014);
INSERT INTO ESTATE_OWNER VALUES ('B545',419);
INSERT INTO ESTATE_OWNER VALUES ('D663',011);
INSERT INTO ESTATE_OWNER VALUES ('F998',825);
INSERT INTO ESTATE_OWNER VALUES ('F003',217);
INSERT INTO ESTATE_OWNER VALUES ('H008',404);
INSERT INTO ESTATE_OWNER VALUES ('L087',823);
INSERT INTO ESTATE_OWNER VALUES ('M190',017);
INSERT INTO ESTATE_OWNER VALUES ('M617',015);
INSERT INTO ESTATE_OWNER VALUES ('B413',114);
INSERT INTO ESTATE_OWNER VALUES ('F003',003);
INSERT INTO ESTATE_OWNER VALUES ('B545',965);
INSERT INTO ESTATE_OWNER VALUES ('L087',057);

INSERT INTO Department VALUES ('12','Direction','Palma');
INSERT INTO Department VALUES ('05','Analysis','Barcelona');
INSERT INTO Department VALUES ('08','Programming','Mao');
INSERT INTO Department VALUES ('10','Control','Eivissa');


-- 1.
ALTER TABLE factorial ADD (
    square NUMBER(5),
    root NUMBER(8,5)
);

DECLARE
    n NUMBER(2);
    f NUMBER(8);
    s NUMBER(5);
    r NUMBER (8,5);
BEGIN
    n:=1;
    f:=1;
    FOR n IN 1..10 LOOP
        f:=f*n;
        s:=n**2;
        r:=n**0.5;
        INSERT INTO factorial VALUES (n,f,s,r);
    END LOOP;
END;
/


-- 2.
CREATE OR REPLACE FUNCTION CountEmpl (name_job IN VARCHAR) RETURN NUMBER IS
    quantity NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO quantity
    FROM Staff
    WHERE Job = name_job;
    RETURN(quantity);
END;
/
SELECT CountEmpl('Programador') from dual;


-- 3.
CREATE OR REPLACE PROCEDURE process (valor IN NUMBER) AS
tax NUMBER(2);
BEGIN
    UPDATE LANDREGISTRY
    SET TAX_RATE = TAX_RATE + 1
    WHERE TAX_RATE < valor AND TAX_RATE < 6;
END;
/
EXECUTE process(4);


-- 4.
CREATE OR REPLACE FUNCTION CountCity (Staff_city IN VARCHAR) RETURN NUMBER IS
    quantity NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO quantity
    FROM Staff s
    INNER JOIN Department d ON s.Department_Code = d.Department_Code
    WHERE d.City = Staff_city;
    RETURN(quantity);
END;
/
SELECT CountCity('Barcelona') from dual;


-- 5.
CREATE OR REPLACE PROCEDURE camb AS
BEGIN
    UPDATE Staff SET
    Job = 'Project Manager',
    Department_Code = '10'
    WHERE Job = 'analyst' AND Start_Date = (
        SELECT Start_Date
        FROM Staff
        WHERE Job = 'analyst'
        GROUP BY Start_Date
        HAVING COUNT(Start_Date) < 2
        ORDER BY Start_Date
        FETCH FIRST 1 ROWS ONLY
    );
END;
/
EXECUTE camb;


-- 6.
CREATE OR REPLACE PROCEDURE aum(dep IN VARCHAR) AS
BEGIN
    UPDATE Staff SET
    Salary = Salary * 1.01
    WHERE Department_Code = dep;
END;
/
EXECUTE aum('05');


-- 7.
ALTER TABLE TAXPAYER ADD (
    houses NUMBER
);

CREATE OR REPLACE PROCEDURE houses AS
    quantity NUMBER;
BEGIN
    UPDATE TAXPAYER SET
    houses = (
        SELECT COUNT(*)
        FROM ESTATE_OWNER
        WHERE PAYER = COD_PAYER
    );
END;
/
EXECUTE houses;
