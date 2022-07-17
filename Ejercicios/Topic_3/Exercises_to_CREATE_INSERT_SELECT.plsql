CREATE TABLE Staff (
    Employee_Code varchar(4) NOT NULL,
    Name varchar(20) NOT NULL,
    Job varchar(30),
    Salary number(5),
    Department_Code varchar(2),
    Start_Date date,
    Superior_Officer varchar(4),

    CONSTRAINT Staff_PK PRIMARY KEY (Employee_Code)
);

INSERT INTO Staff VALUES (
    '0642',
    'Marcos',
    'Programador',
    5325,
    '05',
    TO_DATE('09-07-2003', 'dd-mm-yyyy'), -- Este es formato completo, mientras siga esta base puedo usar formatos reducidos de este
    '5642'
);
INSERT INTO Staff VALUES (
    '0642',
    'Marcos',
    'Programador',
    5325,
    '05',
    TO_DATE('2003', 'yyyy'), -- Formato de solo el año, en "mm" pondrá el més actual y en "dd" pondrá "01"
    '5642'
);
INSERT INTO Staff VALUES (
    '0842',
    'Marcos',
    'Programador',
    5325,
    '05',
    TO_DATE('07', 'mm'), -- Formato de solo el mes, en 'yyyy' pondrá el año actual y en "dd" pondrá "01"
    '5642'
);
INSERT INTO Staff VALUES (
    '0682',
    'Marcos',
    'Programador',
    5325,
    '05',
    TO_DATE('09', 'dd'), -- Formato de solo el día, en 'yyyy' pondrá el año actual, y en "mm" pondrá el més actual
    '5642'
);