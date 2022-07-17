CREATE TABLE Patients (
    id number NOT NULL,
    name_ varchar(40) NOT NULL,
    address_ varchar(30),
    sex varchar(1) NOT NULL,
    birthday date,

    CHECK (sex = 'M' OR sex = 'F'),

    CONSTRAINT Patients_PK PRIMARY KEY (id) 
);

CREATE TABLE Hospitals (
    code number NOT NULL,
    name_ varchar(30) NOT NULL,
    address_ varchar(30),
    phone varchar(20),
    amountBeds number DEFAULT 0,

    CONSTRAINT Hospitals_PK PRIMARY KEY (code)
);

CREATE TABLE Rooms (
    hospitalCode number NOT NULL,
    roomCode number NOT NULL,
    name_ varchar(20),
    bedsQuantity number DEFAULT 0,

    CONSTRAINT Rooms_PK PRIMARY KEY (hospitalCode, roomCode),

    CONSTRAINT HospitalCode_FK FOREIGN KEY (hospitalCode) REFERENCES Hospitals(code)
);

CREATE TABLE Admissions (
    code number NOT NULL,
    hospitalCode number NOT NULL,
    roomCode number NOT NULL,
    bedCode number NOT NULL,
    discharge varchar(6) NOT NULL,
    patient number NOT NULL,

    CHECK (discharge = 'true' OR discharge = 'false'),

    CONSTRAINT Admissions_PK PRIMARY KEY (code),

    CONSTRAINT Admissions_HospitalCode_RoomCode_FK FOREIGN KEY (hospitalCode, roomCode) REFERENCES Rooms(hospitalCode, roomCode),
    CONSTRAINT Patient_FK FOREIGN KEY (patient) REFERENCES Patients(id) ON DELETE CASCADE
);

CREATE TABLE Staff (
    hospitalCode number NOT NULL,
    roomCode number NOT NULL,
    staffNumber number NOT NULL,
    name_ varchar(30),
    role_ varchar(20),
    shift varchar(1) NOT NULL,
    salary number,

    CHECK (shift = 'M' OR (shift = 'A' OR shift = 'N')),

    CONSTRAINT Staff_PK PRIMARY KEY (hospitalCode, roomCode, staffNumber),

    CONSTRAINT Staff_HospitalCode_RoomCode_FK FOREIGN KEY (hospitalCode, roomCode) REFERENCES Rooms(hospitalCode, roomCode)
);

CREATE TABLE Doctors (
    hospitalCode number NOT NULL,
    doctorNumber number NOT NULL,
    name_ varchar(30) NOT NULL,
    especiality varchar(20),

    CONSTRAINT Doctors_PK PRIMARY KEY (hospitalCode, doctorNumber),

    CONSTRAINT Doctors_HospitalCode_FK FOREIGN KEY (hospitalCode) REFERENCES Hospitals(code)
);

INSERT INTO Hospitals VALUES(1, 'Son Espases', 'Palma', '123456789', 500);
INSERT INTO Hospitals VALUES(2, 'Son Llatzer', 'Manacor', '987654321', 300);
INSERT INTO Hospitals VALUES(3, 'Ramon y Cajal', 'Madrid', '111111111', 550);

INSERT INTO Patients VALUES(1, 'Marcos López', 'Palma', 'M', TO_DATE('2002-12-08', 'YYYY-MM-DD'));
INSERT INTO Patients VALUES(2, 'Paco', 'Llucmajor', 'M', TO_DATE('2012-12-08', 'YYYY-MM-DD'));
INSERT INTO Patients VALUES(3, 'Maria', 'Llucmajor', 'F', TO_DATE('2022-12-08', 'YYYY-MM-DD'));


INSERT INTO Doctors VALUES(1, 1, 'Juan Perez', 'Dentista');
INSERT INTO Doctors VALUES(1, 2, 'Maria Sanchez', 'Pediatra');
INSERT INTO Doctors VALUES(2, 3, 'Marta Sanz', 'Traumatologa');
INSERT INTO Doctors VALUES(1, 4, 'Ronny Choez', 'Cirujano');
INSERT INTO Doctors VALUES(2, 5, 'Sara Baez', 'Cardiologia');
INSERT INTO Doctors VALUES(3, 6, 'Chis Lull', 'Geriatra');
INSERT INTO Doctors VALUES(3, 7, 'Camila Cabello', 'Nutriocionista');
INSERT INTO Doctors VALUES(1, 8, 'Joel Abad', 'Cardiologio');
INSERT INTO Doctors VALUES(2, 9, 'Luis Peralta', 'Anetegiologo');

