CREATE TABLE Customer (
	DNI_Customer varchar(255) NOT NULL,
    Name_Customer varchar(255) NOT NULL,
    Province_Customer varchar(255) NOT NULL,
    Type_Customer varchar(255) NOT NULL,
    Register_Date_Customer date NOT NULL,
    Vendor_Customer varchar(255) NOT NULL,
    Purchases_Customer int NOT NULL,

    CONSTRAINT PK_Customer PRIMARY KEY (DNI_Customer),
    CONSTRAINT FK_Vendor FOREIGN KEY (Vendor_Customer) REFERENCES Vendor(Code_Vendor),
    CONSTRAINT FK_Province FOREIGN KEY (Province_Customer) REFERENCES Province(Name_Province)

);

CREATE TABLE Vendor (
    Code_Vendor varchar(255) NOT NULL,
    Name_Vendor varchar(255) NOT NULL,
    Percentage_Vendor varchar(255) NOT NULL,
    Degree_Vendor varchar(255) NOT NULL,
    Superior_Officer_Vendor varchar(255) NOT NULL,

    CONSTRAINT PK_Vendor PRIMARY KEY (Code_Vendor),
    CONSTRAINT FK_Superior_Officer_Vendor FOREIGN KEY (Superior_Officer_Vendor) REFERENCES Vendor(Code_Vendor)
);

CREATE TABLE Province (
    Code_Province varchar(255) NOT NULL,
    Name_Province varchar(255) NOT NULL,
    Total_Amount_Province int NOT NULL,

    CONSTRAINT PK_Province PRIMARY KEY (Name_Province)
);

CREATE TABLE Purchase (
    Code_Purchase int NOT NULL,
    Client_Purchase varchar(255) NOT NULL,
    Item_Purchase int NOT NULL,
    Date_Purchase date NOT NULL,
    Amount_Purchase int NOT NULL,

    CONSTRAINT PK_Purchase PRIMARY KEY (Code_Purchase),
    CONSTRAINT FK_Customer FOREIGN KEY (Client_Purchase) REFERENCES Customer(DNI_Customer),
    CONSTRAINT FK_Item FOREIGN KEY (Item_Purchase) REFERENCES Item(Code_Item)
);

CREATE TABLE Item (
    Code_Item int NOT NULL,
    Description_Item varchar(255) NOT NULL,
    Price_Item int NOT NULL,
    Stock_Item int NOT NULL,
    Origin_Item varchar(255) NOT NULL,

    CONSTRAINT PK_Item PRIMARY KEY (Code_Item),
    CONSTRAINT FK_Province FOREIGN KEY (Origin_Item) REFERENCES Province(Name_Province)
);


-- 1.
SELECT Customer.Name_customer, Customer.DNI_Customer, Vendor.Name_Vendor
FROM Customer
INNER JOIN Vendor ON Customer.Vendor_Customer = Vendor.Code_Vendor
WHERE Customer.Type_Customer = 'AA';

-- 2.
SELECT Customer.Name_customer, Province.Name_Province, Vendor.Name_Vendor
FROM Customer
INNER JOIN Vendor ON Customer.Vendor_Customer = Vendor.Code_Vendor
INNER JOIN Province ON Customer.Province_Customer = Province.Code_Province;

-- 3.
CREATE TABLE CATEGORY (
    Cat_PK_category Number(2),
    Cat_begining Number(9),
    Cat_end Number(9),

    CONSTRAINT PK_CATEGORY PRIMARY KEY (Cat_PK_category)
);

CREATE SEQUENCE Sequence_Cat_PK_category
    MINVALUE 1
    MAXVALUE 13
    START WITH 1
    INCREMENT BY 1

CREATE SEQUENCE Sequence_Cat_begining
    MINVALUE 1
    MAXVALUE 1200001
    START WITH 1
    INCREMENT BY 100000

CREATE SEQUENCE Sequence_end
    MINVALUE 100000
    MAXVALUE 1300000
    START WITH 100000
    INCREMENT BY 100000

INSERT INTO CATEGORY (
    Cat_PK_category,
    Cat_begining,
    Cat_end
) VALUES (
    NEXT VALUE FOR Cat_PK_category,
    NEXT VALUES FOR Sequence_Cat_begining,
    NEXT VALUES FOR Sequence_end
);

-- 4.
-- Category

-- 5.
-- Category

-- 6.
-- I don't understand, my bad

-- 7.
SELECT Name_customer FROM Customer
UNION
SELECT Name_Vendor FROM Vendor;

-- 8.
-- CUSTOMERS
SELECT Name_customer FROM Customer
UNION
SELECT Name_Vendor FROM Vendor
INTERSECT
SELECT Name_customer FROM Customer;

SELECT Name_customer FROM Customer
UNION
SELECT Name_Vendor FROM Vendor
EXCEPT
SELECT Name_Vendor FROM Vendor;

-- VENDORS
SELECT Name_customer FROM Customer
UNION
SELECT Name_Vendor FROM Vendor
INTERSECT
SELECT Name_Vendor FROM Vendor;

SELECT Name_customer FROM Customer
UNION
SELECT Name_Vendor FROM Vendor
EXCEPT
SELECT Name_customer FROM Customer;

-- 9.
SELECT Vendor2.Name_Vendor, Vendor.Code_Vendor, Customer.Name_Customer, Vendor.Name_Vendor
FROM Customer
INNER JOIN Vendor ON Customer.Vendor_Customer = Vendor.Code_Vendor
INNER JOIN Vendor Vendor2 ON Vendor.Superior_Officer_Vendor = Vendor2.Code_Vendor;

-- 10.
SELECT Customer2.*
FROM Customer
INNER JOIN Customer Customer2 ON Customer.Province_Customer = Customer2.Province_Customer
WHERE Customer.Name_Customer = 'Pablo Motos';

-- 11.
SELECT Customer2.Name_Customer
FROM Customer
INNER JOIN Customer Customer2 ON Customer.Purchase_Customer = Customer2.Purchase_Customer
WHERE Customer.Name_Customer = 'Pablo Motos' AND Customer2.Purchase_Customer > Customer.Purchase_Customer;

-- 12.
SELECT Customer2.Name_Customer
FROM Customer
INNER JOIN Customer Customer2 ON Customer.Type_Customer = Customer2.Type_Customer
WHERE Customer.Name_Customer = 'Pablo Motos' AND (Customer2.Type_Customer = Customer.Type_Customer AND Customer2.Vendor_Customer = Customer.Vendor_Customer);

-- 13.
SELECT Province.Name_Province
FROM Customer
INNER JOIN Province ON Customer.Province_Customer = Province.Code_Province
WHERE Province.Code_Province > (
    SELECT MAX(Customer.Province)
    FROM Customer
    WHERE Customer.Vendor_Customer = '003'
);

-- 14.
SELECT Customer.Name_Customer
FROM Customer
INNER JOIN Province ON Customer.Province_Customer = Province.Code_Province
INNER JOIN Vendor ON Customer.Vendor_Customer = Vendor.Code_Vendor
WHERE Province.Total_Amount_Province > 500000 AND Vendor.Percentage = 10;

