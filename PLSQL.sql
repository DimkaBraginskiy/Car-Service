--PL/SQL Procedures:
--1st Procedure:
--Updating Salary of Employee.
--If the employee performed a service >= 2  - give him 10% raise to his salary
-- and show the message: 'employee + id + has got 15% salary increase.
--If the employee performaed a service <= 1 - give him 5% reduction from his salary
-- and show the message: 'employee + id + has got 5% salary reduction.

select EMPLOYEE_ID from SERVICERECORDS;

CREATE OR REPLACE PROCEDURE Proc1
AS

    --Counting employees from Service Records and counting amount of their IDs:
    CURSOR c1 IS
    SELECT EMPLOYEE_ID, COUNT(*) from SERVICERECORDS
    GROUP BY EMPLOYEE_ID;
    --variables which are needed to store info in a loop of a cursor: (can not have same names)
    empID NUMBER;
    empCount NUMBER;

BEGIN

    OPEN c1;
    LOOP
        --order of variables we fetch is important!
        FETCH c1 INTO empID, empCount;
        EXIT WHEN c1%NOTFOUND; --exiting loop when we do not have any records in cursor.

        --Can not use any select inside of Oracle-ifs and Exists instruction. to use exists we  need to create an additional variable.
        IF empCount >= 2 THEN
            UPDATE EMPLOYEE
            SET SALARY = SALARY + (SALARY * 0.15)
            WHERE ID = empID;
            DBMS_OUTPUT.PUT_LINE('employee '|| empID ||' has got 15% salary increase and has performed service ' || empCount || ' times.');
        ELSIF empCount <= 1 THEN
            UPDATE EMPLOYEE
            SET SALARY = SALARY - (SALARY * 0.5)
            WHERE ID = empID;
            DBMS_OUTPUT.PUT_LINE('employee '|| empID || ' has got 5% salary reduction and has performed service ' || empCount || ' times');
        end if;
    end loop;
    CLOSE c1;
end;

--Executing Procedure1:
CALL Proc1();
select * from EMPLOYEE;

--Procedure 2:
--inserting a new vehicle and checking whether the vehicle with the same license plate or id is not already created.
CREATE OR REPLACE PROCEDURE Proc2(
    vehicleID1        INTEGER,
    licensePlate1     VARCHAR2,
    vehicleTypeID1    INTEGER,
    productionDate1   DATE,
    brandID1          INTEGER,
    customerID1       INTEGER
)
AS
    idCount           INTEGER;
    licencePlateCount INTEGER;
BEGIN
    -- Counting occurences of specific vehicle ID:
    SELECT COUNT(*)
    INTO idCount
    FROM VEHICLE
    WHERE ID = vehicleID1;

    --counting number of times when the specific license plate occurred:
    SELECT COUNT(*)
    INTO licencePlateCount
    FROM VEHICLE
    WHERE LICENCEPLATE = licensePlate1;

    -- If vehicle ID or license plate exists, display a message
    IF idCount > 0 OR licencePlateCount > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Vehicle ID ' || vehicleID1 || ' or license plate ' || licensePlate1 || ' already exists.');
    ELSE
        -- Insert the new vehicle into the database
        INSERT INTO VEHICLE (ID, LICENCEPLATE, VEHICLE_TYPE_ID, PRODUCTIONDATE, BRAND_ID, CUSTOMER_ID)
        VALUES (vehicleID1, licensePlate1, vehicleTypeID1, productionDate1, brandID1, customerID1);
        DBMS_OUTPUT.PUT_LINE('As the vehicle does not exist in the database, it was created.');
    END IF;
END;

CALL Proc2(888, 'WELL001', 330, TO_DATE('1977-02-05', 'YYYY-MM-DD'), 214, 1003);

select * from VEHICLE;


