-- Exercises SELECT-2 (Table staff and department)

-- 1.
SELECT DISTINCT Job
FROM Staff;

-- 2.
SELECT Name, Job, Salary
FROM Staff
ORDER BY Job ASC;

-- 3.
SELECT Name, Job, Salary
FROM Staff
WHERE Salary > 4200
ORDER BY Salary DESC;

-- 4.
SELECT Name, Job, Salary, Department_code
FROM Staff
ORDER BY Department_code ASC, Salary DESC;

-- 5.
SELECT Name, City, Salary * 1.1
FROM Staff
INNER JOIN Department
ON Staff.Department_code=Department.Department_code;

-- 6.
SELECT Name, City, Salary * 1.1
FROM Staff
INNER JOIN Department
ON Staff.Department_code=Department.Department_code;
ORDER BY Job ASC, Salary ASC;

-- 7.
SELECT AVG(Salary) AVG_salary, MIN(Salary) MIN_salary, MAX(Salary) MAX_salary
FROM Staff;

-- 8.

-- I don't understand what you are asking me, my bad

-- 9.
SELECT AVG(Salary) AVG_salary, MIN(Salary) MIN_salary, MAX(Salary) MAX_salary, Job
FROM Staff
GROUP BY Job;

-- 10.
SELECT AVG(Salary) AVG_salary, MIN(Salary) MIN_salary, MAX(Salary) MAX_salary, Job
FROM Staff
GROUP BY Job
WHERE AVG_salary > (
    SELECT AVG(Salary)
    FROM Staff
);


---------------------------------------------------------------------------------


-- Exercise SELECT-1 (table players and clubs)

-- 1.
SELECT *
FROM Club;

-- 2.
SELECT Team_name, Foundation
FROM Club
ORDER BY Foundation ASC;

-- 3.
SELECT Stadium_name, Capacity, Community
FROM Club;

-- 4.
SELECT Name
FROM Players
WHERE Club LIKE 'Real Madrid';

-- 5.
SELECT Name
FROM Players
WHERE Number = 1;

-- 6.
SELECT Name, Matches, Goals
FROM Statistics
ORDER BY Goals DESC;

-- 7.
SELECT Stadium_name
FROM Club
WHERE Capacity > 50000;

-- 8.
SELECT Stadium_name
FROM Club
WHERE Foundation
BETWEEN '1900' AND '1949';

-- 9.
SELECT Name
FROM Players
WHERE Name LIKE 'R%';

-- 10.
SELECT Name, Goals
FROM Statistics
WHERE Goals >= 1 AND (Matches BETWEEN 20 AND 28)
ORDER BY Matches;

-- 11.
SELECT Name
FROM Statistics
WHERE Yellow_cards = 1 OR Yellow_cards = 3;

-- 12.
SELECT Foreign_team
FROM Calendar;
WHERE Local_team LIKE 'Real Madrid';

-- 13.
SELECT Name
FROM Players
WHERE Position = 'Forwards' OR Position = 'Defenders';

-- 14.
SELECT SUM(Yellow_cards) Yellow_Cards, SUM(Red_cards) Red_Cards
FROM Statistics, Players
WHERE Players.Club = 'Real Madrid';

-- 15.
SELECT Players.Name, Minutes
FROM Statistics, Players
WHERE Players.Club = 'Real Madrid';

-- 16.
SELECT Name, (2022 - Date_of_birth)
FROM Players;

-- 17.

-- 17.1.
    SELECT Team_name, Stadium_name
    FROM Club
    WHERE Capacity > 1000;

-- 17.2.
    SELECT Statistics.Goals, Players.Name, Players.Position
    FROM Players, Statistics
    WHERE Statistics.Goals < 21;

-- 17.3.
    SELECT Local_team, Local_goals, Foreign_team, Foreign_goals
    FROM Calendar
    WHERE Local_goals > 3 AND Foreign_goals < 2;
