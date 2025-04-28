--CREATING TABLES:
-- Table: Brand
CREATE TABLE Brand (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    CONSTRAINT Brand_pk PRIMARY KEY (ID)
) ;

-- Table: Customer
CREATE TABLE Customer (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    Surname varchar2(50)  NOT NULL,
    BirthDate date  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (ID)
) ;

-- Table: Customer_Info
CREATE TABLE Customer_Info (
    Customer_ID integer  NOT NULL,
    Phone varchar2(50)  NOT NULL,
    Email varchar2(50)  NOT NULL,
    CONSTRAINT Customer_Info_pk PRIMARY KEY (Customer_ID)
) ;

-- Table: Day
CREATE TABLE Day (
    ID integer  NOT NULL,
    Name varchar2(10)  NOT NULL,
    CONSTRAINT Day_pk PRIMARY KEY (ID)
) ;

-- Table: Employee
CREATE TABLE Employee (
    ID integer  NOT NULL,
    HireDate date  NOT NULL,
    Salary integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    Surname varchar2(50)  NOT NULL,
    BirthDate date  NOT NULL,
    Supervisor_ID integer  NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (ID)
) ;

-- Table: Employee_Info
CREATE TABLE Employee_Info (
    Employee_ID integer  NOT NULL,
    Phone varchar2(50)  NOT NULL,
    Email varchar2(50)  NOT NULL,
    CONSTRAINT Employee_Info_pk PRIMARY KEY (Employee_ID)
) ;

-- Table: Employee_Job
CREATE TABLE Employee_Job (
    Job_ID integer  NOT NULL,
    Employee_ID integer  NOT NULL,
    CONSTRAINT Employee_Job_pk PRIMARY KEY (Job_ID,Employee_ID)
) ;

-- Table: Fuel_Type
CREATE TABLE Fuel_Type (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    CONSTRAINT Fuel_Type_pk PRIMARY KEY (ID)
) ;

-- Table: Job
CREATE TABLE Job (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    CONSTRAINT Job_pk PRIMARY KEY (ID)
) ;

-- Table: Payment
CREATE TABLE Payment (
    ID integer  NOT NULL,
    "Date" date  NOT NULL,
    Payment_Method_ID integer  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (ID)
) ;

-- Table: Payment_Method
CREATE TABLE Payment_Method (
    ID integer  NOT NULL,
    Name varchar2(20)  NOT NULL,
    CONSTRAINT Payment_Method_pk PRIMARY KEY (ID)
) ;

-- Table: Schedule
CREATE TABLE Schedule (
    Shift_ID integer  NOT NULL,
    Employee_ID integer  NOT NULL,
    CONSTRAINT Schedule_pk PRIMARY KEY (Shift_ID,Employee_ID)
) ;

-- Table: ServiceRecords
CREATE TABLE ServiceRecords (
    ID integer  NOT NULL,
    Begin_Date date  NOT NULL,
    End_Date date  NULL,
    Vehicle_ID integer  NOT NULL,
    Service_Type_ID integer  NOT NULL,
    Payment_ID integer  NULL,
    Employee_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    CONSTRAINT ServiceRecords_pk PRIMARY KEY (ID)
) ;

-- Table: Service_Type
CREATE TABLE Service_Type (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    Price integer  NOT NULL,
    CONSTRAINT Service_Type_pk PRIMARY KEY (ID)
) ;

-- Table: Shift
CREATE TABLE Shift (
    ID integer  NOT NULL,
    StartTime timestamp  NOT NULL,
    EndTime timestamp  NOT NULL,
    Day_ID integer  NOT NULL,
    CONSTRAINT Shift_pk PRIMARY KEY (ID)
) ;

-- Table: Vehicle
CREATE TABLE Vehicle (
    ID integer  NOT NULL,
    LicencePlate varchar2(20)  NOT NULL,
    Vehicle_Type_ID integer  NOT NULL,
    ProductionDate date  NOT NULL,
    Brand_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    CONSTRAINT Vehicle_pk PRIMARY KEY (ID)
) ;

-- Table: Vehicle_Fuel_Type
CREATE TABLE Vehicle_Fuel_Type (
    Vehicle_ID integer  NOT NULL,
    Fuel_Type_ID integer  NOT NULL,
    CONSTRAINT Vehicle_Fuel_Type_pk PRIMARY KEY (Vehicle_ID,Fuel_Type_ID)
) ;

-- Table: Vehicle_Type
CREATE TABLE Vehicle_Type (
    ID integer  NOT NULL,
    Name varchar2(50)  NOT NULL,
    CONSTRAINT Vehicle_Type_pk PRIMARY KEY (ID)
) ;

