-- CREATEs
CREATE TABLE Students (
	ID_Students varchar(3),
    Name_Students varchar(20),
    Surname_Students varchar(20),
    Mark_Students number(2,1),
    Size_high_school_Students int,

    CONSTRAINT PK_Students PRIMARY KEY (ID_Students)
);

CREATE TABLE Colleges (
    Name_Colleges varchar(15),
    State_Colleges varchar(2),
    Enrollment_Colleges int,

    CONSTRAINT PK_Colleges PRIMARY KEY (Name_Colleges)
);

CREATE TABLE Applies (
    sID_Applies varchar(3),
    College_Applies varchar(15),
    Major_Applies varchar(20),
    Decision_Applies varchar(1),

    CONSTRAINT PK_Applies PRIMARY KEY (sID_Applies,College_Applies,Major_Applies),
    CONSTRAINT FK_Students FOREIGN KEY (sID_Applies) REFERENCES Students(ID_Students),
    CONSTRAINT FK_Colleges FOREIGN KEY (College_Applies) REFERENCES Colleges(Name_Colleges)
);

-- INSERTs
INSERT INTO Students VALUES('123','Amy','Smith',3.9,1000);
INSERT INTO Students VALUES('234','Bob','Taylor',3.6,1500);
INSERT INTO Students VALUES('345','Craig','Davis',3.5,500);
INSERT INTO Students VALUES('456','Doris','Roberts',3.9,1000);
INSERT INTO Students VALUES('543','Craig','Wilder',3.4,2000);
INSERT INTO Students VALUES('567','Edward','Norton',2.9,2000);
INSERT INTO Students VALUES('654','Amy','Cooper',3.9,1000);
INSERT INTO Students VALUES('678','Fay','Laurence',3.8,200);
INSERT INTO Students VALUES('765','Jay','Farlong',2.9,1500);
INSERT INTO Students VALUES('789','Gary','Oldman',3.4,800);
INSERT INTO Students VALUES('876','Irene','Lopez',3.9,400);
INSERT INTO Students VALUES('987','Helen','Karlson',3.7,800);

INSERT INTO Colleges VALUES ('Berkeley', 'CA', 36000);
INSERT INTO Colleges VALUES ('Cornell', 'NY', 21000);
INSERT INTO Colleges VALUES ('MIT', 'MA', 10000);
INSERT INTO Colleges VALUES ('Stanford', 'CA', 15000);

INSERT INTO Applies VALUES ('123','Berkeley','CS','1');
INSERT INTO Applies VALUES ('123','Cornell','EE','1');
INSERT INTO Applies VALUES ('123','Stanford','CS','1');
INSERT INTO Applies VALUES ('123','Stanford','EE','0');
INSERT INTO Applies VALUES ('234','Berkeley','Biology','0');
INSERT INTO Applies VALUES ('345','Cornell','Bioengineering','0');
INSERT INTO Applies VALUES ('345','Cornell','CS','1');
INSERT INTO Applies VALUES ('345','Cornell','EE','0');
INSERT INTO Applies VALUES ('345','MIT','Bioengineering','1');
INSERT INTO Applies VALUES('543','MIT','CS','0');
INSERT INTO Applies VALUES('678','Stanford','History','1');
INSERT INTO Applies VALUES('765','Cornell','History','0');
INSERT INTO Applies VALUES('765','Cornell','Psychology','1');
INSERT INTO Applies VALUES('765','Stanford','History','1');
INSERT INTO Applies VALUES('876','MIT','Biology','1');
INSERT INTO Applies VALUES('876','MIT','Marine biology','0');
INSERT INTO Applies VALUES('876','Stanford','CS','0');
INSERT INTO Applies VALUES('987','Berkeley','CS','1');
INSERT INTO Applies VALUES('987','Stanford','CS','1');

-- 2.
SELECT ID_Students, Name_Students, Surname_Students, Mark_Students
FROM Students
WHERE Mark_Students > 3.6;

-- 3.
SELECT DISTINCT Students.Name_Students, Students.Surname_Students, Applies.Major_Applies
FROM Students
INNER JOIN Applies ON Students.ID_Students = Applies.sID_Applies
ORDER BY Students.Name_Students, Students.Surname_Students;

-- 4.
SELECT DISTINCT Students.Name_Students, Students.Surname_Students, Students.Mark_Students, Applies.Decision_Applies
FROM Students
INNER JOIN Applies ON Students.ID_Students = Applies.sID_Applies
WHERE Students.Size_high_school_Students < 1000 AND Applies.Major_Applies = "CS";

-- 5.
SELECT DISTINCT Colleges.Name_Colleges
FROM Colleges
INNER JOIN Applies ON Colleges.Name_Colleges = Applies.College_Applies
WHERE Colleges.Enrollment_Colleges > 20000 AND Applies.Major_Applies = "CS";

-- 6.
SELECT DISTINCT Students.Name_Students, Students.Surname_Students
FROM Students
INNER JOIN Applies ON Students.ID_Students = Applies.sID_Applies
WHERE Applies.Major_Applies LIKE "%bio%";

-- 7.
SELECT Name_Students, Surname_Students, (Mark_Students*10/5)
FROM Students;

-- 8.
SELECT Name_Students, Surname_Students, Mark_Students, (Mark_Students*10/5), (Mark_Students*(Size_high_school_Students/1000))
FROM Students;

-- 9.
SELECT AVG(Marks)
FROM (SELECT AVG(Mark_Students) Marks
    FROM Students
    INNER JOIN Applies ON Students.ID_Students = Applies.sID_Applies
    WHERE Major_Applies = 'CS'
    GROUP BY sID_Applies
);

