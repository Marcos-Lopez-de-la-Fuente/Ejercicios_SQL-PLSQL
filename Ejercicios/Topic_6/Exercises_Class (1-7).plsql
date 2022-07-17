-- Practice 1
SET SERVEROUTPUT ON SIZE 10000;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello');
END;
/

-- Practice 2
DECLARE
    first_name VARCHAR2(20);
    last_name VARCHAR2(20);
    id_employee NUMBER(6);
    hire_date DATE;
    expense BOOLEAN;
BEGIN
    NULL;
END;
/


-- Support table for the next internships
CREATE TABLE Emple (
    Last_name VARCHAR2(20),
    Emp_no NUMBER(6),
    Fecha_alt DATE,
    Oficio VARCHAR2(20),
    Salario NUMBER(6),

    CONSTRAINT PK_Emple PRIMARY KEY (emp_no)
);

-- Practice 3
DECLARE
    v_last_name Emple.Last_name%TYPE;
    n_employee_id Emple.Emp_no%TYPE;
    d_hire_date Emple.Fecha_alt%TYPE;
BEGIN
    NULL;
END;
/

-- Practice 4
DECLARE
    v_last_name Emple.Last_name%TYPE;
    n_employee_id Emple.Emp_no%TYPE;
    d_hire_date Emple.Fecha_alt%TYPE;
    v_job Emple.Oficio%TYPE;
    n_salary Emple.Salario%TYPE;
BEGIN
    v_last_name := 'López';
    n_employee_id := 9999;
    d_hire_date := TO_DATE('06/04/2022', 'DD/MM/YYYY');
    v_job := 'Electrician';
    n_salary := 20000;
    DBMS_OUTPUT.PUT_LINE(v_last_name);
    DBMS_OUTPUT.PUT_LINE(n_employee_id);
    DBMS_OUTPUT.PUT_LINE(d_hire_date);
    DBMS_OUTPUT.PUT_LINE(v_job);
    DBMS_OUTPUT.PUT_LINE(n_salary);
END;
/

-- Practice 5
DECLARE
    v_last_name Emple.Last_name%TYPE := 'López';
    n_employee_id Emple.Emp_no%TYPE := 9999;
    d_hire_date Emple.Fecha_alt%TYPE := TO_DATE('06/04/2022', 'DD/MM/YYYY');
    v_job Emple.Oficio%TYPE := 'Electrician';
    n_salary Emple.Salario%TYPE := 20000;
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_last_name);
    DBMS_OUTPUT.PUT_LINE(n_employee_id);
    DBMS_OUTPUT.PUT_LINE(d_hire_date);
    DBMS_OUTPUT.PUT_LINE(v_job);
    DBMS_OUTPUT.PUT_LINE(n_salary);
END;
/

-- Practice 6
-- Insert used for the activity
INSERT INTO Emple VALUES ('López', 9999, TO_DATE('06/04/2022', 'DD/MM/YYYY'), 'Electrician', 20000);

DECLARE
    v_last_name Emple.Last_name%TYPE;
    n_employee_id Emple.Emp_no%TYPE;
    d_hire_date Emple.Fecha_alt%TYPE;
    v_job Emple.Oficio%TYPE;
    n_salary Emple.Salario%TYPE;
BEGIN
    SELECT Last_name, Emp_no, Fecha_alt, Oficio, Salario
    INTO v_last_name, n_employee_id, d_hire_date, v_job, n_salary
    FROM Emple
    WHERE Emp_no = 9999;
    DBMS_OUTPUT.PUT_LINE(v_last_name);
    DBMS_OUTPUT.PUT_LINE(n_employee_id);
    DBMS_OUTPUT.PUT_LINE(d_hire_date);
    DBMS_OUTPUT.PUT_LINE(v_job);
    DBMS_OUTPUT.PUT_LINE(n_salary);
END;
/

-- Practice 7
DECLARE
    number_pc INTEGER := 40;
    pc_watts INTEGER := 250;
    hours_idle_per_day INTEGER := 24-12;
    days_on_per_year INTEGER := 300;

    total_kwh FLOAT := hours_idle_per_day * days_on_per_year * pc_watts * number_pc;

    -- I guess these exercises are from 2007, at that time "0.434" was the result of kgCO2/kWh, so we multiply with this number (In Spain)
    -- I got this information on page 28 of the following PDF: https://energia.gob.es/desarrollo/EficienciaEnergetica/RITE/Reconocidos/Reconocidos/Otros%20documentos/Factores_emision_CO2.pdf
    total_co2 FLOAT := total_kwh * 0.43;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Total kWh wasted = ' || total_kwh || ' kwh');

    -- As we have multiplied * 0.43, the value of the variable is in kg, we divide / 1000 to pass it to tons
    DBMS_OUTPUT.PUT_LINE('Total CO2 produced = ' || total_co2 / 1000 || ' tons per year');
END;
/