-- foreign keys
-- Reference: Customer_Info_Customer (table: Customer_Info)
ALTER TABLE Customer_Info ADD CONSTRAINT Customer_Info_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: Employee_Employee (table: Employee)
ALTER TABLE Employee ADD CONSTRAINT Employee_Employee
    FOREIGN KEY (Supervisor_ID)
    REFERENCES Employee (ID);

-- Reference: Employee_Info_Employee (table: Employee_Info)
ALTER TABLE Employee_Info ADD CONSTRAINT Employee_Info_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: Employee_Job_Employee (table: Employee_Job)
ALTER TABLE Employee_Job ADD CONSTRAINT Employee_Job_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: Employee_Job_Job (table: Employee_Job)
ALTER TABLE Employee_Job ADD CONSTRAINT Employee_Job_Job
    FOREIGN KEY (Job_ID)
    REFERENCES Job (ID);

-- Reference: Payment_Payment_Method (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_Payment_Method
    FOREIGN KEY (Payment_Method_ID)
    REFERENCES Payment_Method (ID);

-- Reference: Schedule_Employee (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: Schedule_Shift (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Shift
    FOREIGN KEY (Shift_ID)
    REFERENCES Shift (ID);

-- Reference: ServiceRecords_Customer (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: ServiceRecords_Employee (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: ServiceRecords_Payment (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Payment
    FOREIGN KEY (Payment_ID)
    REFERENCES Payment (ID);

-- Reference: ServiceRecords_Service_Type (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Service_Type
    FOREIGN KEY (Service_Type_ID)
    REFERENCES Service_Type (ID);

-- Reference: ServiceRecords_Vehicle (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Vehicle
    FOREIGN KEY (Vehicle_ID)
    REFERENCES Vehicle (ID);

-- Reference: Shift_Day (table: Shift)
ALTER TABLE Shift ADD CONSTRAINT Shift_Day
    FOREIGN KEY (Day_ID)
    REFERENCES Day (ID);

-- Reference: Vehicle_Brand (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_Brand
    FOREIGN KEY (Brand_ID)
    REFERENCES Brand (ID);

-- Reference: Vehicle_Customer (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: Vehicle_Fuel_Type_Fuel_Type (table: Vehicle_Fuel_Type)
ALTER TABLE Vehicle_Fuel_Type ADD CONSTRAINT Vehicle_Fuel_Type_Fuel_Type
    FOREIGN KEY (Fuel_Type_ID)
    REFERENCES Fuel_Type (ID);

-- Reference: Vehicle_Fuel_Type_Vehicle (table: Vehicle_Fuel_Type)
ALTER TABLE Vehicle_Fuel_Type ADD CONSTRAINT Vehicle_Fuel_Type_Vehicle
    FOREIGN KEY (Vehicle_ID)
    REFERENCES Vehicle (ID);

-- Reference: Vehicle_Vehicle_Type (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_Vehicle_Type
    FOREIGN KEY (Vehicle_Type_ID)
    REFERENCES Vehicle_Type (ID);

--INSERTING VALUES INTO TABLES:
-- Inserting into Day
INSERT INTO Day (ID, Name) VALUES (110, 'Monday');
INSERT INTO Day (ID, Name) VALUES (111, 'Tuesday');
INSERT INTO Day (ID, Name) VALUES (112, 'Wednesday');
INSERT INTO Day (ID, Name) VALUES (113, 'Thursday');
INSERT INTO Day (ID, Name) VALUES (114, 'Friday');
INSERT INTO Day (ID, Name) VALUES (115, 'Saturday');
INSERT INTO Day (ID, Name) VALUES (116, 'Sunday');




-- Inserting into Brand
INSERT INTO Brand (ID, Name) VALUES (210, 'Toyota');
INSERT INTO Brand (ID, Name) VALUES (211, 'Honda');
INSERT INTO Brand (ID, Name) VALUES (212, 'Nissan');
INSERT INTO Brand (ID, Name) VALUES (213, 'Volkswagen');
INSERT INTO Brand (ID, Name) VALUES (214, 'BMW');

-- Inserting into Vehicle_Type
INSERT INTO Vehicle_Type (ID, Name) VALUES (330, 'Sedan');
INSERT INTO Vehicle_Type (ID, Name) VALUES (331, 'Coupe');
INSERT INTO Vehicle_Type (ID, Name) VALUES (332, 'Convertible');
INSERT INTO Vehicle_Type (ID, Name) VALUES (333, 'SportsCar');
INSERT INTO Vehicle_Type (ID, Name) VALUES (334, 'Minivan');
INSERT INTO Vehicle_Type (ID, Name) VALUES (335, 'Universal');



-- Inserting into Fuel_Type
INSERT INTO Fuel_Type (ID, Name) VALUES (440, 'Petrol');
INSERT INTO Fuel_Type (ID, Name) VALUES (441, 'Diesel');
INSERT INTO Fuel_Type (ID, Name) VALUES (442, 'Electric');
INSERT INTO Fuel_Type (ID, Name) VALUES (444, 'Gas');

-- Inserting into Customer
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1001, 'Jeremy', 'Clarkson', TO_DATE('1975-01-15', 'YYYY-MM-DD'));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1002, 'Sam', 'Aronie', TO_DATE('1997-06-22', 'YYYY-MM-DD'));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1003, 'Alexi', 'Forheads', TO_DATE('1984-11-03', 'YYYY-MM-DD'));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1004, 'Roman', 'Tivodar', TO_DATE('1993-08-12', 'YYYY-MM-DD'));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1005, 'Naoki', 'Nakamura', TO_DATE('1982-03-30', 'YYYY-MM-DD'));

-- Inserting into Customer_Info
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1001, '1234567890', 'jeremy.clrk@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1002, '0987654321', 'dum1technology@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1003, '5678901234', 'noriyaro@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1004, '6789012345', 'forwardauto@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1005, '7890123456', 'pinkstylejpn@gmail.com');


-- Inserting into Employee
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3010, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1500, 'Alice', 'Johnson', TO_DATE('1990-04-25', 'YYYY-MM-DD'), NULL);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3011, TO_DATE('2021-06-15', 'YYYY-MM-DD'), 2900, 'Bob', 'Wilson', TO_DATE('1985-07-12', 'YYYY-MM-DD'), 3010);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3012, TO_DATE('2022-03-10', 'YYYY-MM-DD'), 1300, 'Catherine', 'Lee', TO_DATE('1988-09-20', 'YYYY-MM-DD'), 3010);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3013, TO_DATE('2019-11-01', 'YYYY-MM-DD'), 7000, 'Daniel', 'Brown', TO_DATE('1972-02-15', 'YYYY-MM-DD'), NULL);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3014, TO_DATE('2018-05-20', 'YYYY-MM-DD'), 4500, 'John', 'Cowart', TO_DATE('1988-01-05', 'YYYY-MM-DD'), 3013);


