# The Database Description:

The Database is able to represent us all sevices which were done during a period of time with detailed description such as start date and end date of the service, car on which work was performed, it's owner as a customer, payment which was performed for a some type of service.

The Database manages efficently Schedules of each employee, their shifts per each day when they are obliged to work. It also manages jobs of all employees, their salaries and additional info such as their contact number. 
Of course, the database manages vehicles, their owners and multiple specifications of a car such as: Vehicle type which is very important to know and have a perspective on which type of a car we need to work, for example the vehicle may be a Sedan or may be a Universal and many more. 
Also there is a fuel type which also a key aspect of Vehicle storage the same as It`s brand.

The Database gives us ability to manage payments which were submitted for one or another type of service which has multiple types and pricings based on complexity of car's repair or service.
This Database stores all needed info in each entity to ensure that it is informative and has a detailed description of each operation performed.

---
# Textual description of entities and their connections:
---

## Customer entity:
This entity represents basic knowledge about a Customer such as:  
Its own ID set to Primary Key (PK),  
Name of type varchar representing Customer's name,  
Surname of type varchar representing Customer's surname,  
BirthDate of type date which represents customer's date of birth.

From Customer entity there are three connections pointing to ServiceRecords entity, Vehicle entity and Customer_Info entity.  
One customer can have many service records and one customer can have many vehicles.  
Also the customer has additional info about him/her and it is stored in separate entity with connection 0to1.

---

## Employee entity:
This entity represents Employee and basic needed values.  
It consists of:  
Its own ID set as Primary Key (PK),  
HireDate of type date which specifies the date when the employee was hired,  
Salary of type integer as we want to know how much Employee earns monthly,  
Name of varchar type as we want to know his/her name,  
Surname of varchar type as we want to know his/her surname,  
BirthDate of type date which represents Employee's date of birth,  
Supervisor_ID it is a Foreign Key (FK) which also may be nullable and which represents that an Employee can have a Supervisor or have this field null if the Person does not have any supervisors or/and he is a Supervisor by himself.

There are 5 connections from Employee entity:  
- Zero-to-One connection to Employee info as it is the table where additional info about the Employee is stored,  
- One-to-Many connection to the Schedule table as a part of Many-to-Many connection (One Employee can be in many shifts and one shift can have many employees),  
- One-to-Many connection to Employee_Job as a part of Many-to-Many connection (One employee can have many jobs and one job can be assigned to many employees),  
- Recursive connection as a supervisor of the employee which can be null if an employee is a supervisor by himself.

---

## Vehicle entity:
This entity represents a vehicle with its needed attributes such as:  
ID as a unique id set as Primary Key (PK),  
LicencePlate field of varchar type as we want to know the Licence plate of a car,  
Vehicle_Type_ID is an ID to the dictionary table stating about vehicle's type (e.g. Sedan, Coupe...),  
ProductionDate is a field of date type in which we know how old is the vehicle,  
Brand_Id is also a Foreign Key (FK) id from dictionary table stating about car's brand (e.g. Nissan, Toyota, Honda...),  
Customer_ID is a Foreign Key (FK) to the owner of a car.

From Vehicle entity there are 5 connections:  
- Connection from Customer to Vehicle as One-to-Many as one Customer can have many Vehicles,  
- One-to-Many to ServiceRecords as one Vehicle can be in many Service Records,  
- One-to-Many from Vehicle_Type to Vehicle as Many vehicles can be of one type,  
- One-to-Many from Brand to Vehicle as Many vehicles can be of one brand,  
- One-to-Many from Vehicle to Vehicle_Fuel_Type as a part of Many-to-Many connection (e.g. hybrid cars).

---

## Vehicle_Type entity:
It is a dictionary table with types of vehicles (e.g. sedan, coupe, etc.).  
It has only one One-to-Many connection to the Vehicle.

---

## Brand entity:
It is a dictionary table with brands of vehicles (e.g. Honda, Datsun, Subaru, etc.).  
It has only one One-to-Many connection to the Vehicle.

---

## Vehicle_Fuel_Type entity:
It is a joining table to which there are two connections from Vehicle and Fuel_Type entities, and it is a middle part of Many-to-Many connection between Vehicle and Fuel_Type as one Vehicle can have many fuel types and one Fuel Type can be assigned to many vehicles.

---

## Fuel_Type entity:
It is a dictionary table with types of fuel of vehicles (e.g. Diesel, Gasoline, etc.).  
It has a connection to a Vehicle_Fuel_Type entity as a part of Many-to-Many connection.

---

## ServiceRecords table:
This is the table of Service Records which keeps history of all operations done on cars which includes the following fields:  
- It has its own ID set as Primary Key (PK),  
- Being_Date of a service as we want to know when the work on a specific car has begun,  
- End_Date of a service as we want to know when the work on a specific car has been finished (it can be null if we may not know the End Date yet, e.g. "old BMW has broken down with everything..."),  
- Vehicle_Id is a Foreign Key (FK) from a Vehicle entity on which the service work is being performed,  
- Customer_Id is a Foreign Key (FK) from a Customer entity which states whose car the work is being performed,  
- Employee_Id is a Foreign Key (FK) from an Employee entity which tells us who has been performing the work on a vehicle,  
- Service_Type_ID is a Foreign Key (FK) from Service_Type entity which tells us a specification of a work and a Price assigned to the work,  
- Payment_ID is a Foreign Key (FK) from Payment entity which tells us about Date of transaction and a Method which was applied.

From/To ServiceRecords entity there are 5 connections:  
- One-To-Many from Vehicle to ServiceRecords as one Vehicle can be in Many Service Records,  
- One-To-Many from Customer to ServiceRecords as one Customer can be in Many Service Records,  
- One-To-Many from Employee to ServiceRecords as one Employee can be in Many Service Records,  
- One-to-One from ServiceRecords to Payment as only one payment can be performed on a specific service,  
- One-to-Many from Service_Type to ServiceRecords as One service type can be in many service records.

---

## Service_Type table:
This is a dictionary table which stores types of service (e.g. replacement of intercooler).  
This entity stores:  
- its own ID as Primary Key (ID),  
- Name of varchar type,  
- Price as integer.  
It is connected only to one table - ServiceRecords.

---

## Payment table:
This table stores all the payments performed for the service and it has such fields:  
- ID as unique Primary Key (PK),  
- Date of type date to store the date when the transaction was performed,  
- Payment_Method_ID is a Foreign Key (FK) to the dictionary table which has payment methods.

There are two connections from this table:  
- One-to-One to ServiceRecords table as only one payment can be performed for only one service,  
- One-to-Many from Payment_Method as one payment method can be assigned to multiple Payments.

---

## Payment_Method table:
This is a dictionary table which stores payment methods (Name of varchar type) with their unique IDs as PK.  
This table is connected only to one entity - the Payment entity.

---

## Employee_Job table:
This is a joining table which is the middle of Many-to-Many connection between Employee entity and Job entity.  
It has all its fields set as PK for both Employee and Job IDs.

---

## Job table:
This entity stores all possible jobs and has two fields:  
- ID as a Primary Key,  
- Name of varchar type.  
It is a part of Many-to-Many connection such that one Employee can have many Jobs and one Job can be assigned to many employees.

---

## Schedule table:
It is a joining table which is the middle part of Many-to-Many connection and it is between Employee and Shift entities.  
It has two fields as IDs of those two entities stated previously and set as Primary Key (PK).

---

## Shift table:
This table stores data about shifts:  
- It has its own ID set as PK,  
- StartTime of date type,  
- EndTime of date type,  
- Day_ID which is a Foreign Key from Day table.  
It has a connection to a schedule table as well as to Day entity.
-----------------------------------------------------------------------------------------------------------
Day table:
This table stores days and has only it's own ID as PK and a Name of varchar type.
It is connected only to Shift entity by One-to-Many connections so One day can be assigned to many Shifts.
-----------------------------------------------------------------------------------------------------------