INSERT INTO Rooms VALUES (1, 1, 'AAA', 1);
INSERT INTO Rooms VALUES (2, 2, 'ABA', 2);
INSERT INTO Rooms VALUES (1, 3, 'AAB', 1);
INSERT INTO Rooms VALUES (2, 4, 'BAA', 0);
INSERT INTO Rooms VALUES (3, 5, 'AAA', 1);
INSERT INTO Rooms VALUES (2, 6, 'ABA', 2);
INSERT INTO Rooms VALUES (1, 7, 'AAB', 1);
INSERT INTO Rooms VALUES (2, 8, 'BAA', 0);
INSERT INTO Rooms VALUES (3, 9, 'AAA', 1);
INSERT INTO Rooms VALUES (2, 10, 'ABA', 2);
INSERT INTO Rooms VALUES (1, 11, 'AAB', 1);
INSERT INTO Rooms VALUES (2, 12, 'BAA', 0);

INSERT INTO Admissions VALUES(1, 1, 1, 1, 'true', 1);
INSERT INTO Admissions VALUES(2, 2, 2, 2, 'true', 2);
INSERT INTO Admissions VALUES(3, 1, 3, 3, 'false', 3);
INSERT INTO Admissions VALUES(4, 2, 2, 4, 'false', 1);

INSERT INTO Staff VALUES(1, 1, 1, 'Estefan', 'Jefe', 'M', 2000);
INSERT INTO Staff VALUES(1, 1, 2, 'Alberto', 'Trabajador', 'M', 1000);
INSERT INTO Staff VALUES(1, 1, 3, 'Jessica', 'SubJefe', 'N', 1500);
INSERT INTO Staff VALUES(1, 1, 4, 'Alfonso', 'Trabajador', 'A', 1000);
INSERT INTO Staff VALUES(2, 2, 5, 'Pepe', 'Trabajador', 'N', 1000);

-- 1.
-- Buena
UPDATE Admissions a
SET a.hospitalCode = (
    SELECT h.code
    FROM Hospitals h
    WHERE h.name_ = 'Son Llatzer'
)
WHERE a.hospitalCode IN (
    SELECT hh.code
    FROM Hospitals hh
    WHERE hh.name_ = 'Son Espases'
) AND a.patient IN (
    SELECT p.id
    FROM Patients p
    WHERE address_ = 'Llucmajor'
);

-- M
Update Admissions
SET hospitalCode=2
WHERE patient IN (
    SELECT p.id
    FROM Patients p
    WHERE address_ = 'Llucmajor'
) AND hospitalCode=1;

-- L
Update ADMISSIONS
SET H_CODE='002'
WHERE P_CODE IN (
SELECT P.P_CODE
FROM PATIENTS P
WHERE UPPER(P.P_ADDRESS)='LLUCMAJOR'
) AND H_CODE='001';

-- 2.
SELECT p.name_, h.Name_
FROM Patients p
INNER JOIN Admissions a ON p.id = a.patient
INNER JOIN Hospitals h ON a.hospitalCode = h.code
WHERE a.discharge = 'false';

-- 3.
SELECT h.name_, SUM(s.salary * 12)
FROM Staff s
INNER JOIN Hospitals h ON s.hospitalCode = h.code
GROUP BY h.name_;

-- 4.
SELECT s.name_, h.name_
FROM Staff s
INNER JOIN Hospitals h ON s.hospitalCode = h.code
ORDER BY h.name_, s.name_;

-- 5.
SELECT COUNT(a.code)
FROM Staff s
INNER JOIN Admissions a ON s.roomCode = a.roomCode
WHERE s.role_ = 'nurse' AND s.name_ = 'Alice Smith';

-- 6.
SELECT DISTINCT a.hospitalCode, p.name_
FROM Patients p
INNER JOIN Admissions a ON p.id = a.patient
WHERE p.id IN (
    SELECT aa.patient
    FROM Admissions aa
    GROUP BY aa.patient
    HAVING COUNT(aa.patient) > 1
);

-- 7.
SELECT SUM(r.bedsQuantity)
FROM Rooms r
INNER JOIN Hospitals h ON r.hospitalCode = h.code
WHERE h.name_ = 'Son Espases';

-- 8.
SELECT p.id, p.name_, p.birthday, ((SYSDATE - TO_DATE(p.birthday)) / 365) anys
FROM Patients p
INNER JOIN Admissions a ON p.id = a.patient
WHERE ((SYSDATE - TO_DATE(p.birthday)) / 365) < 18;

-- 9.
ALTER TABLE Rooms
ADD admissionsNumber number;

-- 10.
UPDATE Rooms r
SET admissionsNumber = (
    SELECT COUNT(*)
    FROM Admissions a
    WHERE r.roomCode = a.roomCode
);