-- Inserting into Employee_Info
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3010, '3190482308', 'aliceinchains@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3011, '0438355553', 'bobwilly@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3012, '1289373228', 'catha@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3013, '2284800091', 'daniel.brown@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3014, '1233219991', 'cowply@example.com');

-- Inserting into Job
INSERT INTO Job (ID, Name) VALUES (7771, 'Mechanic');
INSERT INTO Job (ID, Name) VALUES (7772, 'Manager');
INSERT INTO Job (ID, Name) VALUES (7773, 'Accountant');
INSERT INTO Job (ID, Name) VALUES (7774, 'Body painter');
INSERT INTO Job (ID, Name) VALUES (7775, 'Welder');

-- Inserting into Employee_Job
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7771, 3010);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7772, 3011);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7773, 3012);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7774, 3013);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7775, 3014);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7775, 3011);


-- Inserting into Payment_Method
INSERT INTO Payment_Method (ID, Name) VALUES (551, 'Credit Card');
INSERT INTO Payment_Method (ID, Name) VALUES (552, 'Cash');
INSERT INTO Payment_Method (ID, Name) VALUES (553, 'Terminal Transfer');
INSERT INTO Payment_Method (ID, Name) VALUES (554, 'Crypto');
INSERT INTO Payment_Method (ID, Name) VALUES (555, 'PayPal');

-- Inserting into Payment
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3111, TO_DATE('2024-04-25', 'YYYY-MM-DD'), 551);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3112, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 551);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3113, TO_DATE('2021-04-09', 'YYYY-MM-DD'), 554);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3114, TO_DATE('2023-01-19', 'YYYY-MM-DD'), 552);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3115, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 552);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3116, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 555);

