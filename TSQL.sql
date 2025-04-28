--TSQL Procedures and Triggers:
--Procedure 1:
--If the Employee who is a Manager and has less or equal than 2 days of work per week
--we assign him additionally to existing job another one as an Accountant.
select * from Employee;
select * from Schedule;
select * from Shift;
select * from day;
select * from Employee_Job;
select * from Job;

ALTER PROCEDURE ASSIGN_ADDITIONAL_JOB
AS
BEGIN
    DECLARE @managerID INT;
    DECLARE @accountantJobID INT;
--     DECLARE @accountantShiftID INT;

    SELECT @accountantJobID = ID
    FROM Job
    where Name = 'Accountant';

--     SELECT @accountantShiftID = S.Shift_ID
--     FROM Schedule S
--     JOIN Employee E ON S.Employee_ID = E.ID
--     JOIN Employee_Job EJ ON E.ID = EJ.Employee_ID
--     WHERE EJ.Job_ID = @accountantJobID;

    --Looping through managers working less than 2 days:
    DECLARE c1 CURSOR FOR
    SELECT E.ID FROM Employee E
    JOIN Employee_Job EJ ON E.ID = EJ.Employee_ID
    JOIN JOB J ON EJ.Job_ID = J.ID
    WHERE J.Name = 'Manager'
    GROUP BY E.ID;

    OPEN C1;

    FETCH NEXT FROM C1 INTO @managerID;

    WHILE @@FETCH_STATUS = 0
    BEGIN

        IF (
            SELECT COUNT(*) FROM SCHEDULE
            WHERE Employee_ID = @managerID
            ) <= 2
            BEGIN
                INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (@accountantJobID, @managerID)
                PRINT 'The Manager with id ' + CAST(@managerID AS VARCHAR) + ' has been assigned to another job as he is not overloaded.';
--                 INSERT INTO SCHEDULE (Shift_ID, Employee_ID) VALUES (@accountantShiftID, @managerID);
--                 PRINT 'The Manager with id ' + CAST(@managerID AS VARCHAR) + ' has been added to another schedule of an accountant.';
            end;
        FETCH NEXT FROM C1 INTO @managerID;
    end;

    CLOSE C1;
    DEALLOCATE C1;
end;

EXECUTE ASSIGN_ADDITIONAL_JOB;
--if procedure worked an if needed to run once more:(delete from table)
delete from Employee_Job where Job_ID = 7773 and Employee_ID = 3011;
select * from Employee_Job;

--Procedure 2:
--If the interated vehicle has service type as Body reinforcement we change Vehicles type to a Sports Car:
ALTER PROCEDURE SPORTS_CAR_TYPE_ASSIGNMENT
AS
BEGIN
    DECLARE @vehicleID INT;
    declare @sportsCarId INT;

    SELECT @sportsCarId = ID
    FROM Vehicle_Type
    WHERE NAME = 'SportsCar';

    DECLARE c1 CURSOR FOR
    SELECT V.ID FROM VEHICLE V
    JOIN ServiceRecords SR ON V.ID = SR.Vehicle_ID
    JOIN Service_Type ST ON SR.Service_Type_ID = ST.ID
    WHERE ST.NAME = 'Body reinforcement';


    OPEN C1;

    FETCH NEXT FROM C1 INTO @vehicleID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        UPDATE Vehicle
        SET Vehicle_Type_ID = @sportsCarId
        where ID = @vehicleID;
        PRINT 'The vehicle with ID ' + CAST(@vehicleID AS VARCHAR) + ' has been updated to Sports Car as it has service of type body reinforcement.';

        FETCH NEXT FROM C1 INTO @vehicleID;
    end;
    close c1;
    deallocate c1;
end;

EXECUTE SPORTS_CAR_TYPE_ASSIGNMENT;

select * from Service_Type;
select * from ServiceRecords;
select * from Vehicle;
select * from Vehicle_Type;
--If u want to run once more:
update vehicle set Vehicle_Type_ID = 335 where id = 883;


--trigger 1:
--Not allowing to update a vehicle if the license plate is the same as some in database and showing corresponding message
--Not allowing to insert a vehicle of brand named BMW and if it is old.
ALTER TRIGGER TRIG1
ON VEHICLE
FOR INSERT, UPDATE --FOR - EXECUTES AFTER CHANGES IN DB; INSTEAD OF - EXECUTES INSTEAD PERFORMING OPERATION ON DB; ALSO NO FOREACH ROW INSTR.
AS
BEGIN
    --CHECKING FOR UPDATING:
    IF EXISTS(SELECT 1 FROM INSERTED) AND EXISTS(SELECT 1 FROM DELETED)
    BEGIN
        IF EXISTS(
            SELECT 1 FROM INSERTED I
            WHERE EXISTS (
                SELECT 1 FROM VEHICLE V
                WHERE V.LicencePlate = I.LicencePlate
            )
        )
        BEGIN
            RAISERROR ('Duplicate licence plate can not be assigned to a car',1,1);
            ROLLBACK;
            RETURN;
        end
    end
    --CHECKING FOR INSERTING
    ELSE IF EXISTS (
        SELECT 1 FROM INSERTED I
        JOIN BRAND B ON I.Brand_ID = B.ID
        WHERE B.Name = 'BMW' AND I.PRODUCTIONDATE < '1970-02-02'
    )
    BEGIN
        RAISERROR ('Can not add an old BMW as its hard to get parts for it!',1,1);
        ROLLBACK;
    end
end;


--Checking the trigger1 by inserting a row which falls into condition
INSERT INTO Vehicle (ID, LicencePlate, Vehicle_Type_ID, ProductionDate, Brand_ID, Customer_ID)
VALUES (889, 'TSQL111', 330, CAST('1950-01-11' AS DATE), 214, 1001); --214 for bmw and old date
DELETE FROM VEHICLE WHERE ID = 889;

SELECT * FROM Vehicle;

select * from Brand;

--Checking if the trigger1 works when we insert a new value.
UPDATE VEHICLE
SET LicencePlate = 'AYE229'
WHERE ID = 886;

select * from Employee_Job;
INSERT INTO Employee_Job (Job_ID, Employee_ID) VALUES (7774, 3014);--inserted so the employee has two jobs.


--Trigger 2:
--Not allowing to insert or update an employee with birthdate set to the future time (using cursor ro iterate through each row of table):
ALTER TRIGGER FUTURE_EMPLOYEE_DATE_TRIGGER
on EMPLOYEE
FOR INSERT,UPDATE
AS
BEGIN
    DECLARE @employeeID INT, @birthDate DATE;

    DECLARE c1 CURSOR FOR
    SELECT ID, BirthDate
    FROM INSERTED;

    OPEN c1;

    FETCH NEXT FROM c1 INTO @employeeID, @birthDate;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @birthDate > GETDATE()
        BEGIN
            RAISERROR ('Employee can not have BirthDate in the future',1,1);
            ROLLBACK;
            CLOSE c1;
            DEALLOCATE c1;
            RETURN;
        end

        FETCH NEXT FROM c1 INTO @employeeID, @birthDate;
    END

    CLOSE c1;
    DEALLOCATE c1;

end;

INSERT INTO Employee (ID, HireDate, Salary, Name, Surname, BirthDate, Supervisor_ID)
VALUES (3019, CAST('2018-05-20' AS DATE), 4500, 'John', 'Cowart', CAST('2030-01-05'AS DATE), 3013);

UPDATE Employee
set BirthDate = CAST('2030-01-05'AS DATE)
where id = 3010;
