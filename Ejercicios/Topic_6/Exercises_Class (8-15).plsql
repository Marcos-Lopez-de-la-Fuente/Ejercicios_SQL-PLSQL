-- Practice 8
-- Function
CREATE OR REPLACE FUNCTION try_parse (iv_number IN VARCHAR2) RETURN NUMBER IS
BEGIN
    RETURN to_number(iv_number);
    EXCEPTION
        WHEN others THEN
            RETURN NULL;
END;
/

DECLARE
    numero NUMBER;
BEGIN
    numero := try_parse('1234');
    DBMS_OUTPUT.PUT_LINE(numero);
END;
/


-- Practice 9
-- Support table for the next internships
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
-- Function
CREATE OR REPLACE FUNCTION count_employees RETURN NUMBER IS
numero_empleados NUMBER;
BEGIN
    SELECT COUNT(*) INTO numero_empleados FROM Emple;
    RETURN numero_empleados;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(count_employees());
END;
/


-- Practice 10
-- Table
CREATE TABLE Jobs (
    JOB_ID NUMBER,
    JOB VARCHAR2(20),
    MIN_SALARY NUMBER,
    MAX_SALARY NUMBER,
    CONSTRAINT PK_Jobs PRIMARY KEY (JOB_ID)
);
-- Inserts
INSERT INTO Jobs VALUES (1, 'PRESIDENTE', 4000, 5000);
INSERT INTO Jobs VALUES (2, 'DIRECTOR', 3000, 4000);
INSERT INTO Jobs VALUES (3, 'ANALISTA', 2000, 3500);
INSERT INTO Jobs VALUES (4, 'VENDEDOR', 1300, 5000);
INSERT INTO Jobs VALUES (5, 'EMPLEADO', 1000, 2000);

-- Program
DECLARE
    n_min_salary NUMBER;
    n_max_salary NUMBER;
    n_mid_salary NUMBER;
    n_Salary Emple.Salario%TYPE;
    n_emp_id Emple.Emp_no%TYPE;
BEGIN
    -- I set the values of the variables using the columns
    SELECT Jobs.MIN_SALARY, Jobs.MAX_SALARY, Emple.Emp_no, Emple.Salario
    INTO n_min_salary, n_max_salary, n_emp_id, n_Salary
    FROM Jobs
    -- I use an INNER JOIN to link them and check that it's always the same job
    INNER JOIN Emple ON Jobs.JOB = Emple.Oficio
    -- Through the WHERE I will choose the employee I want to review
    WHERE Emple.Emp_no = 5;

    -- I set the value of the variable
    n_mid_salary := (n_min_salary + n_max_salary) / 2;

    -- If the employee's salary is less than the "mid" salary
    IF n_Salary < n_mid_salary THEN
        -- I change the employee's salary to the 'mid' salary
        UPDATE Emple SET Salario = n_mid_salary WHERE Emp_no = n_emp_id;
        DBMS_OUTPUT.PUT_LINE('Changes made.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Your salary is correct.');
    END IF;
    COMMIT;
END;
/


-- Practice 11
DECLARE
    n_min_salary NUMBER;
    n_max_salary NUMBER;
    n_mid_salary NUMBER;
    n_Salary Emple.Salario%TYPE;
    n_emp_id Emple.Emp_no%TYPE;
BEGIN
    SELECT Jobs.MIN_SALARY, Jobs.MAX_SALARY, Emple.Emp_no, Emple.Salario
    INTO n_min_salary, n_max_salary, n_emp_id, n_Salary
    FROM Jobs
    INNER JOIN Emple ON Jobs.JOB = Emple.Oficio
    WHERE Emple.Emp_no = 3;

    n_mid_salary := (n_min_salary + n_max_salary) / 2;

    IF n_Salary < n_mid_salary THEN
        UPDATE Emple SET Salario = n_mid_salary WHERE Emp_no = n_emp_id;
    ELSE
        UPDATE Emple SET Salario = Salario * 1.05 WHERE Emp_no = n_emp_id;
    END IF;