--Inserting into Vehicle
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (881, 'ABC123', 330, TO_DATE('1999-07-12', 'YYYY-MM-DD'), 210, 1001);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (882, 'DEF455', 333, TO_DATE('2002-07-12', 'YYYY-MM-DD'), 212, 1001);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (883, 'DDR001', 335, TO_DATE('2015-07-12', 'YYYY-MM-DD'), 213, 1002);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (884, 'LHO442', 334, TO_DATE('2009-07-12', 'YYYY-MM-DD'), 214, 1003);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (885, 'RNW222', 332, TO_DATE('1991-07-12', 'YYYY-MM-DD'), 211, 1004);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (886, 'QWE987', 331, TO_DATE('2022-07-12', 'YYYY-MM-DD'), 212, 1005);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (887, 'AYE229', 330, TO_DATE('1980-01-11', 'YYYY-MM-DD'), 214, 1003);

--Inserting into Service_Type
INSERT INTO Service_Type (ID, Name, Price) VALUES (2001, 'Oil Change', 250);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2002, 'Engine block replacement', 1500);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2003, 'Body reinforcement', 2000);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2004, 'Repaint', 5000);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2005, 'Turbo upgrade', 850);

--Inserting into Vehicle_Fuel_Type
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (881, 440);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (882, 440);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (883, 441);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (884, 442);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (885, 444);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (886, 441);

--Inserting into Shift
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (220, TO_TIMESTAMP('08:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), 110);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (221, TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('23:59:59', 'HH24:MI:SS'), 111);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (222, TO_TIMESTAMP('08:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), 112);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (223, TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('23:59:59', 'HH24:MI:SS'), 113);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (224, TO_TIMESTAMP('08:00:00', 'HH24:MI:SS'), TO_TIMESTAMP('16:00:00', 'HH24:MI:SS'), 114);


INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (220, 3010);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (221, 3010);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (221, 3012);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (222, 3011);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (223, 3012);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (223, 3013);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (224, 3014);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (222, 3014);


INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9990, TO_DATE('2021-05-01', 'YY-MM-DD'), TO_DATE('2022-08-09', 'YY-MM-DD'), 881, 2001, 3111, 3010, 1001);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9991, TO_DATE('2020-02-13', 'YY-MM-DD'), TO_DATE('2021-03-10', 'YY-MM-DD'), 882, 2002, 3112, 3011, 1001);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9992, TO_DATE('2022-04-17', 'YY-MM-DD'), TO_DATE('2024-10-11', 'YY-MM-DD'), 883, 2003, 3113, 3012, 1002);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9993, TO_DATE('2023-08-19', 'YY-MM-DD'), TO_DATE('2025-01-01', 'YY-MM-DD'), 884, 2004, 3114, 3013, 1003);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9994, TO_DATE('2018-12-12', 'YY-MM-DD'), TO_DATE('2019-02-15', 'YY-MM-DD'), 885, 2005, 3115, 3014, 1004);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9995, TO_DATE('2018-12-12', 'YY-MM-DD'), TO_DATE('2019-02-15', 'YY-MM-DD'), 886, 2002, 3116, 3012, 1005);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9996, TO_DATE('2018-12-12', 'YY-MM-DD'), null, 887, 2002, null, 3012, 1003); --old BMW

COMMIT;

---------------------------------------------------------------------------------------------------------------------------
--INSERTS FOR TSQL:
--CREATING TABLES:
-- Table: Brand
CREATE TABLE Brand (
    ID integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT Brand_pk PRIMARY KEY (ID)
) ;

-- Table: Customer
CREATE TABLE Customer (
    ID integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    Surname varchar(50)  NOT NULL,
    BirthDate date  NOT NULL,
    CONSTRAINT Customer_pk PRIMARY KEY (ID)
) ;

-- Table: Customer_Info
CREATE TABLE Customer_Info (
    Customer_ID integer  NOT NULL,
    Phone varchar(50)  NOT NULL,
    Email varchar(50)  NOT NULL,
    CONSTRAINT Customer_Info_pk PRIMARY KEY (Customer_ID)
) ;

-- Table: Day
CREATE TABLE Day (
    ID integer  NOT NULL,
    Name varchar(10)  NOT NULL,
    CONSTRAINT Day_pk PRIMARY KEY (ID)
) ;

-- Table: Employee
CREATE TABLE Employee (
    ID integer  NOT NULL,
    HireDate date  NOT NULL,
    Salary integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    Surname varchar(50)  NOT NULL,
    BirthDate date  NOT NULL,
    Supervisor_ID integer  NULL,
    CONSTRAINT Employee_pk PRIMARY KEY (ID)
) ;

-- Table: Employee_Info
CREATE TABLE Employee_Info (
    Employee_ID integer  NOT NULL,
    Phone varchar(50)  NOT NULL,
    Email varchar(50)  NOT NULL,
    CONSTRAINT Employee_Info_pk PRIMARY KEY (Employee_ID)
) ;

