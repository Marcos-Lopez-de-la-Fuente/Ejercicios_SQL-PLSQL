-- TABLES
CREATE TABLE Emple (
    Last_name VARCHAR2(20),
    Emp_no NUMBER(6),
    Fecha_alt DATE,
    Oficio VARCHAR2(20),
    Salario NUMBER(6),

    CONSTRAINT PK_Emple PRIMARY KEY (emp_no)
);
INSERT INTO Emple VALUES ('a', 1, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'PRESIDENTE', 4500);
INSERT INTO Emple VALUES ('b', 2, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'DIRECTOR', 3500);
INSERT INTO Emple VALUES ('bb', 3, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'DIRECTOR', 3100);
INSERT INTO Emple VALUES ('c', 4, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'ANALISTA', 2100);
INSERT INTO Emple VALUES ('cc', 5, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'ANALISTA', 2200);
INSERT INTO Emple VALUES ('ccc', 6, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'ANALISTA', 2300);
INSERT INTO Emple VALUES ('cccc', 7, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'ANALISTA', 2400);
INSERT INTO Emple VALUES ('d', 8, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'VENDEDOR', 1400);
INSERT INTO Emple VALUES ('dd', 9, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'VENDEDOR', 1500);
INSERT INTO Emple VALUES ('ddd', 10, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'VENDEDOR', 1600);
INSERT INTO Emple VALUES ('dddd', 11, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'VENDEDOR', 1700);
INSERT INTO Emple VALUES ('e', 12, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'EMPLEADO', 1100);
INSERT INTO Emple VALUES ('ee', 13, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'EMPLEADO', 1200);
INSERT INTO Emple VALUES ('eee', 14, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'EMPLEADO', 1300);
INSERT INTO Emple VALUES ('eeee', 15, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'EMPLEADO', 1400);



-- 22.
CREATE OR REPLACE PROCEDURE adjust_salary(IN_EMPLOYEE_ID IN NUMBER, IN_PERCENT IN NUMBER) AS
BEGIN
    UPDATE Emple SET
    Salario = Salario + Salario * IN_PERCENT / 100
    WHERE Emp_no = IN_EMPLOYEE_ID;
END;
/


-- 23.
EXECUTE adjust_salary(1, 10);
SELECT Emp_no, Salario FROM Emple WHERE Emp_no = 1;


-- 24.
CREATE OR REPLACE PROCEDURE search(num1 IN NUMBER, num2 IN NUMBER, num3 OUT NUMBER) AS
BEGIN
    IF num1 > num2 THEN
        num3 := num2;
    ELSE
        num3 := num1;
    END IF;
END;
/

DECLARE
    num1 NUMBER := 30;
    num2 NUMBER := 40;
    num3 NUMBER;
BEGIN
    search(num1,num2,num3);
    DBMS_OUTPUT.PUT_LINE('The minimum of (' || num1 || ', ' || num2 || ') is: ' || num3);
END;
/


-- 25.
<<outer_loop>>
DECLARE
    var NUMBER := 0;
BEGIN

    LOOP
        <<inner_loop>>
        DECLARE
            var number := 0;
        BEGIN
            LOOP

                DBMS_OUTPUT.PUT_LINE(outer_loop.var || ' ' || inner_loop.var);
                inner_loop.var := inner_loop.var + 1;

                EXIT WHEN inner_loop.var = 6;
            END LOOP;
        END;
        outer_loop.var := outer_loop.var + 1;

        EXIT WHEN outer_loop.var = 3;
    END LOOP;
END;