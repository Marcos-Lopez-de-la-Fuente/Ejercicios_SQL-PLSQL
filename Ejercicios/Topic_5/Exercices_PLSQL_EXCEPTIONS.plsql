DROP TABLE Players;
DROP TABLE Statistics;
DROP TABLE Calendar;
DROP TABLE Clubs;
-- CREATES TABLES
CREATE TABLE Clubs (
    Team_Name varchar(20) NOT NULL,
    Stadium_Name varchar(20),
    Capacity number,
    Community number,
    Foundation date,

    CONSTRAINT Clubs_PK PRIMARY KEY (Team_Name)
);
CREATE TABLE Statistics (
    Name varchar(30) NOT NULL,
    Goals number,
    Matches number,
    Minutes number,
    Yellow_Cards number,
    Red_Cards number,

    CONSTRAINT Statistics_PK PRIMARY KEY (Name)
);

CREATE TABLE Calendar (
    Date_Match date NOT NULL,
    Local_Team varchar(30) NOT NULL,
    Foreign_Team varchar(30) NOT NULL,
    Local_Goals number,
    Foreign_Goals number,

    CONSTRAINT Calendar_PK PRIMARY KEY (Date_Match, Local_Team, Foreign_Team),
    CONSTRAINT Local_Team_FK FOREIGN KEY (Local_Team) REFERENCES Clubs(Team_Name),
    CONSTRAINT Foreign_Team_FK FOREIGN KEY (Foreign_Team) REFERENCES Clubs(Team_Name)
);
CREATE TABLE Players (
    Name varchar(30) NOT NULL,
    Club varchar(20) NOT NULL,
    Date_of_Birth date ,
    Weight number(5,2),
    Number_Team number(2),
    Position varchar(20),

    CONSTRAINT Players_PK PRIMARY KEY (Club, Number_Team),
    CONSTRAINT Club_FK FOREIGN KEY (Club) REFERENCES Clubs(Team_Name),
    CONSTRAINT Name_FK FOREIGN KEY (Name) REFERENCES Statistics(Name)
);


INSERT INTO Clubs
(Team_Name, Stadium_Name, Capacity, Community, Foundation)
VALUES
('Madrid','Estadio1', 10000, 9000, SYSDATE);

INSERT INTO Clubs
(Team_Name, Stadium_Name, Capacity, Community, Foundation)
VALUES
('Barcelona', 'Estadio2', 9000, 12000, SYSDATE);

INSERT INTO Clubs
(Team_Name, Stadium_Name, Capacity, Community, Foundation)
VALUES
('Mallorca', 'Estadio3', 11000, 14000, SYSDATE);

INSERT INTO Clubs
(Team_Name, Stadium_Name, Capacity, Community, Foundation)
VALUES
('Baleares', 'Estadio4', 15000, 10000, SYSDATE);

INSERT INTO Clubs
(Team_Name, Stadium_Name, Capacity, Community, Foundation)
VALUES
('Sevilla', 'Estadio5', 5000, 5000, SYSDATE);

INSERT INTO Calendar VALUES (SYSDATE, 'Madrid', 'Barcelona', 2, 7);
INSERT INTO Calendar VALUES (SYSDATE, 'Barcelona', 'Madrid', 5, 1);
INSERT INTO Calendar VALUES (SYSDATE, 'Mallorca', 'Madrid', 5, 1);
INSERT INTO Calendar VALUES (SYSDATE, 'Madrid', 'Mallorca', 5, 1);
INSERT INTO Calendar VALUES (SYSDATE, 'Barcelona', 'Mallorca', 5, 1);
INSERT INTO Calendar VALUES (SYSDATE, 'Sevilla', 'Baleares', 5, 1);

INSERT INTO Statistics VALUES ('Marcos', 43, 12, 65, 4, 2);
INSERT INTO Statistics VALUES ('Pepe', 43, 12, 65, 4, 2);
INSERT INTO Statistics VALUES ('Ana', 43, 12, 65, 4, 2);
INSERT INTO Statistics VALUES ('Jose', 43, 12, 65, 4, 2);
INSERT INTO Statistics VALUES ('Pepa', 43, 12, 65, 4, 2);
INSERT INTO Statistics VALUES ('Maria', 43, 12, 65, 4, 2);
INSERT INTO Statistics VALUES ('Juan', 43, 12, 65, 4, 2);

INSERT INTO Players VALUES ('Marcos', 'Madrid', SYSDATE, 43, 15, 'AAAA');
INSERT INTO Players VALUES ('Pepe', 'Mallorca', SYSDATE, 43, 11, 'AAAA');
INSERT INTO Players VALUES ('Ana', 'Barcelona', SYSDATE, 43, 17, 'AAAA');
INSERT INTO Players VALUES ('Jose', 'Sevilla', SYSDATE, 43, 10, 'AAAA');
INSERT INTO Players VALUES ('Pepa', 'Madrid', SYSDATE, 43, 5, 'AAAA');
INSERT INTO Players VALUES ('Maria', 'Mallorca', SYSDATE, 43, 22, 'AAAA');
INSERT INTO Players VALUES ('Juan', 'Madrid', SYSDATE, 43, 32, 'AAAA');