-- Table: Employee_Job
CREATE TABLE Employee_Job (
    Job_ID integer  NOT NULL,
    Employee_ID integer  NOT NULL,
    CONSTRAINT Employee_Job_pk PRIMARY KEY (Job_ID,Employee_ID)
) ;

-- Table: Fuel_Type
CREATE TABLE Fuel_Type (
    ID integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT Fuel_Type_pk PRIMARY KEY (ID)
) ;

-- Table: Job
CREATE TABLE Job (
    ID integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT Job_pk PRIMARY KEY (ID)
) ;

-- Table: Payment
CREATE TABLE Payment (
    ID integer  NOT NULL,
    "Date" date  NOT NULL,
    Payment_Method_ID integer  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (ID)
) ;

-- Table: Payment_Method
CREATE TABLE Payment_Method (
    ID integer  NOT NULL,
    Name varchar(20)  NOT NULL,
    CONSTRAINT Payment_Method_pk PRIMARY KEY (ID)
) ;

-- Table: Schedule
CREATE TABLE Schedule (
    Shift_ID integer  NOT NULL,
    Employee_ID integer  NOT NULL,
    CONSTRAINT Schedule_pk PRIMARY KEY (Shift_ID,Employee_ID)
) ;

-- Table: ServiceRecords
CREATE TABLE ServiceRecords (
    ID integer  NOT NULL,
    Begin_Date date  NOT NULL,
    End_Date date  NULL,
    Vehicle_ID integer  NOT NULL,
    Service_Type_ID integer  NOT NULL,
    Payment_ID integer  NULL,
    Employee_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    CONSTRAINT ServiceRecords_pk PRIMARY KEY (ID)
) ;

-- Table: Service_Type
CREATE TABLE Service_Type (
    ID integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    Price integer  NOT NULL,
    CONSTRAINT Service_Type_pk PRIMARY KEY (ID)
) ;

-- Table: Shift
CREATE TABLE Shift (
    ID integer  NOT NULL,
    StartTime time  NOT NULL,
    EndTime time  NOT NULL,
    Day_ID integer  NOT NULL,
    CONSTRAINT Shift_pk PRIMARY KEY (ID)
) ;

-- Table: Vehicle
CREATE TABLE Vehicle (
    ID integer  NOT NULL,
    LicencePlate varchar(20)  NOT NULL,
    Vehicle_Type_ID integer  NOT NULL,
    ProductionDate date  NOT NULL,
    Brand_ID integer  NOT NULL,
    Customer_ID integer  NOT NULL,
    CONSTRAINT Vehicle_pk PRIMARY KEY (ID)
) ;

-- Table: Vehicle_Fuel_Type
CREATE TABLE Vehicle_Fuel_Type (
    Vehicle_ID integer  NOT NULL,
    Fuel_Type_ID integer  NOT NULL,
    CONSTRAINT Vehicle_Fuel_Type_pk PRIMARY KEY (Vehicle_ID,Fuel_Type_ID)
) ;

-- Table: Vehicle_Type
CREATE TABLE Vehicle_Type (
    ID integer  NOT NULL,
    Name varchar(50)  NOT NULL,
    CONSTRAINT Vehicle_Type_pk PRIMARY KEY (ID)
) ;

-- foreign keys
-- Reference: Customer_Info_Customer (table: Customer_Info)
ALTER TABLE Customer_Info ADD CONSTRAINT Customer_Info_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: Employee_Employee (table: Employee)
ALTER TABLE Employee ADD CONSTRAINT Employee_Employee
    FOREIGN KEY (Supervisor_ID)
    REFERENCES Employee (ID);

-- Reference: Employee_Info_Employee (table: Employee_Info)
ALTER TABLE Employee_Info ADD CONSTRAINT Employee_Info_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: Employee_Job_Employee (table: Employee_Job)
ALTER TABLE Employee_Job ADD CONSTRAINT Employee_Job_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: Employee_Job_Job (table: Employee_Job)
ALTER TABLE Employee_Job ADD CONSTRAINT Employee_Job_Job
    FOREIGN KEY (Job_ID)
    REFERENCES Job (ID);