-- 10.
SELECT MIN(Students.Mark_Students)
FROM Students
INNER JOIN Applies ON Students.ID_Students = Applies.sID_Applies
WHERE Applies.Major_Applies = 'CS';

-- 11.
SELECT *
FROM Colleges
WHERE Enrollment_Colleges > 15000;

-- 12.
SELECT COUNT(DISTINCT sID_Applies)
FROM Applies
WHERE College_Applies = "Cornell";

-- 13.
SELECT College_Applies, COUNT(College_Applies)
FROM Applies
GROUP BY College_Applies;

-- 15.
SELECT State_Colleges, SUM(Enrollment_Colleges)
FROM Colleges
GROUP BY State_Colleges;

-- 16.
SELECT MIN(Mark_Students) Minimum, MAX(Mark_Students) Maximum
FROM Students;

-- 17.
SELECT *
FROM Students
WHERE Mark_Students > (
    SELECT MIN(Mark_Students)
    FROM Students
) AND Mark_Students < (
    SELECT MAX(Mark_Students)
    FROM Students
);

-- 18.
SELECT Students.ID_Students, Students.Name_Students, Students.Surname_Students, COUNT(Applies.College_Applies)
FROM Applies
INNER JOIN Students ON Applies.sID_Applies = Students.ID_Students
GROUP BY Applies.sID_Applies
ORDER BY Students.Surname_Students, Students.Name_Students, Students.ID_Students;

-- 19.
SELECT Students.ID_Students, Students.Name_Students, Students.Surname_Students, COUNT(Applies.College_Applies) colleges_applied
FROM Applies
INNER JOIN Students ON Applies.sID_Applies = Students.ID_Students
GROUP BY Applies.sID_Applies
UNION
SELECT ID_Students, Name_Students, Surname_Students, 0 colleges_applied 
FROM Students
WHERE ID_Students NOT IN (
    SELECT Students.ID_Students
    FROM Applies
    INNER JOIN Students ON Applies.sID_Applies = Students.ID_Students
    GROUP BY Applies.sID_Applies
);

-- 20.
SELECT Students.ID_Students, Students.Name_Students, Students.Surname_Students, COUNT(Applies.College_Applies) colleges_applied
FROM Applies
INNER JOIN Students ON Applies.sID_Applies = Students.ID_Students
GROUP BY Applies.sID_Applies
UNION
SELECT ID_Students, Name_Students, Surname_Students, 0 colleges_applied 
FROM Students
WHERE ID_Students NOT IN (
    SELECT Students.ID_Students
    FROM Applies
    INNER JOIN Students ON Applies.sID_Applies = Students.ID_Students
    GROUP BY Applies.sID_Applies
)
ORDER BY Surname_Students, Name_Students, ID_Students;













-- 40.
INSERT INTO Colleges VALUES ('UIB', 'IB', 11500);

-- 41.
INSERT INTO Applies a (a.sID_Applies, a.College_Applies, a.Major_Applies)
SELECT s.ID_Students, 'UIB', 'IB'
FROM Students s
WHERE s.ID_Students NOT IN (
    SELECT aa.sID_Applies
    FROM Applies aa
);

-- 42.
INSERT INTO Applies 
SELECT s.ID_Students, 'UIB', 'EE', '1'
FROM Students s
INNER JOIN Applies a ON s.ID_Students = a.sID_Applies
WHERE a.College_Applies != 'UIB' AND (a.Major_Applies = 'EE' AND a.Decision_Applies = '0');

-- 43.
ALTER TABLE Applies
DROP CONSTRAINT FK_Students
DROP CONSTRAINT FK_Colleges;


ALTER TABLE Applies
ADD CONSTRAINT FK_Students
    FOREIGN KEY (sID_Applies)
    REFERENCES Students(ID_Students)
    ON DELETE CASCADE;

ALTER TABLE Applies
ADD CONSTRAINT FK_Colleges
    FOREIGN KEY (College_Applies)
    REFERENCES Colleges(Name_Colleges)
    ON DELETE CASCADE;


DELETE FROM Applies a
WHERE a.sID_Applies IN (
    SELECT aa.sID_Applies
    FROM (
        SELECT DISTINCT sID_Applies, Major_Applies
        FROM Applies
    ) aa
    GROUP BY aa.sID_Applies
    HAVING COUNT(sID_Applies) > 2
);


-- 44.
ALTER TABLE Applies
DROP CONSTRAINT FK_Colleges;

ALTER TABLE Applies
ADD CONSTRAINT FK_Colleges
    FOREIGN KEY (College_Applies)
    REFERENCES Colleges(Name_Colleges)
    ON DELETE CASCADE;

DELETE FROM Colleges 
WHERE Name_Colleges NOT IN ( 
    SELECT a.College_Applies 
    FROM Applies a 
    WHERE a.Major_Applies = 'CS' 
);

-- 45.
UPDATE Applies
SET Decision_Applies = '1'
WHERE Major_Applies = 'EE' AND sID_Applies IN (
    SELECT ID_Students
    FROM Students
    WHERE Mark_Students < 3.6
);

-- 46.
UPDATE Applies
SET Major_Applies = 'bioengineering'
WHERE Major_Applies = 'CS' AND sID_Applies IN (
    SELECT ID_Students
    FROM Students
    WHERE Mark_Students = (
        SELECT MAX(Mark_Students) FROM Students
    )
);

-- 47.
UPDATE Students
SET Mark_Students = (
    SELECT MAX(Mark_Students) FROM Students
),
Size_high_school_Students = (
    SELECT MIN(Size_high_school_Students) FROM Students
);

-- 48.
UPDATE Applies
SET Decision_Applies = '1';