--PL/SQL Triggers:
--Trigger 1:
--In this trigger we do not allow to insert a new customer when the customer in the database with the same name is already created.
--When it comes to a deletion of a Customer from a table then we will not allow to do it if our customer has unpaid service
--or in other words Payment_ID and END_DATE in ServiceRecords table with corresponding employee id are NULL.
CREATE OR REPLACE TRIGGER Trig1
BEFORE INSERT OR DELETE
ON CUSTOMER
FOR EACH ROW -- executing trigger for each row which is being changed or affected
DECLARE
    nameCount INTEGER;
    incompleteServiceCount NUMBER;
    updateNameCount NUMBER;
    updateSurnameCount NUMBER;

BEGIN
    IF INSERTING THEN
        --Checking if a customer with the same name already exists:
        SELECT COUNT(*) INTO nameCount
        FROM CUSTOMER
        WHERE NAME = :NEW.NAME;

        IF nameCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20100, 'The name has to be different because it already exists in the table.');
        end if;
    ELSIF DELETING THEN
         --Not allowing to delete a Customer with unfinished service and payment:
        SELECT COUNT(*) INTO incompleteServiceCount
        FROM SERVICERECORDS sr
        WHERE sr.VEHICLE_ID IN (
            SELECT v.ID
            FROM VEHICLE v
            WHERE v.CUSTOMER_ID = :OLD.ID
            )
        AND sr.END_DATE IS NULL
        AND sr.PAYMENT_ID IS NULL;

        IF incompleteServiceCount > 0 THEN
            RAISE_APPLICATION_ERROR(-20100, 'Can not delete a Customer as it has a car with incomplete service and payment');
        end if;
    end if;
end;


select * from CUSTOMER;
INSERT INTO Customer (ID, Name, Surname, BirthDate)
VALUES (1003, 'Alexi', 'Forheads', TO_DATE('1984-11-03', 'YYYY-MM-DD'));


SELECT * FROM SERVICERECORDS WHERE CUSTOMER_ID = 1003;

DELETE FROM CUSTOMER WHERE ID = 1003;
SELECT * FROM CUSTOMER;



--end;
--Trigger 2:
--Not allowing to change payment status in ServiceRecords table if end_date is still null
-- as we want to have a payment only after the service has been done.
CREATE OR REPLACE TRIGGER RESTRICT_UPDATE_OF_PAYMENT
BEFORE UPDATE OR INSERT
ON SERVICERECORDS
FOR EACH ROW
DECLARE
    empCount INTEGER;
BEGIN
    IF UPDATING THEN
        IF :OLD.PAYMENT_ID IS NULL AND :NEW.PAYMENT_ID IS NOT NULL THEN
            IF :NEW.END_DATE IS NULL THEN
                 RAISE_APPLICATION_ERROR(-20100, 'Can not update payment id from null as the end date is still null.');
            end if;
        end if;
    ELSIF INSERTING THEN
            SELECT COUNT(*) INTO empCount FROM SERVICERECORDS WHERE EMPLOYEE_ID = :NEW.EMPLOYEE_ID;
            IF empCount >= 3 THEN
                RAISE_APPLICATION_ERROR(-20100,'Can not insert new service record as employee is overloaded.');
            end if;
    end if;
end;

--run before running update for trigger2:
SELECT * FROM SERVICERECORDS;
SELECT * FROM PAYMENT;
INSERT INTO PAYMENT (ID, "Date", PAYMENT_METHOD_ID)
VALUES (3117, TO_DATE('2025-01-07','YYYY-MM-DD'), 552);

UPDATE SERVICERECORDS
SET PAYMENT_ID = 3117
WHERE ID = 9996;
--insert for trigger2:
INSERT INTO ServiceRecords (ID, Begin_Date, End_Date, Vehicle_ID, Service_Type_ID, Payment_ID, Employee_ID, Customer_ID)
VALUES (9997, TO_DATE('2018-12-12', 'YY-MM-DD'), TO_DATE('2019-02-15', 'YY-MM-DD'), 886, 2002, 3116, 3012, 1005);