-- Reference: Payment_Payment_Method (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_Payment_Method
    FOREIGN KEY (Payment_Method_ID)
    REFERENCES Payment_Method (ID);

-- Reference: Schedule_Employee (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: Schedule_Shift (table: Schedule)
ALTER TABLE Schedule ADD CONSTRAINT Schedule_Shift
    FOREIGN KEY (Shift_ID)
    REFERENCES Shift (ID);

-- Reference: ServiceRecords_Customer (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: ServiceRecords_Employee (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Employee
    FOREIGN KEY (Employee_ID)
    REFERENCES Employee (ID);

-- Reference: ServiceRecords_Payment (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Payment
    FOREIGN KEY (Payment_ID)
    REFERENCES Payment (ID);

-- Reference: ServiceRecords_Service_Type (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Service_Type
    FOREIGN KEY (Service_Type_ID)
    REFERENCES Service_Type (ID);

-- Reference: ServiceRecords_Vehicle (table: ServiceRecords)
ALTER TABLE ServiceRecords ADD CONSTRAINT ServiceRecords_Vehicle
    FOREIGN KEY (Vehicle_ID)
    REFERENCES Vehicle (ID);

-- Reference: Shift_Day (table: Shift)
ALTER TABLE Shift ADD CONSTRAINT Shift_Day
    FOREIGN KEY (Day_ID)
    REFERENCES Day (ID);

-- Reference: Vehicle_Brand (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_Brand
    FOREIGN KEY (Brand_ID)
    REFERENCES Brand (ID);

-- Reference: Vehicle_Customer (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer (ID);

-- Reference: Vehicle_Fuel_Type_Fuel_Type (table: Vehicle_Fuel_Type)
ALTER TABLE Vehicle_Fuel_Type ADD CONSTRAINT Vehicle_Fuel_Type_Fuel_Type
    FOREIGN KEY (Fuel_Type_ID)
    REFERENCES Fuel_Type (ID);

-- Reference: Vehicle_Fuel_Type_Vehicle (table: Vehicle_Fuel_Type)
ALTER TABLE Vehicle_Fuel_Type ADD CONSTRAINT Vehicle_Fuel_Type_Vehicle
    FOREIGN KEY (Vehicle_ID)
    REFERENCES Vehicle (ID);

-- Reference: Vehicle_Vehicle_Type (table: Vehicle)
ALTER TABLE Vehicle ADD CONSTRAINT Vehicle_Vehicle_Type
    FOREIGN KEY (Vehicle_Type_ID)
    REFERENCES Vehicle_Type (ID);

--INSERTING VALUES INTO TABLES:
-- Inserting into Day
INSERT INTO Day (ID, Name) VALUES (110, 'Monday');
INSERT INTO Day (ID, Name) VALUES (111, 'Tuesday');
INSERT INTO Day (ID, Name) VALUES (112, 'Wednesday');
INSERT INTO Day (ID, Name) VALUES (113, 'Thursday');
INSERT INTO Day (ID, Name) VALUES (114, 'Friday');
INSERT INTO Day (ID, Name) VALUES (115, 'Saturday');
INSERT INTO Day (ID, Name) VALUES (116, 'Sunday');




-- Inserting into Brand
INSERT INTO Brand (ID, Name) VALUES (210, 'Toyota');
INSERT INTO Brand (ID, Name) VALUES (211, 'Honda');
INSERT INTO Brand (ID, Name) VALUES (212, 'Nissan');
INSERT INTO Brand (ID, Name) VALUES (213, 'Volkswagen');
INSERT INTO Brand (ID, Name) VALUES (214, 'BMW');

-- Inserting into Vehicle_Type
INSERT INTO Vehicle_Type (ID, Name) VALUES (330, 'Sedan');
INSERT INTO Vehicle_Type (ID, Name) VALUES (331, 'Coupe');
INSERT INTO Vehicle_Type (ID, Name) VALUES (332, 'Convertible');
INSERT INTO Vehicle_Type (ID, Name) VALUES (333, 'SportsCar');
INSERT INTO Vehicle_Type (ID, Name) VALUES (334, 'Minivan');
INSERT INTO Vehicle_Type (ID, Name) VALUES (335, 'Universal');



-- Inserting into Fuel_Type
INSERT INTO Fuel_Type (ID, Name) VALUES (440, 'Petrol');
INSERT INTO Fuel_Type (ID, Name) VALUES (441, 'Diesel');
INSERT INTO Fuel_Type (ID, Name) VALUES (442, 'Electric');
INSERT INTO Fuel_Type (ID, Name) VALUES (444, 'Gas');

-- Inserting into Customer
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1001, 'Jeremy', 'Clarkson', CAST('1975-01-15' AS DATE));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1002, 'Sam', 'Aronie', CAST('1997-06-22' AS DATE));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1003, 'Alexi', 'Forheads', CAST('1984-11-03' AS DATE));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1004, 'Roman', 'Tivodar', CAST('1993-08-12' AS DATE));
INSERT INTO Customer (ID, Name, Surname, BirthDate) VALUES (1005, 'Naoki', 'Nakamura', CAST('1982-03-30' AS DATE));

-- Inserting into Customer_Info
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1001, '1234567890', 'jeremy.clrk@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1002, '0987654321', 'dum1technology@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1003, '5678901234', 'noriyaro@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1004, '6789012345', 'forwardauto@gmail.com');
INSERT INTO Customer_Info (Customer_ID, Phone, Email) VALUES (1005, '7890123456', 'pinkstylejpn@gmail.com');


-- Inserting into Employee
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3010, CAST('2025-01-01' AS DATE), 1500, 'Alice', 'Johnson', CAST('1990-04-25' AS DATE), NULL);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3011, CAST('2021-06-15' AS DATE), 2900, 'Bob', 'Wilson', CAST('1985-07-12' AS DATE), 3010);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3012, CAST('2022-03-10' AS DATE), 1300, 'Catherine', 'Lee', CAST('1988-09-20' AS DATE), 3010);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3013, CAST('2019-11-01' AS DATE), 7000, 'Daniel', 'Brown', CAST('1972-02-15' AS DATE), NULL);
INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3014, CAST('2018-05-20' AS DATE), 4500, 'John', 'Cowart', CAST('1988-01-05'AS DATE), 3013);