END;
/


-- Practice 12
DECLARE
    n_min_salary NUMBER;
    n_max_salary NUMBER;
    n_mid_salary NUMBER;
    n_Salary Emple.Salario%TYPE;
    n_emp_id Emple.Emp_no%TYPE;
BEGIN
    SELECT Jobs.MIN_SALARY, Jobs.MAX_SALARY, Emple.Emp_no, Emple.Salario
    INTO n_min_salary, n_max_salary, n_emp_id, n_Salary
    FROM Jobs
    INNER JOIN Emple ON Jobs.JOB = Emple.Oficio
    WHERE Emple.Emp_no = 4;

    n_mid_salary := (n_min_salary + n_max_salary) / 2;

    IF n_Salary < n_mid_salary THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || n_emp_id || ' has salary ' || n_Salary || '€ lower than mid-range ' || n_mid_salary || '€');
    ELSIF n_Salary = n_mid_salary THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || n_emp_id || ' has salary ' || n_Salary || '€ equal than mid-range ' || n_mid_salary || '€');
    ELSIF n_Salary > n_mid_salary THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || n_emp_id || ' has salary ' || n_Salary || '€ upper than mid-range ' || n_mid_salary || '€');
    END IF;
END;
/


-- Practice 13
-- Function
CREATE OR REPLACE FUNCTION find_max (num1 IN NUMBER, num2 IN NUMBER) RETURN NUMBER IS
resultado number;
BEGIN
    IF num1 > num2 THEN
        resultado := num1;
    ELSE
        resultado := num2;
    END IF;
    RETURN resultado;
END;
/

-- Program
DECLARE
    num1 NUMBER := 5;
    num2 NUMBER := 7;
    resultado NUMBER := find_max(num1, num2);
BEGIN
    DBMS_OUTPUT.PUT_LINE(resultado);
END;
/

-- Practice 14
-- Table
CREATE TABLE Employee (
    Employee_ID NUMBER,
    Commission NUMBER,
    Salary NUMBER,
    CONSTRAINT PK_Employee PRIMARY KEY (Employee_ID)
);
-- Inserts
INSERT INTO Employee VALUES (1, 350, 350);
INSERT INTO Employee VALUES (2, 460, 460);
INSERT INTO Employee VALUES (3, 500, 500);
INSERT INTO Employee VALUES (4, 632, 632);

-- Program
DECLARE
    Employee_code NUMBER;
    Employee_comission NUMBER;
BEGIN
    SELECT Employee_ID, Commission
    INTO Employee_code, Employee_comission
    FROM Employee
    WHERE Employee_ID = 1;

    CASE
        WHEN Employee_comission < 400 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' commission ' || Employee_comission || ' which is Low');
        WHEN Employee_comission = 500 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' commission ' || Employee_comission || ' which is Fair');
        WHEN Employee_comission >= 400 AND Employee_comission < 600 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' commission ' || Employee_comission || ' which is Middle');
        WHEN Employee_comission >= 600 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' commission ' || Employee_comission || ' which is High');
    END CASE;
END;
/


-- Practice 15
DECLARE
    Employee_code NUMBER;
    Employee_salary NUMBER;
BEGIN
    SELECT Employee_ID, Salary
    INTO Employee_code, Employee_salary
    FROM Employee
    WHERE Employee_ID = 4;

    CASE
        WHEN Employee_salary < 400 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' salary ' || Employee_salary || ' is Low');
        WHEN Employee_salary = 500 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' salary ' || Employee_salary || ' is Fair');
        WHEN Employee_salary >= 400 AND Employee_salary < 600 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' salary ' || Employee_salary || ' is Middle');
        WHEN Employee_salary >= 600 THEN
            DBMS_OUTPUT.PUT_LINE('Employee ' || Employee_code || ' salary ' || Employee_salary || ' is High');
    END CASE;
END;
/