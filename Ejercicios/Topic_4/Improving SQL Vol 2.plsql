-- CREATE TABLEs
CREATE TABLE New_Departments (
	Code_New_Department int NOT NULL,
    Name_New_Department varchar(255) NOT NULL,
    Budget_New_Department real NOT NULL,
    CONSTRAINT PK_Code_New_Department PRIMARY KEY (Code_New_Department)
);

CREATE TABLE New_Employees (
	SSN_New_Employee int NOT NULL,
    Name_New_Employee varchar(255) NOT NULL,
    LastName_New_Employee varchar(255) NOT NULL,
    Code_New_Department int NOT NULL,
    CONSTRAINT PK_SSN_New_Employee PRIMARY KEY (SSN_New_Employee),
    CONSTRAINT FK_Code_New_Department FOREIGN KEY (Code_New_Department)
    REFERENCES New_Departments(Code_New_Department)
);

-- INSERTs
INSERT INTO New_Departments(Code_New_Department,Name_New_Department,Budget_New_Department) VALUES(14,'IT',65000);
INSERT INTO New_Departments(Code_New_Department,Name_New_Department,Budget_New_Department) VALUES(37,'Accounting',15000);
INSERT INTO New_Departments(Code_New_Department,Name_New_Department,Budget_New_Department) VALUES(59,'Human Resources',240000);
INSERT INTO New_Departments(Code_New_Department,Name_New_Department,Budget_New_Department) VALUES(77,'Research',55000);

INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('222364883','Carol','Smith',37);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('332154719','MaryAnne','Foster',14);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('546523478','John','Doe',59);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('631231482','David','Smith',77);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('845657246','Kumar','Swamy',14);

-- 1.
SELECT LastName_New_Employee
FROM New_Employees;

-- 2.
SELECT DISTINCT LastName_New_Employee
FROM New_Employees;

-- 3.
SELECT *
FROM New_Employees
WHERE LastName_New_Employee = "Smith";

-- 4.
SELECT *
FROM New_Employees
WHERE LastName_New_Employee = "Smith" or LastName_New_Employee = "Doe";

-- 5.
SELECT *
FROM New_Employees
WHERE Code_New_Department = 14;

-- 6.
SELECT *
FROM New_Employees
WHERE Code_New_Department = 37 or Code_New_Department = 77;

-- 7.
SELECT *
FROM New_Employees
WHERE LastName_New_Employee LIKE "S%";

-- 8.
SELECT SUM(Budget_New_Department)
FROM New_Departments;

-- 9.
SELECT New_Departments.Code_New_Department, Count(*)
FROM New_Departments
INNER JOIN New_Employees ON New_Departments.Code_New_Department = New_Employees.Code_New_Department
GROUP BY New_Departments.Code_New_Department;

-- 10.
SELECT *
FROM New_Employees
INNER JOIN New_Departments ON New_Employees.Code_New_Department = New_Departments.Code_New_Department;

-- 11.
SELECT New_Employees.Name_New_Employee, New_Employees.LastName_New_Employee, New_Departments.Name_New_Department, New_Departments.Budget_New_Department
FROM New_Employees
INNER JOIN New_Departments ON New_Employees.Code_New_Department = New_Departments.Code_New_Department;

-- 12.
SELECT New_Employees.Name_New_Employee, New_Employees.LastName_New_Employee
FROM New_Employees
INNER JOIN New_Departments ON New_Employees.Code_New_Department = New_Departments.Code_New_Department
WHERE Budget_New_Department > 60000;

-- 13.
SELECT Name_New_Department
FROM New_Departments
WHERE Budget_New_Department > (
    SELECT AVG(Budget_New_Department)
    FROM New_Departments
);

-- 14.
SELECT Name_New_Department
FROM New_Departments
INNER JOIN (
    SELECT New_Departments.Code_New_Department SegundaTabla, Count(*) Contador
    FROM New_Departments
    INNER JOIN New_Employees ON New_Departments.Code_New_Department = New_Employees.Code_New_Department
    GROUP BY New_Departments.Code_New_Department
) ON New_Departments.Code_New_Department = SegundaTabla
WHERE Contador > 2;

-- 15.
SELECT Name_New_Employee, LastName_New_Employee
FROM New_Employees
INNER JOIN New_Departments ON New_Employees.Code_New_Department = New_Departments.Code_New_Department
WHERE New_Departments.Budget_New_Department = (
    SELECT Budget
    FROM (
        SELECT Budget_New_Department Budget
        FROM New_Departments
        ORDER BY Budget_New_Department
        LIMIT 2
    )
    ORDER BY Budget DESC
    LIMIT 1
);

-- 16.
INSERT INTO New_Departments(Code_New_Department,Name_New_Department,Budget_New_Department) VALUES(11,'Quality Assurance',40000);
INSERT INTO New_Employees(SSN_New_Employee,Name_New_Employee,LastName_New_Employee,Code_New_Department) VALUES('847-21-9811','Mary','Moore',11);

-- 17.
UPDATE New_Departments
SET Budget_New_Department = Budget_New_Department * 0.9;

-- 18.
UPDATE New_Employees
SET Code_New_Department = 14
WHERE Code_New_Department = 77;

-- 19.
DELETE FROM New_Employees WHERE Code_New_Department = 14;

-- 20.
DELETE FROM New_Employees
WHERE code_New_Department = (
    SELECT Code_New_Department
    FROM New_Departments
    WHERE Budget_New_Department >= 60000
);

-- 21.
-- To remove all employees from the table
DELETE FROM New_Employees;

-- To delete the table
DROP TABLE New_Employees;