-- Inserting into Employee_Info
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3010, '3190482308', 'aliceinchains@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3011, '0438355553', 'bobwilly@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3012, '1289373228', 'catha@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3013, '2284800091', 'daniel.brown@example.com');
INSERT INTO Employee_Info (Employee_ID, Phone, Email) VALUES (3014, '1233219991', 'cowply@example.com');

-- Inserting into Job
INSERT INTO Job (ID, Name) VALUES (7771, 'Mechanic');
INSERT INTO Job (ID, Name) VALUES (7772, 'Manager');
INSERT INTO Job (ID, Name) VALUES (7773, 'Accountant');
INSERT INTO Job (ID, Name) VALUES (7774, 'Body painter');
INSERT INTO Job (ID, Name) VALUES (7775, 'Welder');

-- Inserting into Employee_Job
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7771, 3010);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7772, 3011);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7773, 3012);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7774, 3013);
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7775, 3014);


-- Inserting into Payment_Method
INSERT INTO Payment_Method (ID, Name) VALUES (551, 'Credit Card');
INSERT INTO Payment_Method (ID, Name) VALUES (552, 'Cash');
INSERT INTO Payment_Method (ID, Name) VALUES (553, 'Terminal Transfer');
INSERT INTO Payment_Method (ID, Name) VALUES (554, 'Crypto');
INSERT INTO Payment_Method (ID, Name) VALUES (555, 'PayPal');

-- Inserting into Payment
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3111, CAST('2024-04-25' AS DATE), 551);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3112, CAST('2023-01-02' AS DATE), 551);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3113, CAST('2021-04-09' AS DATE), 554);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3114, CAST('2023-01-19' AS DATE), 552);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3115, CAST('2024-05-01' AS DATE), 552);
INSERT INTO Payment (ID, "Date", Payment_Method_ID) VALUES (3116, CAST('2025-01-01' AS DATE), 555);

--Inserting into Vehicle
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (881, 'ABC123', 330, CAST('1999-07-12' AS DATE), 210, 1001);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (882, 'DEF455', 333, CAST('2002-07-12' AS DATE), 212, 1001);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (883, 'DDR001', 335, CAST('2015-07-12' AS DATE), 213, 1002);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (884, 'LHO442', 334, CAST('2009-07-12' AS DATE), 214, 1003);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (885, 'RNW222', 332, CAST('1991-07-12' AS DATE), 211, 1004);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (886, 'QWE987', 331, CAST('2022-07-12' AS DATE), 212, 1005);
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (887, 'AYE229', 330, CAST('1980-01-11' AS DATE), 214, 1003);

--Inserting into Service_Type
INSERT INTO Service_Type (ID, Name, Price) VALUES (2001, 'Oil Change', 250);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2002, 'Engine block replacement', 1500);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2003, 'Body reinforcement', 2000);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2004, 'Repaint', 5000);
INSERT INTO Service_Type (ID, Name, Price) VALUES (2005, 'Turbo upgrade', 850);

