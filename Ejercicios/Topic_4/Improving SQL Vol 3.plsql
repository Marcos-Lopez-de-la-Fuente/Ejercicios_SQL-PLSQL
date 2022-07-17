-- CREATE TABLEs
CREATE TABLE Pieces (
    Code_Pieces int NOT NULL,
    Name_Pieces varchar(255) NOT NULL,
    CONSTRAINT PK_Code_Pieces PRIMARY KEY (Code_Pieces)
);

CREATE TABLE Providers (
    Code_Providers varchar(255) NOT NULL,
    Name_Providers varchar(255) NOT NULL,
    CONSTRAINT PK_Code_Providers PRIMARY KEY (Code_Providers)
);

CREATE TABLE Provides (
    Piece_Provides int NOT NULL,
    Provider_Provides varchar(255) NOT NULL,
    Price_Provides int NOT NULL,
    CONSTRAINT FK_Pieces_Provides FOREIGN KEY (Piece_Provides) REFERENCES Pieces (Code_Pieces),
    CONSTRAINT FK_Provider_Provides FOREIGN KEY (Provider_Provides) REFERENCES Providers (Code_Providers),
    CONSTRAINT PK_Provides PRIMARY KEY (Piece_Provides,Provider_Provides)
);

-- INSERTs
INSERT INTO Pieces(Code_Pieces, Name_Pieces) VALUES(1,'Sprocket');
INSERT INTO Pieces(Code_Pieces, Name_Pieces) VALUES(2,'Screw');
INSERT INTO Pieces(Code_Pieces, Name_Pieces) VALUES(3,'Nut');
INSERT INTO Pieces(Code_Pieces, Name_Pieces) VALUES(4,'Bolt');

INSERT INTO Providers(Code_Providers, Name_Providers) VALUES('HAL','Clarke Enterprises');
INSERT INTO Providers(Code_Providers, Name_Providers) VALUES('RBT','Susan Calvin Corp.');
INSERT INTO Providers(Code_Providers, Name_Providers) VALUES('TNBC','Skellington Supplies');

INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(1,'HAL',10);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(1,'RBT',15);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(2,'HAL',20);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(2,'RBT',15);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(2,'TNBC',14);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(3,'RBT',50);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(3,'TNBC',45);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(4,'HAL',5);
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(4,'RBT',7);

-- 1.
SELECT Name_Pieces
FROM Pieces;

-- 2.
SELECT *
FROM Providers;

-- 3.
SELECT Pieces.Code_Pieces, AVG(Provides.Price_Provides)
FROM Pieces
INNER JOIN Provides ON Pieces.Code_Pieces = Provides.Piece_Provides
GROUP BY Name_Pieces
ORDER BY Code_Pieces;

-- 4.
-- 4.a
SELECT Providers.Name_Providers
FROM Providers
WHERE EXISTS (
    SELECT Providers.Name_Providers
    FROM Provides
    WHERE Providers.Code_Providers = Provides.Provider_Provides AND Provides.Piece_Provides = 1
);

-- 4.b
SELECT Providers.Name_Providers
FROM Providers
INNER JOIN Provides ON Providers.Code_Providers = Provides.Provider_Provides
WHERE Provides.Piece_Provides = 1;

-- 5.
-- 5.a
SELECT Pieces.Name_Pieces
FROM Pieces
INNER JOIN Provides ON Pieces.Code_Pieces = Provides.Piece_Provides
WHERE Provides.Provider_Provides = "HAL";

-- 5.b
SELECT Pieces.Name_Pieces
FROM Pieces
INNER JOIN Provides ON Pieces.Code_Pieces = Provides.Piece_Provides
WHERE Provides.Provider_Provides = (
    SELECT Provides.Provider_Provides
    FROM Providers
    WHERE Provides.Provider_Provides = "HAL"
);

-- 5.c
SELECT Name_Pieces
FROM Pieces
WHERE EXISTS (
    SELECT Provides.Piece_Provides
    FROM Provides
    WHERE Provides.Provider_Provides = "HAL" AND Provides.Piece_Provides = Pieces.Code_Pieces
);

-- 6.
SELECT Pieces.Name_Pieces, Providers.Name_Providers, MAX(Provides.Price_Provides)
FROM Pieces
INNER JOIN Provides ON Pieces.Code_Pieces = Provides.Piece_Provides
INNER JOIN Providers ON Provides.Provider_Provides = Providers.Code_Providers
GROUP BY Pieces.Name_Pieces;

-- 7.
INSERT INTO Provides(Piece_Provides, Provider_Provides, Price_Provides) VALUES(1,'TNBC',7);

-- 8.
UPDATE Provides
SET Price_Provides = Price_Provides + 1;

-- 9.
DELETE FROM Provides
WHERE Piece_Provides = 4 AND Provider_Provides = "RBT";

-- 10.
DELETE FROM Provides
WHERE Provider_Provides = "RBT";
