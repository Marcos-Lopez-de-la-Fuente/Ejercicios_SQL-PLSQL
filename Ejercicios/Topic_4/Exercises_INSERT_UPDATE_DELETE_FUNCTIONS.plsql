-- Exercises INSERT/UPDATE/DELETE (Staff and Department Table)

-- 1.
INSERT INTO Departments
(Department_code, Name, City)
VALUES
('11', Consulting, Ciutadella);

-- 2.
INSERT INTO Staff
(Employee_code, Name, Job, Salary, Department_code, Start_date)
VALUES
('1200', 'Marcos', 'Analyst', 3000, '05', '24-01-2022');

-- 3.
INSERT INTO Staff
(Employee_code, Name, Job, Salary, Department_code, Start_date)
VALUES
('1333', 'Mulet', 'Consultant', 5000, '11', '24-01-2022');

-- 4.
UPDATE Staff
SET Start_date = '24-01-2022'
WHERE Name LIKE 'Llull';

-- 5.
UPDATE Staff
SET Job = 'Programmer'
    Salary = Salary * 1,2
    Superior_officer = '1003'
WHERE Name LIKE 'Barceló';

-- 6.
UPDATE Staff
SET Salary = Salary * 1,06;

-- 7.
DELETE FROM Staff
WHERE Name = 'Lopez';

-- 8.
[English]
When the department code is that of Ibiza (10), it will be changed to that of Palma (12) and the salary will also be changed, 10% more than the average of salaries (6181) + 10% = 6799

[Spanish]
Cuando el código de departamento sea el de Ibiza (10), se cambiará por el de Palma (12) y también se cambiará el salario, un 10% más que la media de los salarios (6181) + 10% = 6799

-- 9.
UPDATE Staff
SET Salary = Salary * 1,1
WHERE Department_code = (
    SELECT Department_code
    FROM Staff
    group by Department_code
    order by count(*)
    limit 1
);

-- 10.
UPDATE Staff
SET Name = 'Alfonso'
WHERE Salary < 5000;

UPDATE Staff
SET Salary = Salary * 0,8;


---------------------------------------------------------------------------------


-- Exercises Selects-Functions (football players tables)

-- 1.
SELECT Name, Minutes, Goals, Red_cards
FROM Statistics
ORDER BY Goals;

-- 2.
SELECT Team_name, Foundation
FROM Club;

UPDATE Club
SET Foundation = 'Unknown foundation year'
WHERE Foundation = '1890';

-- 3.
SELECT Stadium_name, Team_name, ROUND(Capacity, -2)
FROM Club;

-- 4.
SELECT Team_name, Stadium_name, ABS(Capacity - AVG(Capacity))
FROM Club;

-- 5.
SELECT Team_name, Stadium_name
FROM Club
GROUP BY Community
ORDER BY count(*) DESC
limit 1;

-- 6.
SELECT COUNT(*)
FROM Club;

SELECT COUNT(*)
FROM Club
WHERE Foundation != 'NULL';

-- 7.
SELECT SUM(Yellow_cards), SUM(Red_cards), SUM(Goals)
FROM Statistics;

-- 8.
SELECT Team_name
FROM Club
WHERE Community > 5;

-- 9.
SELECT Name, Matches, Goals, MAX(Matches / Goals)
FROM Statistics;
