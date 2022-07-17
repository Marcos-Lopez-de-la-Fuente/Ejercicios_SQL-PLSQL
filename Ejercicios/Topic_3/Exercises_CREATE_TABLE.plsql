-- CREATES TABLES
CREATE TABLE Clubs (
    -- El "20" indica la cantidad de carácteres máximos
    Team_Name varchar(20) NOT NULL,
    Stadium_Name varchar(20),
    -- El "5" indica la cantidad de carácteres máximos, en este caso no se admiten decimales
    Capacity number(5),
    Community number(2) NOT NULL,
    -- Utilizo "date" para indicarle que es una fecha, en los "INSERTS" utilizaremos la funciones chungas
    Foundation date NOT NULL,

    CONSTRAINT Clubs_PK PRIMARY KEY (Team_Name)
);

INSERT INTO Clubs VALUES (
    'Real Madrid'
);

CREATE TABLE Players (
    Name varchar(30) NOT NULL,
    Club varchar(20) NOT NULL,
    Date_of_Birth date NOT NULL,
    -- En este caso será un número con un máximo de 3 carácteres enteros y la posibilidad de tener hasta 2 decimales
    Weight number(5,2),
    Number_Team number(2) NOT NULL,
    Position varchar(20),

    CONSTRAINT Players_PK PRIMARY KEY (Club, Number_Team),
    CONSTRAINT Club_FK FOREIGN KEY (Club) REFERENCES Clubs(Team_Name),
    CONSTRAINT Name_FK FOREIGN KEY (Name) REFERENCES Statistics(Name)
);

CREATE TABLE Statistics (
    Name varchar(30) NOT NULL,
    Goals number(*,0), -- Utilizo "(*,0)" indicando que pueden haber "infinitos" valores enteros, pero no pueden haber decimales
    Matches number(*,0),
    Minutes number(*,0), -- Utilizo "number" debido a que así se puede hacer un script donde sumas la cantidad de minutos que tenía el jugador + los minutos que ha hecho en un nuevo partido
    Yellow_Cards number(*,0),
    Red_Cards number(*,0),

    CONSTRAINT Statistics_PK PRIMARY KEY (Name) -- Debido a que las tablas "Players" y "Statistics" deberían ser solo 1, esta PK no es del todo acertada
);

CREATE TABLE Calendar (
    Date_Match date NOT NULL,
    Local_Team varchar(30) NOT NULL,
    Foreign_Team varchar(30) NOT NULL,
    Local_Goals number(*,0) NOT NULL,
    Foreign_Goals number(*,0) NOT NULL,

    CONSTRAINT Calendar_PK PRIMARY KEY (Date_Match, Local_Team, Foreign_Team),
    CONSTRAINT Local_Team_FK FOREIGN KEY (Local_Team) REFERENCES Clubs(Team_Name),
    CONSTRAINT Foreign_Team_FK FOREIGN KEY (Foreign_Team) REFERENCES Clubs(Team_Name)
);