-----------------------------------------------------------------------------------------

-- 1.
CREATE OR REPLACE PROCEDURE reportChanges AS
    CURSOR c1 IS SELECT * FROM Clubs;
    c11 c1%ROWTYPE;
BEGIN
    FOR c11 IN c1 LOOP
        DBMS_OUTPUT.PUT_LINE(c11.Team_Name||'  '||c11.Stadium_Name||'  '||c11.Capacity);
    END LOOP;
EXCEPTION
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('The program attempts an illegal cursor operation, such as closing an unopened cursor.');
    WHEN CURSOR_ALREADY_OPEN THEN
        DBMS_OUTPUT.PUT_LINE('Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE changeCapacity AS
    CURSOR c1 IS
        SELECT * FROM Clubs
        FOR UPDATE OF Team_Name;
    c11 c1%ROWTYPE;
    newCapacity NUMBER;
    capacityUnder EXCEPTION;
BEGIN
    FOR c11 IN c1 LOOP
        newCapacity := ROUND(c11.Community * 1.3, 0);
        BEGIN
            IF newCapacity < 10000 THEN
                RAISE capacityUnder;
            END IF;
            UPDATE Clubs
            SET Capacity = newCapacity
            WHERE CURRENT OF c1;
        EXCEPTION
            WHEN capacityUnder THEN
                newCapacity := 10000;
                UPDATE Clubs
                SET Capacity = newCapacity
                WHERE CURRENT OF c1;
        END;
    END LOOP;
    reportChanges;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Cannot be divided by 0');
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('The program attempts an illegal cursor operation, such as closing an unopened cursor.');
    WHEN CURSOR_ALREADY_OPEN THEN
        DBMS_OUTPUT.PUT_LINE('Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/
EXECUTE changeCapacity;

--====================================================================================================================================

-- 2.
CREATE OR REPLACE PROCEDURE deleteStatistics(varName IN VARCHAR) AS
    CURSOR c1 IS
        SELECT * FROM Statistics
        WHERE Name = varName
        FOR UPDATE OF Name;
    c11 c1%ROWTYPE;
BEGIN
    FOR c11 IN c1 LOOP
        DELETE FROM Statistics
        WHERE CURRENT OF c1;
    END LOOP;
EXCEPTION
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('The program attempts an illegal cursor operation, such as closing an unopened cursor.');
    WHEN CURSOR_ALREADY_OPEN THEN
        DBMS_OUTPUT.PUT_LINE('Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE deletePlayer(varClub IN VARCHAR) AS
    CURSOR c1 IS
        SELECT * FROM Players
        WHERE Club = varClub
        FOR UPDATE OF Club;
    c11 c1%ROWTYPE;
BEGIN
    FOR c11 IN c1 LOOP
        DELETE FROM Players
        WHERE CURRENT OF c1;
        deleteStatistics(c11.Name);
    END LOOP;
EXCEPTION
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('The program attempts an illegal cursor operation, such as closing an unopened cursor.');
    WHEN CURSOR_ALREADY_OPEN THEN
        DBMS_OUTPUT.PUT_LINE('Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE deleteCalendar(varClub IN VARCHAR) AS
    CURSOR c1 IS
        SELECT * FROM Calendar
        WHERE Local_Team = varClub OR Foreign_Team = varClub
        FOR UPDATE OF Local_Team, Foreign_Team;
    c11 c1%ROWTYPE;
BEGIN
    FOR c11 IN c1 LOOP
        DELETE FROM Calendar
        WHERE CURRENT OF c1;
    END LOOP;
EXCEPTION
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('The program attempts an illegal cursor operation, such as closing an unopened cursor.');
    WHEN CURSOR_ALREADY_OPEN THEN
        DBMS_OUTPUT.PUT_LINE('Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE deleteTeam(varTeamName IN VARCHAR) AS
    CURSOR c1 IS
        SELECT * FROM Clubs
        WHERE Team_Name = varTeamName
        FOR UPDATE OF Team_Name;
    c11 c1%ROWTYPE;
BEGIN
    FOR c11 IN c1 LOOP
        deletePlayer(c11.Team_Name);
        deleteCalendar(c11.Team_Name);
        DELETE FROM Clubs
        WHERE CURRENT OF c1;
    END LOOP;
EXCEPTION
    WHEN INVALID_CURSOR THEN
        DBMS_OUTPUT.PUT_LINE('The program attempts an illegal cursor operation, such as closing an unopened cursor.');
    WHEN CURSOR_ALREADY_OPEN THEN
        DBMS_OUTPUT.PUT_LINE('Your program attempts to open an already open cursor. A cursor must be closed before it can be reopened.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/
SELECT * FROM Clubs;
SELECT * FROM Statistics;
SELECT * FROM Calendar;
SELECT * FROM Players;
EXECUTE deleteTeam('Madrid');
SELECT * FROM Clubs;
SELECT * FROM Statistics;
SELECT * FROM Calendar;
SELECT * FROM Players;


--3.
CREATE OR REPLACE PROCEDURE listStaff AS
    CURSOR c1 IS SELECT * FROM Staff;
    c11 c1%ROWTYPE;
    withoutSupervisor EXCEPTION;
    withSupervisor EXCEPTION;
BEGIN
    FOR c11 IN c1 LOOP
        BEGIN
            BEGIN
                IF c11.Superior_Officer IS NULL THEN
                    RAISE withoutSupervisor;
                ELSE
                    RAISE withSupervisor;
                END IF;
            EXCEPTION
                WHEN withoutSupervisor THEN
                    RAISE_APPLICATION_ERROR(-20000,'Without supervisor');
                WHEN withSupervisor THEN
                    RAISE_APPLICATION_ERROR(-20001,'With supervisor');
            END;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(c11.Name||'   '||SQLCODE||'   '||SQLERRM);
        END;
    END LOOP;
END;
/
EXECUTE listStaff;

--4.
CREATE OR REPLACE PROCEDURE insertNewStaff
(Employee_Code IN VARCHAR,Name IN VARCHAR,Job IN VARCHAR,Salary IN NUMBER,IDepartment_Code IN VARCHAR,Start_Date IN DATE, ISupperior_Officer IN VARCHAR) AS
    varDepartment_Code VARCHAR(2);
    varSuperior VARCHAR(4);
    noExistDepartment EXCEPTION;
    noExistSuperior EXCEPTION;
BEGIN
    SELECT (
        SELECT Department_Code FROM Department
        WHERE Department_Code = IDepartment_Code
    )
    INTO varDepartment_Code
    FROM dual;
    SELECT (
        SELECT Employee_Code FROM Staff
        WHERE Employee_Code = ISupperior_Officer
    )
    INTO varSuperior
    FROM dual;
    IF varDepartment_Code IS NULL THEN
        RAISE noExistDepartment;
    ELSIF varSuperior IS NULL THEN
        RAISE noExistSuperior;
    END IF;
    INSERT INTO STAFF VALUES
        (Employee_Code,Name,Job,Salary,IDepartment_Code,Start_Date,ISupperior_Officer);
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('The Employee_Code already exists, the INSERT has not been performed.');
    WHEN noExistDepartment THEN
        DBMS_OUTPUT.PUT_LINE('There is no department with that number, the INSERT has not been performed.');
    WHEN noExistSuperior THEN
        DBMS_OUTPUT.PUT_LINE('There is no superior with that number, the INSERT has not been performed.');
    WHEN PROGRAM_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has an internal problem.');
    WHEN STORAGE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('The program has run out of memory or the memory has been corrupted.');
    WHEN TIMEOUT_ON_RESOURCE THEN
        DBMS_OUTPUT.PUT_LINE('There has been a timeout, waiting for a resource.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLCODE||SQLERRM);
END;
/
EXECUTE insertNewStaff('0006', 'Marcos', 5000, '08', TO_DATE('23-05-2022','DD-MM-YYYY'), '0001');

--5.
DROP TABLE NewTable;

CREATE TABLE newTable (
    Name VARCHAR2(15),
    Property NUMBER(3),
    Street VARCHAR(20),
    Code NUMBER(5)
);

CREATE OR REPLACE PROCEDURE insertsNewTable(codeTaxPayer IN VARCHAR) AS
    CURSOR c1 IS
        SELECT T.Name Name, L.REFERENCE Reference, L.Street Street, L.Post_Code Postal_Code
        FROM Taxpayer T
        INNER JOIN Estate_Owner EO ON EO.PAYER = T.COD_PAYER
        INNER JOIN LandRegistry L ON L.REFERENCE = EO.Estate
        WHERE (T.COD_PAYER = codeTaxPayer);
    c11 c1%ROWTYPE;
    codePayer NUMBER;
    counter NUMBER := 0;
    counterPropertyRep NUMBER;
    noProperty EXCEPTION;
    noCodeExist EXCEPTION;
    propertyRep EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO codePayer FROM TAXPAYER WHERE COD_PAYER = codeTaxPayer;
    IF codePayer = 0 THEN RAISE noCodeExist; END IF;
    FOR c11 IN c1 LOOP
        BEGIN
            counter := counter + 1;
            SELECT COUNT(*) INTO counterPropertyRep FROM newTable WHERE Property = c11.Reference;
            IF counterPropertyRep != 0 THEN RAISE propertyRep; END IF;
            INSERT INTO newTable VALUES (c11.Name, c11.Reference, c11.Street, c11.Postal_Code);
            DBMS_OUTPUT.PUT_LINE('The '||c11.Reference||' property has been entered into the database.');
        EXCEPTION
            WHEN propertyRep THEN
                DBMS_OUTPUT.PUT_LINE('Property '||c11.Reference||' was already in the database.');
        END;
    END LOOP;
    IF counter = 0 THEN RAISE noProperty; END IF;
EXCEPTION
    WHEN noCodeExist THEN
        DBMS_OUTPUT.PUT_LINE('There is no one with that code.');
    WHEN noProperty THEN
        DBMS_OUTPUT.PUT_LINE('This person has no propertys.');
END;
/
EXECUTE insertsNewTable('A368');

