-- CREATE TABLEs
CREATE TABLE Manufacturers (
	Code    int             NOT NULL,
    Name    varchar(255)    NOT NULL,
    CONSTRAINT PK_Code PRIMARY KEY (Code)
);

CREATE TABLE Productss (
	Code_Products   int             NOT NULL,
    Name            varchar(255)    NOT NULL,
    Price           real            NOT NULL,
    Code            int             NOT NULL,
    CONSTRAINT PK_Code_Products PRIMARY KEY (Code_Products),
    CONSTRAINT FK_Manufacturer FOREIGN KEY (Code) REFERENCES Manufacturers(Code)
);

-- INSERTs
INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(1,'Hard drive',240,5);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(2,'Memory',120,6);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(3,'ZIP drive',150,4);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(4,'Floppy disk',5,6);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(5,'Monitor',240,1);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(6,'DVD drive',180,2);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(7,'CD drive',90,2);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(8,'Printer',270,3);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(10,'DVD burner',180,2);

-- 1.
SELECT Name
FROM Productss;

-- 2.
SELECT Name, Price
FROM Productss;

-- 3.
SELECT Name
FROM Productss
WHERE Price <= 200;

-- 4.
SELECT Name
FROM Productss
WHERE Price BETWEEN 60 AND 120;

-- 5.
SELECT Name, Price * 100
FROM Productss;

-- 6.
SELECT AVG(Price)
FROM Productss;

-- 7.
SELECT AVG(Price)
FROM Productss
WHERE Code = 2;

-- 8.
SELECT COUNT(*)
FROM Productss
WHERE Price >= 180;

-- 9.
SELECT Name, Price
FROM Productss
WHERE Price >= 180
ORDER BY Price DESC, Name ASC;

-- 10.
SELECT *
FROM Productss
INNER JOIN Manufacturers ON Productss.Code = Manufacturers.Code;

-- 11.
SELECT Productss.Name, Productss.Price, Manufacturers.Name Manufacturers
FROM Productss
INNER JOIN Manufacturers ON Productss.Code = Manufacturers.Code;

-- 12.
SELECT AVG(Productss.Price), Manufacturers.Code
FROM Manufacturers
INNER JOIN Productss ON Productss.Code = Manufacturers.Code
GROUP BY Manufacturers.Name;

-- 13.
SELECT AVG(Productss.Price), Manufacturers.Name
FROM Manufacturers
INNER JOIN Productss ON Productss.Code = Manufacturers.Code
GROUP BY Manufacturers.Name;

-- 14.
SELECT Manufacturers.Name
FROM Manufacturers
INNER JOIN Productss ON Productss.Code = Manufacturers.Code
GROUP BY Manufacturers.Name
HAVING AVG(Productss.Price) >= 150;

-- 15.
SELECT Name, Price
FROM Productss
ORDER BY Price
limit 1;

-- 16.
SELECT Manufacturers.Name Manufacturers, Productss.Name, Price
FROM Manufacturers
INNER JOIN Productss ON Productss.Code = Manufacturers.Code
GROUP BY Manufacturers.Name
ORDER BY Productss.Price DESC;

-- 17.
INSERT INTO Productss(Code_Products,Name,Price,Code) VALUES(11,'Loudspeakers',70,2);

-- 18.
UPDATE Productss
SET Name = 'Laser Printer'
WHERE Code = 8;

-- 19.
UPDATE Productss
SET Price = Price * 0.9;

-- 20.
UPDATE Productss
SET Price = Price * 0.9
WHERE Price >= 120;