--Inserting into Vehicle_Fuel_Type
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (881, 440);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (882, 440);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (883, 441);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (884, 442);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (885, 444);
INSERT INTO Vehicle_Fuel_Type (Vehicle_ID, Fuel_Type_ID) VALUES (886, 441);

--Inserting into Shift
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (220, '08:00:00', '16:00:00', 110);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (221, '16:00:00', '23:59:59', 111);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (222, '08:00:00', '16:00:00', 112);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (223, '16:00:00', '23:59:59', 113);
INSERT INTO Shift (ID, StartTime, EndTime, Day_ID)
VALUES (224, '08:00:00', '16:00:00', 114);


INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (220, 3010);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (221, 3010);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (221, 3012);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (222, 3011);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (223, 3012);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (223, 3013);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (224, 3014);
INSERT INTO Schedule (Shift_ID, Employee_ID) VALUES (222, 3014);


INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9990, CAST('2021-05-01' AS DATE), CAST('2022-08-09' AS DATE), 881, 2001, 3111, 3010, 1001);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9991, CAST('2020-02-13' AS DATE), CAST('2021-03-10' AS DATE), 882, 2002, 3112, 3011, 1001);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9992, CAST('2022-04-17' AS DATE), CAST('2024-10-11' AS DATE), 883, 2003, 3113, 3012, 1002);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9993, CAST('2023-08-19' AS DATE), CAST('2025-01-01' AS DATE), 884, 2004, 3114, 3013, 1003);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9994, CAST('2018-12-12' AS DATE), CAST('2019-02-15' AS DATE), 885, 2005, 3115, 3014, 1004);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9995, CAST('2018-12-12' AS DATE), CAST('2019-02-15' AS DATE), 886, 2002, 3116, 3012, 1005);
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9996, CAST('2018-12-12' AS DATE), null, 887, 2002, null, 3012, 1003); --old BMW

COMMIT;


--REMOVING OF FOREIGN KEYS:
ALTER TABLE Customer_Info
    DROP CONSTRAINT Customer_Info_Customer;

ALTER TABLE Employee
    DROP CONSTRAINT Employee_Employee;

ALTER TABLE Employee_Info
    DROP CONSTRAINT Employee_Info_Employee;

ALTER TABLE Employee_Job
    DROP CONSTRAINT Employee_Job_Employee;

ALTER TABLE Employee_Job
    DROP CONSTRAINT Employee_Job_Job;

ALTER TABLE Payment
    DROP CONSTRAINT Payment_Payment_Method;

ALTER TABLE Schedule
    DROP CONSTRAINT Schedule_Employee;

ALTER TABLE Schedule
    DROP CONSTRAINT Schedule_Shift;

ALTER TABLE ServiceRecords
    DROP CONSTRAINT ServiceRecords_Customer;

ALTER TABLE ServiceRecords
    DROP CONSTRAINT ServiceRecords_Employee;

ALTER TABLE ServiceRecords
    DROP CONSTRAINT ServiceRecords_Payment;

ALTER TABLE ServiceRecords
    DROP CONSTRAINT ServiceRecords_Service_Type;

ALTER TABLE ServiceRecords
    DROP CONSTRAINT ServiceRecords_Vehicle;

ALTER TABLE Shift
    DROP CONSTRAINT Shift_Day;

ALTER TABLE Vehicle
    DROP CONSTRAINT Vehicle_Brand;

ALTER TABLE Vehicle
    DROP CONSTRAINT Vehicle_Customer;

ALTER TABLE Vehicle_Fuel_Type
    DROP CONSTRAINT Vehicle_Fuel_Type_Fuel_Type;

ALTER TABLE Vehicle_Fuel_Type
    DROP CONSTRAINT Vehicle_Fuel_Type_Vehicle;

ALTER TABLE Vehicle
    DROP CONSTRAINT Vehicle_Vehicle_Type;

--DROPPING TABLES:
DROP TABLE Brand;

DROP TABLE Customer;

DROP TABLE Customer_Info;

DROP TABLE Day;

DROP TABLE Employee;

DROP TABLE Employee_Info;

DROP TABLE Employee_Job;

DROP TABLE Fuel_Type;

DROP TABLE Job;

DROP TABLE Payment;

DROP TABLE Payment_Method;

DROP TABLE Schedule;

DROP TABLE ServiceRecords;

DROP TABLE Service_Type;

DROP TABLE Shift;

DROP TABLE Vehicle;

DROP TABLE Vehicle_Fuel_Type;

DROP TABLE Vehicle_Type;

-- End of file.

