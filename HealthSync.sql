/**
    Health Sync - Health Management Application
    
    This SQL script sets up the Health Sync database,
    relationships, and data to support comprehensive hospital management functionalities.
   
*/

-- Drop and Create Database
DROP DATABASE IF EXISTS Healthsync;
CREATE DATABASE IF NOT EXISTS Healthsync;
USE Healthsync;

/* 1. Roles Table
   Static Data having all roles and personas for Staff
*/
DROP TABLE IF EXISTS Roles;
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL,
    Description TEXT,
    Permissions VARCHAR(255)
);

/* Insert Roles */
INSERT INTO Roles (RoleID, RoleName, Description, Permissions) VALUES
(1, 'Administrator', 'Full access to all system functionalities', 'Manage Users, Manage Roles, View Reports'),
(2, 'Doctor', 'Medical staff responsible for diagnosing and treating patients', 'View Patient Records, Prescribe Medications, Schedule Appointments'),
(3, 'Nurse', 'Support staff responsible for patient care and monitoring', 'Assist Doctors, Administer Medications, Monitor Patients'),
(4, 'Receptionist', 'Responsible for managing patient appointments and general administration', 'Schedule Appointments, Update Patient Information'),
(5, 'Pharmacist', 'Responsible for managing and dispensing medications', 'Prescribe Medications, Update Inventory'),
(6, 'Lab Technician', 'Responsible for performing laboratory tests and reporting results', 'Perform Tests, Update Lab Results'),
(7, 'Accountant', 'Responsible for managing the hospital\'s finances', 'Generate Bills, Process Payments, View Financial Reports'),
(8, 'HR Manager', 'Responsible for handling employee-related tasks and welfare', 'Manage Staff Records, Process Leaves'),
(9, 'IT Support', 'Provide technical support and maintenance of hospital systems', 'Manage IT Infrastructure, Resolve Technical Issues'),
(10, 'Surgeon', 'Specialized in performing surgeries', 'Perform Surgeries, Diagnose Surgical Conditions'),
(11, 'Emergency Medical Technician', 'Provide initial care in emergencies', 'Assess Patients, Provide Emergency Care'),
(12, 'Radiologist', 'Specialized in performing and interpreting medical imaging tests', 'View X-Rays, MRIs, CT Scans'),
(13, 'Psychiatrist', 'Responsible for diagnosing and treating mental health disorders', 'Prescribe Psychiatric Medications, Manage Therapy Sessions'),
(14, 'Physiotherapist', 'Help patients with physical rehabilitation', 'Provide Physical Therapy, Monitor Patient Progress'),
(15, 'Dietician', 'Responsible for managing patient diets and nutrition', 'Create Diet Plans, Advise on Nutrition'),
(16, 'Social Worker', 'Provide support for patients and families during treatment', 'Provide Counseling, Coordinate with Families'),
(17, 'Laboratory Manager', 'Oversee laboratory operations and staff', 'Manage Lab Staff, Ensure Lab Standards'),
(18, 'Radiology Technician', 'Assist in performing radiological procedures', 'Prepare Patients for Radiological Tests'),
(19, 'Medical Assistant', 'Assist doctors and nurses with medical tasks and procedures', 'Take Vital Signs, Assist in Medical Procedures'),
(20, 'Admin Assistant', 'Support administrative staff with daily tasks', 'Handle Correspondence, Manage Office Supplies');


/* 2. Departments Table
   Contains department details with additional columns
*/
DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT
);

/* Insert Departments */
INSERT INTO Departments (DepartmentID, DepartmentName, Description) VALUES
(1, 'Cardiology', 'Department dealing with heart-related conditions.'),
(2, 'Neurology', 'Department dealing with nervous system disorders.'),
(3, 'Pediatrics', 'Department focused on child healthcare.'),
(4, 'Orthopedics', 'Department specializing in musculoskeletal issues.'),
(5, 'Oncology', 'Department dedicated to cancer treatment and research.');

/* 3. Staff Table
   Contains all staff details with enhanced columns
*/

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT, 
    RoleID INT,
    DateOfBirth DATE,
    Address TEXT,
    HireDate DATE,
    Salary DECIMAL(10,2),
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

/* Now insert Staff with DepartmentID */
INSERT INTO Staff (StaffID, FirstName, LastName, DepartmentID, RoleID, DateOfBirth, Address, HireDate, Salary, ContactNumber, Email) VALUES
(1, 'John', 'Doe', 1, 1, '1980-01-15', '123 Main St, City', '2010-06-01', 85000.00, '123-456-7890', 'john.doe@hospital.com'),
(2, 'Jane', 'Smith', 2, 2, '1985-02-20', '456 Oak St, City', '2015-08-10', 95000.00, '123-456-7891', 'jane.smith@hospital.com'),
(3, 'Emily', 'Jones', 3, 3, '1990-03-25', '789 Pine St, City', '2017-11-05', 60000.00, '123-456-7892', 'emily.jones@hospital.com'),
(4, 'Michael', 'Brown', 4, 4, '1982-05-30', '234 Maple St, City', '2012-04-12', 55000.00, '123-456-7893', 'michael.brown@hospital.com'),
(5, 'Sophia', 'Williams', 4, 5, '1988-06-12', '567 Elm St, City', '2016-07-22', 72000.00, '123-456-7894', 'sophia.williams@hospital.com'),
(6, 'Liam', 'Davis', 5, 6, '1992-07-19', '890 Cedar St, City', '2020-01-18', 65000.00, '123-456-7895', 'liam.davis@hospital.com'),
(7, 'Olivia', 'Martinez', 3, 2, '1989-08-02', '345 Birch St, City', '2013-10-15', 80000.00, '123-456-7896', 'olivia.martinez@hospital.com'),
(8, 'James', 'Miller', 5, 7, '1978-09-22', '678 Ash St, City', '2005-03-30', 90000.00, '123-456-7897', 'james.miller@hospital.com'),
(9, 'Charlotte', 'Garcia', 4, 1, '1991-10-10', '123 Spruce St, City', '2018-02-05', 68000.00, '123-456-7898', 'charlotte.garcia@hospital.com'),
(10, 'Lucas', 'Hernandez', 2, 3, '1984-11-11', '234 Fir St, City', '2014-09-20', 75000.00, '123-456-7899', 'lucas.hernandez@hospital.com'),
(11, 'Amelia', 'Wilson', 5, 4, '1995-12-01', '890 Oak St, City', '2019-06-12', 54000.00, '123-456-7900', 'amelia.wilson@hospital.com'),
(12, 'Ethan', 'Moore', 3, 9, '1990-01-20', '567 Birch St, City', '2017-03-25', 48000.00, '123-456-7901', 'ethan.moore@hospital.com'),
(13, 'Avery', 'Taylor', 4, 2, '1987-02-14', '234 Pine St, City', '2014-05-17', 76000.00, '123-456-7902', 'avery.taylor@hospital.com'),
(14, 'Mason', 'Anderson', 1, 1, '1983-07-07', '789 Oak St, City', '2010-02-09', 88000.00, '123-456-7903', 'mason.anderson@hospital.com'),
(15, 'Isabella', 'Thomas', 2, 5, '1994-08-13', '890 Maple St, City', '2021-11-10', 65000.00, '123-456-7904', 'isabella.thomas@hospital.com'),
(16, 'Alexander', 'Jackson', 3, 6, '1993-04-30', '345 Cedar St, City', '2016-01-25', 68000.00, '123-456-7905', 'alexander.jackson@hospital.com'),
(17, 'Mia', 'White', 2, 7, '1992-10-15', '567 Ash St, City', '2019-04-12', 70000.00, '123-456-7906', 'mia.white@hospital.com'),
(18, 'Benjamin', 'Martinez', 3, 8, '1981-03-19', '234 Oak St, City', '2014-11-05', 73000.00, '123-456-7907', 'benjamin.martinez@hospital.com'),
(19, 'Harper', 'Roberts', 1, 3, '1996-11-25', '789 Birch St, City', '2021-08-18', 55000.00, '123-456-7908', 'harper.roberts@hospital.com'),
(20, 'Jack', 'Wilson', 5, 1, '1990-09-01', '123 Maple St, City', '2015-12-01', 81000.00, '123-456-7909', 'jack.wilson@hospital.com');


/* 4. Attendance Table
   Tracks staff attendance details
*/
DROP TABLE IF EXISTS Attendance;
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY,
    StaffID INT,
    Date DATE,
    TimeIn TIME,
    TimeOut TIME,
    Shift ENUM('Morning', 'Evening', 'Night', 'Day Shift', 'Late Night') NOT NULL, 
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

/* Insert Attendance Records */
INSERT INTO Attendance (AttendanceID, StaffID, Date, TimeIn, TimeOut, Shift) VALUES
(1, 1, '2024-10-01', '08:00:00', '16:00:00', 'Morning'),
(2, 2, '2024-10-01', '09:00:00', '17:00:00', 'Day Shift'),
(3, 3, '2024-10-01', '10:00:00', '18:00:00', 'Day Shift'),
(4, 4, '2024-10-01', '07:00:00', '15:00:00', 'Morning'),
(5, 5, '2024-10-01', '12:00:00', '20:00:00', 'Evening'),
(6, 6, '2024-10-01', '13:00:00', '21:00:00', 'Evening'),
(7, 7, '2024-10-01', '14:00:00', '22:00:00', 'Late Night'),
(8, 8, '2024-10-01', '08:30:00', '16:30:00', 'Morning'),
(9, 9, '2024-10-01', '09:30:00', '17:30:00', 'Day Shift'),
(10, 10, '2024-10-01', '07:45:00', '15:45:00', 'Morning'),
(11, 11, '2024-10-01', '06:00:00', '14:00:00', 'Morning'),
(12, 12, '2024-10-01', '10:00:00', '18:00:00', 'Day Shift'),
(13, 13, '2024-10-01', '08:15:00', '16:15:00', 'Morning'),
(14, 14, '2024-10-01', '11:00:00', '19:00:00', 'Day Shift'),
(15, 15, '2024-10-01', '07:30:00', '15:30:00', 'Morning'),
(16, 16, '2024-10-01', '09:00:00', '17:00:00', 'Day Shift'),
(17, 17, '2024-10-01', '13:00:00', '21:00:00', 'Evening'),
(18, 18, '2024-10-01', '15:00:00', '23:00:00', 'Late Night'),
(19, 19, '2024-10-01', '10:30:00', '18:30:00', 'Day Shift'),
(20, 20, '2024-10-01', '08:00:00', '16:00:00', 'Morning'),
(21, 1, '2024-10-02', '08:00:00', '16:00:00', 'Morning'),
(22, 2, '2024-10-02', '09:00:00', '17:00:00', 'Day Shift'),
(23, 3, '2024-10-02', '10:00:00', '18:00:00', 'Day Shift'),
(24, 4, '2024-10-02', '07:00:00', '15:00:00', 'Morning'),
(25, 5, '2024-10-02', '12:00:00', '20:00:00', 'Evening'),
(26, 6, '2024-10-02', '13:00:00', '21:00:00', 'Evening'),
(27, 7, '2024-10-02', '14:00:00', '22:00:00', 'Late Night'),
(28, 8, '2024-10-02', '08:30:00', '16:30:00', 'Morning'),
(29, 9, '2024-10-02', '09:30:00', '17:30:00', 'Day Shift'),
(30, 10, '2024-10-02', '07:45:00', '15:45:00', 'Morning'),
(31, 5, '2024-10-01', '12:00:00', '20:00:00', 'Evening'),
(32, 6, '2024-10-01', '13:00:00', '21:00:00', 'Evening'),
(33, 7, '2024-10-01', '14:00:00', '22:00:00', 'Late Night'),
(34, 8, '2024-10-01', '08:30:00', '16:30:00', 'Morning'),
(35, 9, '2024-10-01', '09:30:00', '17:30:00', 'Day Shift'),
(36, 10, '2024-10-01', '07:45:00', '15:45:00', 'Morning'),
(37, 11, '2024-10-01', '06:00:00', '14:00:00', 'Morning'),
(38, 12, '2024-10-01', '10:00:00', '18:00:00', 'Day Shift'),
(39, 13, '2024-10-01', '08:15:00', '16:15:00', 'Morning'),
(40, 14, '2024-10-01', '11:00:00', '19:00:00', 'Day Shift'),
(41, 15, '2024-10-01', '07:30:00', '15:30:00', 'Morning'),
(42, 16, '2024-10-01', '09:00:00', '17:00:00', 'Day Shift'),
(43, 17, '2024-10-01', '13:00:00', '21:00:00', 'Evening'),
(44, 18, '2024-10-01', '15:00:00', '23:00:00', 'Late Night'),
(45, 19, '2024-10-01', '10:30:00', '18:30:00', 'Day Shift'),
(46, 20, '2024-10-01', '08:00:00', '16:00:00', 'Morning'),
(47, 1, '2024-10-02', '08:00:00', '16:00:00', 'Morning'),
(48, 2, '2024-10-02', '09:00:00', '17:00:00', 'Day Shift'),
(49, 3, '2024-10-02', '10:00:00', '18:00:00', 'Day Shift'),
(50, 4, '2024-10-02', '07:00:00', '15:00:00', 'Morning');


/* 5. Leaves Table
   Records leave taken by staff
*/
DROP TABLE IF EXISTS Leaves;
CREATE TABLE Leaves (
    LeaveID INT PRIMARY KEY,
    StaffID INT,
    LeaveType ENUM('Sick', 'Vacation', 'Personal', 'Other') NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Status ENUM('Pending', 'Approved', 'Rejected') NOT NULL,
    Reason TEXT, 
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

/* Insert Leave Records */
INSERT INTO Leaves (LeaveID, StaffID, LeaveType, StartDate, EndDate, Status, Reason) VALUES
(1, 1, 'Sick', '2024-10-01', '2024-10-02', 'Approved', 'Flu symptoms, unable to work'),
(2, 2, 'Vacation', '2024-10-05', '2024-10-10', 'Approved', 'Family vacation'),
(3, 3, 'Personal', '2024-10-08', '2024-10-08', 'Approved', 'Personal errands and appointments'),
(4, 4, 'Sick', '2024-10-10', '2024-10-12', 'Pending', 'Severe cold and fever'),
(5, 5, 'Vacation', '2024-10-15', '2024-10-20', 'Pending', 'Rest and relaxation'),
(6, 6, 'Sick', '2024-10-20', '2024-10-21', 'Approved', 'Migraine, need rest'),
(7, 7, 'Sick', '2024-10-22', '2024-10-23', 'Rejected', 'Not feeling well, but was asked to come in'),
(8, 8, 'Personal', '2024-10-23', '2024-10-23', 'Approved', 'Attending a personal appointment'),
(9, 9, 'Vacation', '2024-10-25', '2024-10-30', 'Approved', 'Traveling abroad'),
(10, 10, 'Sick', '2024-10-29', '2024-10-31', 'Approved', 'Injury from accident, resting at home'),
(11, 11, 'Personal', '2024-10-31', '2024-10-31', 'Approved', 'Medical check-up'),
(12, 12, 'Sick', '2024-11-01', '2024-11-03', 'Pending', 'Severe headache and dizziness'),
(13, 13, 'Vacation', '2024-11-05', '2024-11-07', 'Pending', 'Annual leave'),
(14, 14, 'Sick', '2024-11-10', '2024-11-11', 'Approved', 'Back pain, unable to sit for long hours'),
(15, 15, 'Vacation', '2024-11-12', '2024-11-15', 'Approved', 'Holiday trip with family');


/* 6. Patients Table
   Contains patient details with additional columns
*/
DROP TABLE IF EXISTS Patients;
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    ContactNumber VARCHAR(15),
    Address TEXT,
    EmergencyContactName VARCHAR(100), 
    EmergencyContactNumber VARCHAR(15), 
    BloodType ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-')
);

/* Insert Patient Details */
INSERT INTO Patients (PatientID, FirstName, LastName, DateOfBirth, Gender, ContactNumber, Address, EmergencyContactName, EmergencyContactNumber, BloodType) VALUES
(1, 'John', 'Doe', '1985-06-15', 'Male', '555-1234', '123 Elm St, Springfield, IL', 'Jane Doe', '555-5678', 'O+'),
(2, 'Mary', 'Smith', '1992-03-22', 'Female', '555-2345', '456 Oak St, Springfield, IL', 'Sam Smith', '555-6789', 'A+'),
(3, 'James', 'Johnson', '1978-11-10', 'Male', '555-3456', '789 Pine St, Springfield, IL', 'Linda Johnson', '555-7890', 'B+'),
(4, 'Patricia', 'Williams', '1980-04-07', 'Female', '555-4567', '101 Maple St, Springfield, IL', 'Tom Williams', '555-8901', 'O-'),
(5, 'Michael', 'Brown', '1990-08-23', 'Male', '555-5678', '202 Birch St, Springfield, IL', 'Sophia Brown', '555-9012', 'AB+'),
(6, 'Elizabeth', 'Jones', '1988-02-15', 'Female', '555-6789', '303 Cedar St, Springfield, IL', 'George Jones', '555-0123', 'A-'),
(7, 'William', 'Garcia', '1983-07-19', 'Male', '555-7890', '404 Redwood St, Springfield, IL', 'Maria Garcia', '555-1234', 'B-'),
(8, 'Linda', 'Martinez', '1995-05-10', 'Female', '555-8901', '505 Willow St, Springfield, IL', 'Jose Martinez', '555-2345', 'O+'),
(9, 'David', 'Rodriguez', '1972-09-14', 'Male', '555-9012', '606 Pine St, Springfield, IL', 'Eva Rodriguez', '555-3456', 'AB-'),
(10, 'Susan', 'Hernandez', '1984-12-30', 'Female', '555-0123', '707 Maple St, Springfield, IL', 'Carlos Hernandez', '555-4567', 'A+'),
(11, 'Joseph', 'Lopez', '1991-10-25', 'Male', '555-1234', '808 Oak St, Springfield, IL', 'Diana Lopez', '555-5678', 'B+'),
(12, 'Karen', 'Gonzalez', '1987-01-17', 'Female', '555-2345', '909 Birch St, Springfield, IL', 'Manuel Gonzalez', '555-6789', 'O+'),
(13, 'Charles', 'Wilson', '1965-06-05', 'Male', '555-3456', '1010 Cedar St, Springfield, IL', 'Nancy Wilson', '555-7890', 'A+'),
(14, 'Nancy', 'Anderson', '1973-11-23', 'Female', '555-4567', '1111 Redwood St, Springfield, IL', 'Paul Anderson', '555-8901', 'B+'),
(15, 'Daniel', 'Thomas', '1989-03-09', 'Male', '555-5678', '1212 Willow St, Springfield, IL', 'Rita Thomas', '555-9012', 'O-'),
(16, 'Helen', 'Taylor', '1994-05-18', 'Female', '555-6789', '1313 Pine St, Springfield, IL', 'Stephen Taylor', '555-0123', 'AB+'),
(17, 'Mark', 'Moore', '1980-08-25', 'Male', '555-7890', '1414 Maple St, Springfield, IL', 'Olivia Moore', '555-1234', 'B+'),
(18, 'Laura', 'Jackson', '1993-07-30', 'Female', '555-8901', '1515 Oak St, Springfield, IL', 'James Jackson', '555-2345', 'A-'),
(19, 'Robert', 'White', '1982-04-12', 'Male', '555-9012', '1616 Cedar St, Springfield, IL', 'Patricia White', '555-3456', 'O+'),
(20, 'Michelle', 'Harris', '1979-10-01', 'Female', '555-0123', '1717 Birch St, Springfield, IL', 'Edward Harris', '555-4567', 'AB+'),
(21, 'Christopher', 'Martin', '1990-02-27', 'Male', '555-1234', '1818 Redwood St, Springfield, IL', 'Maria Martin', '555-5678', 'B-'),
(22, 'Jessica', 'Thompson', '1985-09-14', 'Female', '555-2345', '1919 Willow St, Springfield, IL', 'David Thompson', '555-6789', 'O-'),
(23, 'Benjamin', 'Garcia', '1993-11-19', 'Male', '555-3456', '2020 Pine St, Springfield, IL', 'Angela Garcia', '555-7890', 'A+'),
(24, 'Catherine', 'Martinez', '1984-01-11', 'Female', '555-4567', '2121 Maple St, Springfield, IL', 'Victor Martinez', '555-8901', 'AB-'),
(25, 'Matthew', 'Roberts', '1976-06-09', 'Male', '555-5678', '2222 Oak St, Springfield, IL', 'Janet Roberts', '555-9012', 'O+'),
(26, 'Emily', 'Walker', '1996-04-03', 'Female', '555-6789', '2323 Cedar St, Springfield, IL', 'Thomas Walker', '555-0123', 'A-'),
(27, 'James', 'Adams', '1981-03-21', 'Male', '555-7890', '2424 Birch St, Springfield, IL', 'Sarah Adams', '555-1234', 'B+'),
(28, 'Amanda', 'Baker', '1992-12-18', 'Female', '555-8901', '2525 Redwood St, Springfield, IL', 'Paul Baker', '555-2345', 'AB+'),
(29, 'Steven', 'Nelson', '1986-11-30', 'Male', '555-9012', '2626 Willow St, Springfield, IL', 'Rebecca Nelson', '555-3456', 'O+'),
(30, 'Sarah', 'Carter', '1994-05-02', 'Female', '555-0123', '2727 Pine St, Springfield, IL', 'Daniel Carter', '555-4567', 'A+'),
(31, 'David', 'Mitchell', '1988-07-04', 'Male', '555-1234', '2828 Maple St, Springfield, IL', 'Laura Mitchell', '555-5678', 'B+'),
(32, 'Sophia', 'Perez', '1995-09-09', 'Female', '555-2345', '2929 Oak St, Springfield, IL', 'Carlos Perez', '555-6789', 'O-'),
(33, 'Alexander', 'Roberts', '1991-10-30', 'Male', '555-3456', '3030 Cedar St, Springfield, IL', 'Elena Roberts', '555-7890', 'A+'),
(34, 'Ava', 'Miller', '1998-02-21', 'Female', '555-4567', '3131 Birch St, Springfield, IL', 'Liam Miller', '555-8901', 'AB-'),
(35, 'Liam', 'Davis', '1997-11-17', 'Male', '555-5678', '3232 Redwood St, Springfield, IL', 'Olivia Davis', '555-9012', 'B+'),
(36, 'Mia', 'Garcia', '1996-04-25', 'Female', '555-6789', '3333 Willow St, Springfield, IL', 'Eduardo Garcia', '555-0123', 'O+'),
(37, 'Ethan', 'Rodriguez', '1993-08-11', 'Male', '555-7890', '3434 Pine St, Springfield, IL', 'Natalia Rodriguez', '555-1234', 'A-'),
(38, 'Isabella', 'Wilson', '1992-03-06', 'Female', '555-8901', '3535 Maple St, Springfield, IL', 'David Wilson', '555-2345', 'AB+'),
(39, 'Jacob', 'Martinez', '1989-01-29', 'Male', '555-9012', '3636 Oak St, Springfield, IL', 'Marissa Martinez', '555-3456', 'B+'),
(40, 'Charlotte', 'Hernandez', '1987-05-10', 'Female', '555-0123', '3737 Cedar St, Springfield, IL', 'Ramon Hernandez', '555-4567', 'O-'),
(41, 'Oliver', 'Moore', '1994-09-13', 'Male', '555-1234', '3838 Birch St, Springfield, IL', 'Karen Moore', '555-5678', 'A+'),
(42, 'Amelia', 'Jackson', '1996-07-02', 'Female', '555-2345', '3939 Redwood St, Springfield, IL', 'George Jackson', '555-6789', 'AB-'),
(43, 'James', 'White', '1991-05-23', 'Male', '555-3456', '4040 Willow St, Springfield, IL', 'Emily White', '555-7890', 'B-'),
(44, 'Ella', 'Lee', '1997-10-17', 'Female', '555-4567', '4141 Pine St, Springfield, IL', 'Aaron Lee', '555-8901', 'O+'),
(45, 'Benjamin', 'Perez', '1984-12-05', 'Male', '555-5678', '4242 Maple St, Springfield, IL', 'Emma Perez', '555-9012', 'A-'),
(46, 'Lucas', 'Gonzalez', '1993-06-21', 'Male', '555-6789', '4343 Oak St, Springfield, IL', 'Sophia Gonzalez', '555-0123', 'O+'),
(47, 'Mason', 'Wilson', '1990-07-11', 'Male', '555-7890', '4444 Cedar St, Springfield, IL', 'Amelia Wilson', '555-1234', 'AB+'),
(48, 'Harper', 'Thomas', '1995-01-30', 'Female', '555-8901', '4545 Birch St, Springfield, IL', 'Isaac Thomas', '555-2345', 'B+'),
(49, 'Ella', 'Davis', '1992-03-16', 'Female', '555-9012', '4646 Redwood St, Springfield, IL', 'Jack Davis', '555-3456', 'O-'),
(50, 'Jack', 'Miller', '1985-02-13', 'Male', '555-0123', '4747 Willow St, Springfield, IL', 'Grace Miller', '555-4567', 'A+'),
(51, 'Charlotte', 'Brown', '1988-10-05', 'Female', '555-1234', '4848 Pine St, Springfield, IL', 'Chris Brown', '555-5678', 'AB-'),
(52, 'Mia', 'Taylor', '1993-12-28', 'Female', '555-2345', '4949 Maple St, Springfield, IL', 'Robert Taylor', '555-6789', 'B+'),
(53, 'Noah', 'Anderson', '1992-07-07', 'Male', '555-3456', '5050 Oak St, Springfield, IL', 'Mary Anderson', '555-7890', 'O+'),
(54, 'Grace', 'Thomas', '1994-05-21', 'Female', '555-4567', '5151 Cedar St, Springfield, IL', 'Evan Thomas', '555-8901', 'A-'),
(55, 'Zoe', 'Lopez', '1989-11-02', 'Female', '555-5678', '5252 Birch St, Springfield, IL', 'Luis Lopez', '555-9012', 'AB+'),
(56, 'Oliver', 'Garcia', '1983-06-29', 'Male', '555-6789', '5353 Redwood St, Springfield, IL', 'Clara Garcia', '555-0123', 'B+'),
(57, 'Emily', 'Wilson', '1990-01-16', 'Female', '555-7890', '5454 Willow St, Springfield, IL', 'Carlos Wilson', '555-1234', 'O-'),
(58, 'Henry', 'Jackson', '1992-04-11', 'Male', '555-8901', '5555 Pine St, Springfield, IL', 'Eva Jackson', '555-2345', 'A+'),
(59, 'Amelia', 'Martinez', '1995-09-06', 'Female', '555-9012', '5656 Maple St, Springfield, IL', 'Victor Martinez', '555-3456', 'AB-'),
(60, 'Daniel', 'Lee', '1984-12-20', 'Male', '555-0123', '5757 Oak St, Springfield, IL', 'Helen Lee', '555-4567', 'B+');


/* 7. Appointments Table
   Contains appointment details with additional columns
*/
DROP TABLE IF EXISTS Appointments;
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    StaffID INT,
    AppointmentDateTime DATETIME,
    Purpose VARCHAR(100),
    Status ENUM('Scheduled', 'Completed', 'Cancelled') NOT NULL,
    Notes TEXT, 
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

/* Insert Appointments */
INSERT INTO Appointments (AppointmentID, PatientID, StaffID, AppointmentDateTime, Purpose, Status, Notes) VALUES
(1, 1, 1, '2024-11-01 09:00:00', 'General Checkup', 'Scheduled', 'Routine checkup'),
(2, 2, 2, '2024-11-01 10:30:00', 'Dental Consultation', 'Scheduled', 'First consultation'),
(3, 3, 3, '2024-11-02 14:00:00', 'Eye Examination', 'Scheduled', 'Follow-up visit'),
(4, 4, 4, '2024-11-02 15:30:00', 'Skin Treatment', 'Scheduled', 'Treatment for rash'),
(5, 5, 5, '2024-11-03 08:00:00', 'Physiotherapy', 'Scheduled', 'Rehabilitation after surgery'),
(6, 6, 6, '2024-11-03 11:00:00', 'Flu Shot', 'Scheduled', 'Seasonal flu vaccination'),
(7, 7, 7, '2024-11-04 13:30:00', 'Blood Test', 'Scheduled', 'Routine blood work'),
(8, 8, 8, '2024-11-04 16:00:00', 'MRI Scan', 'Scheduled', 'For back pain evaluation'),
(9, 9, 9, '2024-11-05 09:00:00', 'Cardiac Consultation', 'Scheduled', 'Chest pain and breathlessness'),
(10, 10, 10, '2024-11-05 10:30:00', 'X-ray', 'Scheduled', 'Chest X-ray'),
(11, 11, 11, '2024-11-06 12:00:00', 'Gynecology Consultation', 'Scheduled', 'Pregnancy follow-up'),
(12, 12, 12, '2024-11-06 14:30:00', 'Dental Cleaning', 'Scheduled', 'Routine cleaning'),
(13, 13, 13, '2024-11-07 15:00:00', 'Neurology Consultation', 'Scheduled', 'Headaches and dizziness'),
(14, 14, 14, '2024-11-07 16:30:00', 'Dermatology Consultation', 'Scheduled', 'Acne treatment'),
(15, 15, 15, '2024-11-08 09:00:00', 'General Checkup', 'Scheduled', 'Annual health check'),
(16, 16, 16, '2024-11-08 11:00:00', 'Eye Examination', 'Scheduled', 'Annual vision checkup'),
(17, 17, 17, '2024-11-09 08:30:00', 'Dentistry Consultation', 'Scheduled', 'Toothache'),
(18, 18, 18, '2024-11-09 10:00:00', 'Blood Pressure Monitoring', 'Scheduled', 'Monitoring after heart surgery'),
(19, 19, 19, '2024-11-10 14:00:00', 'Diabetic Consultation', 'Scheduled', 'Blood sugar control'),
(20, 20, 20, '2024-11-10 15:30:00', 'Orthopedic Consultation', 'Scheduled', 'Knee pain and swelling'),
(21, 21, 1, '2024-11-11 09:30:00', 'General Checkup', 'Scheduled', 'Routine checkup'),
(22, 22, 2, '2024-11-11 10:00:00', 'Cardiology Consultation', 'Scheduled', 'Chest pain evaluation'),
(23, 23, 3, '2024-11-12 13:00:00', 'Psychiatric Consultation', 'Scheduled', 'Depression treatment'),
(24, 24, 4, '2024-11-12 14:30:00', 'Pulmonology Consultation', 'Scheduled', 'Shortness of breath'),
(25, 25, 5, '2024-11-13 08:00:00', 'Endocrinology Consultation', 'Scheduled', 'Thyroid checkup'),
(26, 26, 6, '2024-11-13 10:00:00', 'General Checkup', 'Scheduled', 'Routine physical exam'),
(27, 27, 7, '2024-11-14 09:00:00', 'Rheumatology Consultation', 'Scheduled', 'Joint pain assessment'),
(28, 28, 8, '2024-11-14 11:00:00', 'General Checkup', 'Scheduled', 'Pre-surgery checkup'),
(29, 29, 9, '2024-11-15 12:30:00', 'General Surgery Consultation', 'Scheduled', 'Pre-surgery consultation'),
(30, 30, 10, '2024-11-15 14:00:00', 'Obstetrics Consultation', 'Scheduled', 'Pregnancy checkup'),
(31, 31, 11, '2024-11-16 09:00:00', 'Urology Consultation', 'Scheduled', 'Prostate checkup'),
(32, 32, 12, '2024-11-16 10:30:00', 'Physical Therapy', 'Scheduled', 'Rehabilitation after knee surgery'),
(33, 33, 13, '2024-11-17 11:00:00', 'Nephrology Consultation', 'Scheduled', 'Kidney function test'),
(34, 34, 14, '2024-11-17 14:00:00', 'General Checkup', 'Scheduled', 'Annual health check'),
(35, 35, 15, '2024-11-18 08:00:00', 'General Surgery Consultation', 'Scheduled', 'Gallbladder surgery'),
(36, 36, 16, '2024-11-18 10:00:00', 'Ear, Nose, and Throat (ENT) Consultation', 'Scheduled', 'Chronic sinusitis'),
(37, 3, 17, '2024-11-19 11:00:00', 'Psychiatric Consultation', 'Scheduled', 'Anxiety management'),
(38, 38, 18, '2024-11-19 13:00:00', 'Orthopedic Consultation', 'Scheduled', 'Fracture follow-up'),
(39, 9, 19, '2024-11-20 09:00:00', 'Gastroenterology Consultation', 'Scheduled', 'Abdominal pain'),
(40, 40, 20, '2024-11-20 10:30:00', 'Neurology Consultation', 'Scheduled', 'Migraines'),
(41, 1, 1, '2024-11-21 12:00:00', 'Cardiology Consultation', 'Scheduled', 'Arrhythmia concerns'),
(42, 42, 2, '2024-11-21 14:00:00', 'Rheumatology Consultation', 'Scheduled', 'Arthritis consultation'),
(43, 43, 3, '2024-11-22 09:30:00', 'Dermatology Consultation', 'Scheduled', 'Skin rashes'),
(44, 44, 4, '2024-11-22 11:00:00', 'Endocrinology Consultation', 'Scheduled', 'Blood sugar levels check'),
(45, 45, 5, '2024-11-23 08:00:00', 'Gastroenterology Consultation', 'Scheduled', 'Stomach ulcers'),
(46, 46, 6, '2024-11-23 10:00:00', 'Ophthalmology Consultation', 'Scheduled', 'Eye checkup'),
(47, 7, 7, '2024-11-24 12:00:00', 'Pediatrics Consultation', 'Scheduled', 'Child wellness check'),
(48, 48, 8, '2024-11-24 14:00:00', 'Urology Consultation', 'Scheduled', 'Urinary problems'),
(49, 49, 9, '2024-11-25 10:00:00', 'General Checkup', 'Scheduled', 'Routine health screening'),
(50, 50, 10, '2024-11-25 12:30:00', 'Nephrology Consultation', 'Scheduled', 'Kidney stones'),
(51, 1, 11, '2024-11-26 08:00:00', 'Obstetrics Consultation', 'Scheduled', 'Prenatal checkup'),
(52, 22, 12, '2024-11-26 10:00:00', 'Pediatrics Consultation', 'Scheduled', 'Routine checkup for newborn'),
(53, 43, 13, '2024-11-27 12:30:00', 'Ophthalmology Consultation', 'Scheduled', 'Vision checkup'),
(54, 4, 14, '2024-11-27 14:00:00', 'Rheumatology Consultation', 'Scheduled', 'Joint pain management'),
(55, 5, 15, '2024-11-28 08:00:00', 'General Surgery Consultation', 'Scheduled', 'Bowel surgery follow-up'),
(56, 26, 16, '2024-11-28 10:30:00', 'Cardiology Consultation', 'Scheduled', 'Heart checkup'),
(57, 47, 17, '2024-11-29 12:00:00', 'Neurology Consultation', 'Scheduled', 'Severe headaches'),
(58, 38, 18, '2024-11-29 14:00:00', 'Dermatology Consultation', 'Scheduled', 'Skin cancer screening'),
(59, 29, 19, '2024-11-30 08:00:00', 'Obstetrics Consultation', 'Scheduled', 'Pregnancy follow-up'),
(60, 10, 20, '2024-11-30 09:30:00', 'General Checkup', 'Scheduled', 'Annual exam'),
(61, 31, 1, '2024-12-01 10:00:00', 'General Surgery Consultation', 'Scheduled', 'Post-surgery evaluation'),
(62, 22, 2, '2024-12-01 12:30:00', 'Orthopedic Consultation', 'Scheduled', 'Back pain management'),
(63, 3, 3, '2024-12-02 09:00:00', 'Ear, Nose, and Throat (ENT) Consultation', 'Scheduled', 'Sinus treatment'),
(64, 14, 4, '2024-12-02 11:30:00', 'General Checkup', 'Scheduled', 'Routine checkup'),
(65, 5, 5, '2024-12-03 09:00:00', 'Pediatrics Consultation', 'Scheduled', 'Child immunization'),
(66, 6, 6, '2024-12-03 10:30:00', 'Urology Consultation', 'Scheduled', 'Bladder infection'),
(67, 37, 7, '2024-12-04 11:00:00', 'General Surgery Consultation', 'Scheduled', 'Hernia surgery consultation'),
(68, 6, 8, '2024-12-04 13:30:00', 'Psychiatric Consultation', 'Scheduled', 'Medication review'),
(69, 6, 9, '2024-12-05 08:30:00', 'Nephrology Consultation', 'Scheduled', 'Kidney health check'),
(70, 7, 10, '2024-12-05 10:30:00', 'Gastroenterology Consultation', 'Scheduled', 'Acid reflux issue'),
(71, 51, 11, '2024-12-06 09:00:00', 'Dermatology Consultation', 'Scheduled', 'Acne treatment'),
(72, 7, 12, '2024-12-06 11:00:00', 'Psychiatric Consultation', 'Scheduled', 'Stress management'),
(73, 7, 13, '2024-12-07 08:00:00', 'General Surgery Consultation', 'Scheduled', 'Appendix surgery'),
(74, 14, 14, '2024-12-07 10:30:00', 'Pediatrics Consultation', 'Scheduled', 'Routine child checkup'),
(75, 25, 15, '2024-12-08 09:00:00', 'Cardiology Consultation', 'Scheduled', 'Blood pressure concerns'),
(76, 36, 16, '2024-12-08 10:30:00', 'General Checkup', 'Scheduled', 'Full body check'),
(77, 47, 17, '2024-12-09 12:30:00', 'Rheumatology Consultation', 'Scheduled', 'Arthritis management'),
(78, 18, 18, '2024-12-09 14:00:00', 'Ophthalmology Consultation', 'Scheduled', 'Cataract surgery consultation'),
(79, 9, 19, '2024-12-10 09:30:00', 'Pediatrics Consultation', 'Scheduled', 'Routine vaccinations'),
(80, 20, 20, '2024-12-10 11:00:00', 'Endocrinology Consultation', 'Scheduled', 'Thyroid check'),
(81, 31, 1, '2024-12-11 13:00:00', 'Obstetrics Consultation', 'Scheduled', 'Pregnancy follow-up'),
(82, 32, 2, '2024-12-11 15:00:00', 'General Checkup', 'Scheduled', 'Wellness check'),
(83, 43, 3, '2024-12-12 09:00:00', 'Psychiatric Consultation', 'Scheduled', 'Therapy session'),
(84, 4, 4, '2024-12-12 11:30:00', 'Orthopedic Consultation', 'Scheduled', 'Sports injury treatment'),
(85, 15, 5, '2024-12-13 09:30:00', 'Nephrology Consultation', 'Scheduled', 'Kidney function test'),
(86, 6, 6, '2024-12-13 11:00:00', 'Pediatrics Consultation', 'Scheduled', 'Child wellness check'),
(87,17, 7, '2024-12-14 08:30:00', 'Rheumatology Consultation', 'Scheduled', 'Back pain treatment'),
(88, 18, 8, '2024-12-14 10:00:00', 'Dermatology Consultation', 'Scheduled', 'Mole removal'),
(89, 29, 9, '2024-12-15 14:00:00', 'Ophthalmology Consultation', 'Scheduled', 'Glaucoma screening'),
(90, 10, 10, '2024-12-15 16:00:00', 'Cardiology Consultation', 'Scheduled', 'Heart disease prevention'),
(91, 11, 11, '2024-12-16 08:00:00', 'Orthopedic Consultation', 'Scheduled', 'Surgery consultation'),
(92, 12, 12, '2024-12-16 10:30:00', 'General Checkup', 'Scheduled', 'Routine examination'),
(93, 33, 13, '2024-12-17 09:00:00', 'Neurology Consultation', 'Scheduled', 'Epilepsy consultation'),
(94, 44, 14, '2024-12-17 11:30:00', 'General Surgery Consultation', 'Scheduled', 'Liver transplant consultation'),
(95, 5, 15, '2024-12-18 10:00:00', 'General Checkup', 'Scheduled', 'Annual health check'),
(96, 16, 16, '2024-12-18 12:00:00', 'Urology Consultation', 'Scheduled', 'Prostate exam'),
(97, 17, 17, '2024-12-19 14:00:00', 'Endocrinology Consultation', 'Scheduled', 'Diabetes management'),
(98, 38, 18, '2024-12-19 15:30:00', 'Nephrology Consultation', 'Scheduled', 'Kidney stone removal'),
(99, 39, 19, '2024-12-20 10:00:00', 'Obstetrics Consultation', 'Scheduled', 'Prenatal checkup'),
(100,16, 20, '2024-12-20 12:00:00', 'Gastroenterology Consultation', 'Scheduled', 'Digestive issues');


/* 8. AppointmentHistory Table
   Tracks history of appointment status changes
*/
DROP TABLE IF EXISTS AppointmentHistory;
CREATE TABLE AppointmentHistory (
    HistoryID INT PRIMARY KEY,
    AppointmentID INT,
    ChangedBy INT, -- StaffID who made the change
    ChangeDateTime DATETIME,
    PreviousStatus ENUM('Scheduled', 'Completed', 'Cancelled'),
    NewStatus ENUM('Scheduled', 'Completed', 'Cancelled'),
    Comments TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (ChangedBy) REFERENCES Staff(StaffID)
);

/* Insert AppointmentHistory Records */

INSERT INTO AppointmentHistory (HistoryID, AppointmentID, ChangedBy, ChangeDateTime, PreviousStatus, NewStatus, Comments)
VALUES
(1, 1, 1, '2024-11-02 10:00:00', 'Scheduled', 'Completed', 'Patient attended appointment for general checkup'),
(2, 2, 2, '2024-11-02 11:30:00', 'Scheduled', 'Cancelled', 'Patient rescheduled appointment for dental consultation'),
(3, 3, 3, '2024-11-02 15:30:00', 'Scheduled', 'Completed', 'Eye exam successfully completed'),
(4, 4, 4, '2024-11-03 16:00:00', 'Scheduled', 'Completed', 'Skin treatment session successfully completed'),
(5, 5, 5, '2024-11-04 09:30:00', 'Scheduled', 'Completed', 'Physiotherapy session completed for post-surgery rehab'),
(6, 6, 6, '2024-11-04 12:00:00', 'Scheduled', 'Cancelled', 'Patient did not show for flu shot appointment'),
(7, 7, 7, '2024-11-05 14:30:00', 'Scheduled', 'Completed', 'Routine blood test completed successfully'),
(8, 8, 8, '2024-11-05 17:00:00', 'Scheduled', 'Completed', 'MRI scan for back pain completed'),
(9, 9, 9, '2024-11-06 09:30:00', 'Scheduled', 'Completed', 'Cardiac consultation and follow-up completed'),
(10, 10, 10, '2024-11-06 11:00:00', 'Scheduled', 'Completed', 'Chest X-ray completed successfully'),
(11, 11, 11, '2024-11-07 13:30:00', 'Scheduled', 'Completed', 'Gynecology consultation for pregnancy follow-up completed'),
(12, 12, 12, '2024-11-07 15:00:00', 'Scheduled', 'Completed', 'Dental cleaning performed successfully'),
(13, 13, 13, '2024-11-08 16:00:00', 'Scheduled', 'Completed', 'Neurology consultation for headaches and dizziness completed'),
(14, 14, 14, '2024-11-08 17:30:00', 'Scheduled', 'Completed', 'Dermatology consultation for acne treatment completed'),
(15, 15, 15, '2024-11-09 09:30:00', 'Scheduled', 'Completed', 'Annual general checkup completed successfully'),
(16, 16, 16, '2024-11-09 11:00:00', 'Scheduled', 'Completed', 'Eye exam and vision check completed'),
(17, 17, 17, '2024-11-10 08:00:00', 'Scheduled', 'Completed', 'Dentistry consultation for toothache completed'),
(18, 18, 18, '2024-11-10 09:30:00', 'Scheduled', 'Completed', 'Blood pressure monitoring post-surgery completed'),
(19, 19, 19, '2024-11-11 14:00:00', 'Scheduled', 'Completed', 'Diabetic consultation for blood sugar management completed'),
(20, 20, 20, '2024-11-11 15:30:00', 'Scheduled', 'Completed', 'Orthopedic consultation for knee pain completed'),
(21, 21, 1, '2024-11-12 09:30:00', 'Scheduled', 'Completed', 'Routine general checkup completed successfully'),
(22, 22, 2, '2024-11-12 11:00:00', 'Scheduled', 'Completed', 'Cardiology consultation for chest pain completed'),
(23, 23, 3, '2024-11-13 13:30:00', 'Scheduled', 'Completed', 'Psychiatric consultation for depression treatment completed'),
(24, 24, 4, '2024-11-13 15:00:00', 'Scheduled', 'Completed', 'Pulmonology consultation for shortness of breath completed'),
(25, 25, 5, '2024-11-14 09:00:00', 'Scheduled', 'Completed', 'Endocrinology consultation for thyroid checkup completed'),
(26, 26, 6, '2024-11-14 10:30:00', 'Scheduled', 'Completed', 'General checkup for routine physical exam completed'),
(27, 27, 7, '2024-11-15 09:00:00', 'Scheduled', 'Completed', 'Rheumatology consultation for joint pain assessment completed'),
(28, 28, 8, '2024-11-15 11:00:00', 'Scheduled', 'Completed', 'Pre-surgery checkup completed successfully'),
(29, 29, 9, '2024-11-16 10:00:00', 'Scheduled', 'Completed', 'Pre-surgery consultation for general surgery completed'),
(30, 30, 10, '2024-11-16 11:30:00', 'Scheduled', 'Completed', 'Obstetrics consultation for pregnancy checkup completed'),
(31, 1, 1, '2024-11-17 14:00:00', 'Scheduled', 'Cancelled', 'Patient cancelled the general checkup appointment'),
(32, 2, 2, '2024-11-17 15:30:00', 'Scheduled', 'Completed', 'Dental consultation rescheduled to another date'),
(33, 3, 3, '2024-11-18 13:00:00', 'Scheduled', 'Completed', 'Eye examination follow-up after treatment'),
(34, 4, 4, '2024-11-18 14:30:00', 'Scheduled', 'Completed', 'Skin treatment follow-up for rash healing'),
(35, 5, 5, '2024-11-19 09:00:00', 'Scheduled', 'Completed', 'Physiotherapy session progress update'),
(36, 6, 6, '2024-11-19 10:30:00', 'Scheduled', 'Completed', 'Flu shot vaccination administered successfully'),
(37, 7, 7, '2024-11-20 12:00:00', 'Scheduled', 'Completed', 'Blood test results discussed with patient'),
(38, 8, 8, '2024-11-20 13:30:00', 'Scheduled', 'Completed', 'MRI results showed improvement in back pain'),
(39, 9, 9, '2024-11-21 09:00:00', 'Scheduled', 'Completed', 'Cardiac consultation with follow-up instructions given'),
(40, 10, 10, '2024-11-21 10:30:00', 'Scheduled', 'Completed', 'X-ray results were discussed with the patient');


/* 9. MedicalRecords Table
   Stores medical history per patient with additional columns
*/
DROP TABLE IF EXISTS MedicalRecords;
CREATE TABLE MedicalRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    RecordDate DATETIME,
    Diagnosis VARCHAR(255),
    Treatment VARCHAR(255),
    PrescribedMedications VARCHAR(255),
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);


/* Insert Medical Records */
INSERT INTO MedicalRecords (PatientID, RecordDate, Diagnosis, Treatment, PrescribedMedications, Notes)
VALUES
(1, '2024-11-01 09:00:00', 'Hypertension', 'Lifestyle changes, medication', 'Amlodipine 5mg', 'Monitor blood pressure regularly'),
(2, '2024-11-02 10:30:00', 'Diabetes Type 2', 'Insulin therapy, diet management', 'Metformin 500mg', 'Patient advised to monitor blood sugar levels'),
(3, '2024-11-02 14:00:00', 'Chronic Back Pain', 'Physical therapy, pain management', 'Ibuprofen 400mg', 'Follow-up after 2 weeks'),
(4, '2024-11-03 08:00:00', 'Asthma', 'Inhaler, bronchodilator', 'Albuterol inhaler', 'Avoid exposure to triggers'),
(5, '2024-11-03 12:30:00', 'Seasonal Allergies', 'Antihistamines', 'Loratadine 10mg', 'Avoid pollen exposure during spring season'),
(6, '2024-11-04 10:15:00', 'Acid Reflux', 'Proton pump inhibitors, diet modifications', 'Omeprazole 20mg', 'Avoid spicy foods'),
(7, '2024-11-05 11:00:00', 'Osteoarthritis', 'Pain relief, exercise', 'Diclofenac 50mg', 'Patient to engage in low-impact exercise'),
(8, '2024-11-05 14:30:00', 'Pneumonia', 'Antibiotics, rest', 'Amoxicillin 500mg', 'Patient advised to rest and stay hydrated'),
(9, '2024-11-06 09:30:00', 'Urinary Tract Infection', 'Antibiotic treatment', 'Ciprofloxacin 250mg', 'Drink plenty of water'),
(10, '2024-11-06 13:00:00', 'Migraine', 'Pain relief, lifestyle modifications', 'Sumatriptan 50mg', 'Keep a migraine diary for triggers'),
(11, '2024-11-07 10:00:00', 'Hyperthyroidism', 'Anti-thyroid medication', 'Methimazole 5mg', 'Follow-up in 3 months'),
(12, '2024-11-07 15:00:00', 'Anemia', 'Iron supplementation, diet adjustments', 'Ferrous sulfate 325mg', 'Increase intake of iron-rich foods'),
(13, '2024-11-08 09:00:00', 'Gastritis', 'Acid suppression, diet changes', 'Ranitidine 150mg', 'Avoid alcohol and caffeine'),
(14, '2024-11-08 12:00:00', 'Allergic Rhinitis', 'Nasal corticosteroids', 'Fluticasone nasal spray', 'Use twice a day for 2 weeks'),
(15, '2024-11-09 09:30:00', 'Influenza', 'Rest, fluids, antiviral treatment', 'Oseltamivir 75mg', 'Avoid close contact with others'),
(16, '2024-11-09 11:30:00', 'Hypertension', 'Medication, weight management', 'Losartan 50mg', 'Monitor blood pressure regularly'),
(17, '2024-11-10 10:00:00', 'Chronic Sinusitis', 'Nasal decongestants', 'Pseudoephedrine 60mg', 'Follow-up if symptoms persist'),
(18, '2024-11-10 13:00:00', 'Post-Surgery Recovery', 'Physical therapy, wound care', 'None', 'Monitor for any signs of infection'),
(19, '2024-11-11 09:00:00', 'Psoriasis', 'Topical treatments', 'Betamethasone cream', 'Avoid stress and triggers'),
(20, '2024-11-11 12:30:00', 'Chronic Fatigue Syndrome', 'Rest, balanced diet', 'None', 'Patient advised to maintain regular sleep schedule'),
(21, '2024-11-12 10:00:00', 'Eczema', 'Topical steroids', 'Hydrocortisone cream', 'Avoid scratching the affected areas'),
(22, '2024-11-12 13:30:00', 'Sleep Apnea', 'CPAP therapy', 'None', 'Regular follow-up to adjust therapy settings'),
(23, '2024-11-13 11:00:00', 'Panic Disorder', 'Cognitive-behavioral therapy, medication', 'Sertraline 25mg', 'Patient to continue therapy sessions'),
(24, '2024-11-13 14:00:00', 'Irritable Bowel Syndrome', 'Diet modifications, medications', 'Loperamide 2mg', 'Avoid dairy and fatty foods'),
(25, '2024-11-14 09:00:00', 'Gout', 'Pain management, lifestyle changes', 'Colchicine 0.6mg', 'Avoid purine-rich foods'),
(26, '2024-11-14 11:30:00', 'Diabetes Type 2', 'Oral medication, diet', 'Glibenclamide 5mg', 'Monitor blood sugar levels regularly'),
(27, '2024-11-15 09:30:00', 'Tuberculosis', 'Antibiotic therapy', 'Rifampin 10mg', 'Patient to complete full course of treatment'),
(28, '2024-11-15 13:00:00', 'Hepatitis B', 'Antiviral therapy', 'Tenofovir 300mg', 'Regular liver function tests required'),
(29, '2024-11-16 10:00:00', 'Celiac Disease', 'Gluten-free diet', 'None', 'Avoid all gluten-containing foods'),
(30, '2024-11-16 12:00:00', 'Rheumatoid Arthritis', 'Pain relief, disease-modifying drugs', 'Methotrexate 15mg', 'Patient to monitor joint pain levels'),
(31, '2024-11-17 09:00:00', 'Osteoporosis', 'Calcium supplements, exercise', 'Calcium 1000mg', 'Weight-bearing exercises recommended'),
(32, '2024-11-17 11:30:00', 'Gastric Ulcer', 'Proton pump inhibitors, diet changes', 'Lansoprazole 30mg', 'Avoid acidic foods'),
(33, '2024-11-18 09:30:00', 'Chronic Obstructive Pulmonary Disease (COPD)', 'Inhalers, smoking cessation', 'Tiotropium inhaler', 'Patient to quit smoking'),
(34, '2024-11-18 14:00:00', 'Bipolar Disorder', 'Mood stabilizers, therapy', 'Lithium 300mg', 'Patient advised to continue regular therapy'),
(35, '2024-11-19 09:30:00', 'Gallstones', 'Surgical consultation', 'None', 'Follow-up with surgeon for possible surgery'),
(36, '2024-11-19 13:00:00', 'Anxiety', 'Therapy, medication', 'Alprazolam 0.5mg', 'Patient advised to practice relaxation techniques'),
(37, '2024-11-20 10:00:00', 'Kidney Stones', 'Pain management, hydration', 'Ibuprofen 400mg', 'Increase water intake'),
(38, '2024-11-20 12:00:00', 'Chronic Kidney Disease', 'Dialysis, diet changes', 'None', 'Monitor kidney function regularly'),
(39, '2024-11-21 08:30:00', 'Lung Cancer', 'Chemotherapy, radiation', 'Cisplatin', 'Monitor for side effects of treatment'),
(40, '2024-11-21 10:30:00', 'Multiple Sclerosis', 'Disease-modifying drugs', 'Interferon beta', 'Regular follow-up to assess progression');


/* 10. MedicalRecordHistory Table
   Tracks history of medical record updates
*/
DROP TABLE IF EXISTS MedicalRecordHistory;
CREATE TABLE IF NOT EXISTS MedicalRecordHistory (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    RecordID INT,  -- Foreign Key to MedicalRecords table
    ChangeDateTime DATETIME,
    ChangedBy INT,  -- User or staff ID who made the change
    PreviousDiagnosis VARCHAR(255),
    NewDiagnosis VARCHAR(255),
    PreviousTreatment VARCHAR(255),
    NewTreatment VARCHAR(255),
    PreviousMedications VARCHAR(255),
    NewMedications VARCHAR(255),
    Comments TEXT,
    FOREIGN KEY (RecordID) REFERENCES MedicalRecords(RecordID)
);

/* Insert MedicalRecordHistory Records */
INSERT INTO MedicalRecordHistory (RecordID, ChangeDateTime, ChangedBy, PreviousDiagnosis, NewDiagnosis, PreviousTreatment, NewTreatment, PreviousMedications, NewMedications, Comments) 
VALUES
(1, '2024-11-01 09:15:00', 1, 'Hypertension', 'Hypertension', 'Lifestyle changes, medication', 'Lifestyle changes, medication', 'Amlodipine 5mg', 'Amlodipine 5mg', 'Initial consultation and treatment plan established'),
(2, '2024-11-02 10:45:00', 2, 'Diabetes Type 2', 'Diabetes Type 2', 'Insulin therapy, diet management', 'Insulin therapy, diet management', 'Metformin 500mg', 'Metformin 500mg', 'First visit, medication prescribed'),
(3, '2024-11-02 14:30:00', 3, 'Chronic Back Pain', 'Chronic Back Pain', 'Physical therapy, pain management', 'Physical therapy, pain management', 'Ibuprofen 400mg', 'Ibuprofen 400mg', 'Follow-up after initial consultation'),
(4, '2024-11-03 08:15:00', 4, 'Asthma', 'Asthma', 'Inhaler, bronchodilator', 'Inhaler, bronchodilator', 'Albuterol inhaler', 'Albuterol inhaler', 'Initial diagnosis and prescription for inhaler'),
(5, '2024-11-03 13:00:00', 5, 'Seasonal Allergies', 'Seasonal Allergies', 'Antihistamines', 'Antihistamines', 'Loratadine 10mg', 'Loratadine 10mg', 'Patient prescribed antihistamines after consultation'),
(6, '2024-11-04 10:45:00', 6, 'Acid Reflux', 'Acid Reflux', 'Proton pump inhibitors, diet modifications', 'Proton pump inhibitors, diet modifications', 'Omeprazole 20mg', 'Omeprazole 20mg', 'Initial treatment prescribed for acid reflux'),
(7, '2024-11-05 11:15:00', 7, 'Osteoarthritis', 'Osteoarthritis', 'Pain relief, exercise', 'Pain relief, exercise', 'Diclofenac 50mg', 'Diclofenac 50mg', 'Prescribed pain relief and exercise regimen'),
(8, '2024-11-05 15:00:00', 8, 'Pneumonia', 'Pneumonia', 'Antibiotics, rest', 'Antibiotics, rest', 'Amoxicillin 500mg', 'Amoxicillin 500mg', 'Pneumonia diagnosed, antibiotics prescribed'),
(9, '2024-11-06 09:45:00', 9, 'Urinary Tract Infection', 'Urinary Tract Infection', 'Antibiotic treatment', 'Antibiotic treatment', 'Ciprofloxacin 250mg', 'Ciprofloxacin 250mg', 'UTI diagnosed, medication prescribed'),
(10, '2024-11-06 13:30:00', 10, 'Migraine', 'Migraine', 'Pain relief, lifestyle modifications', 'Pain relief, lifestyle modifications', 'Sumatriptan 50mg', 'Sumatriptan 50mg', 'Prescribed medication for acute migraine attack'),
(11, '2024-11-07 10:30:00', 11, 'Hyperthyroidism', 'Hyperthyroidism', 'Anti-thyroid medication', 'Anti-thyroid medication', 'Methimazole 5mg', 'Methimazole 5mg', 'Treatment plan for hyperthyroidism'),
(12, '2024-11-07 15:30:00', 12, 'Anemia', 'Anemia', 'Iron supplementation, diet adjustments', 'Iron supplementation, diet adjustments', 'Ferrous sulfate 325mg', 'Ferrous sulfate 325mg', 'Iron supplements prescribed for anemia'),
(13, '2024-11-08 09:30:00', 13, 'Gastritis', 'Gastritis', 'Acid suppression, diet changes', 'Acid suppression, diet changes', 'Ranitidine 150mg', 'Ranitidine 150mg', 'Gastritis diagnosed, acid-suppressing treatment prescribed'),
(14, '2024-11-08 12:30:00', 14, 'Allergic Rhinitis', 'Allergic Rhinitis', 'Nasal corticosteroids', 'Nasal corticosteroids', 'Fluticasone nasal spray', 'Fluticasone nasal spray', 'Prescribed nasal spray for rhinitis'),
(15, '2024-11-09 09:45:00', 15, 'Influenza', 'Influenza', 'Rest, fluids, antiviral treatment', 'Rest, fluids, antiviral treatment', 'Oseltamivir 75mg', 'Oseltamivir 75mg', 'Influenza diagnosed, antiviral prescribed'),
(16, '2024-11-09 11:45:00', 16, 'Hypertension', 'Hypertension', 'Medication, weight management', 'Medication, weight management', 'Losartan 50mg', 'Losartan 50mg', 'Patient prescribed new antihypertensive medication'),
(17, '2024-11-10 10:15:00', 17, 'Chronic Sinusitis', 'Chronic Sinusitis', 'Nasal decongestants', 'Nasal decongestants', 'Pseudoephedrine 60mg', 'Pseudoephedrine 60mg', 'Nasal decongestant prescribed for sinusitis'),
(18, '2024-11-10 13:15:00', 18, 'Post-Surgery Recovery', 'Post-Surgery Recovery', 'Physical therapy, wound care', 'Physical therapy, wound care', 'None', 'None', 'Follow-up for post-surgery recovery');



/* 11. Medications Table
    Static medicine description with additional columns
*/
DROP TABLE IF EXISTS Medications;
CREATE TABLE Medications (
    MedicationID INT PRIMARY KEY,
    MedicationName VARCHAR(100) NOT NULL,
    Description TEXT,
    Dosage VARCHAR(50),
    Manufacturer VARCHAR(100),
    SideEffects TEXT, 
    StockQuantity INT DEFAULT 0 
);

/* Insert Medications */
INSERT INTO Medications (MedicationID, MedicationName, Description, Dosage, Manufacturer, SideEffects, StockQuantity)
VALUES
(1, 'Amlodipine', 'A medication used to treat high blood pressure and angina (chest pain).', '5mg', 'Pfizer', 'Headache, swelling of the ankles or feet, dizziness', 100),
(2, 'Metformin', 'An oral diabetes medicine that helps control blood sugar levels in people with type 2 diabetes.', '500mg', 'Bristol-Myers Squibb', 'Nausea, upset stomach, diarrhea', 150),
(3, 'Ibuprofen', 'Nonsteroidal anti-inflammatory drug (NSAID) used to reduce fever, pain, and inflammation.', '400mg', 'AbbVie', 'Stomach pain, nausea, dizziness, headache', 200),
(4, 'Albuterol', 'A medication used to treat or prevent bronchospasm in people with asthma or chronic obstructive pulmonary disease (COPD).', 'Inhaler (90mcg)', 'GlaxoSmithKline', 'Tremors, fast heartbeat, nervousness', 50),
(5, 'Loratadine', 'An antihistamine used to relieve allergy symptoms such as a runny nose, sneezing, and itching.', '10mg', 'Schering-Plough', 'Dry mouth, drowsiness, headache', 120),
(6, 'Omeprazole', 'A proton pump inhibitor used to treat acid reflux, heartburn, and ulcers.', '20mg', 'AstraZeneca', 'Headache, nausea, diarrhea, abdominal pain', 180),
(7, 'Diclofenac', 'A nonsteroidal anti-inflammatory drug (NSAID) used to treat pain and inflammation.', '50mg', 'Novartis', 'Stomach upset, dizziness, nausea, rash', 75),
(8, 'Amoxicillin', 'An antibiotic used to treat a wide variety of bacterial infections.', '500mg', 'GlaxoSmithKline', 'Nausea, vomiting, rash, diarrhea', 250),
(9, 'Ciprofloxacin', 'An antibiotic used to treat a variety of bacterial infections.', '250mg', 'Bayer', 'Diarrhea, nausea, dizziness, headaches', 200),
(10, 'Sumatriptan', 'A medication used to treat migraines and cluster headaches.', '50mg', 'GlaxoSmithKline', 'Nausea, dizziness, tingling, chest tightness', 80),
(11, 'Methimazole', 'An antithyroid medication used to treat hyperthyroidism.', '5mg', 'Hikma Pharmaceuticals', 'Rash, fever, joint pain, liver problems', 90),
(12, 'Ferrous sulfate', 'A medication used to treat or prevent iron-deficiency anemia.', '325mg', 'Novartis', 'Constipation, stomach upset, dark stools', 150),
(13, 'Ranitidine', 'A drug used to decrease stomach acid production for conditions like GERD and ulcers.', '150mg', 'Pfizer', 'Headache, dizziness, constipation', 130),
(14, 'Fluticasone', 'A nasal spray used to treat allergy symptoms and nasal congestion.', '50mcg', 'GlaxoSmithKline', 'Nasal irritation, nosebleeds, headache', 60),
(15, 'Oseltamivir', 'An antiviral medication used to treat or prevent influenza.', '75mg', 'Roche', 'Nausea, vomiting, headache', 100),
(16, 'Losartan', 'A medication used to treat high blood pressure and protect kidneys from damage caused by diabetes.', '50mg', 'Merck', 'Dizziness, headache, fatigue', 110),
(17, 'Pseudoephedrine', 'A decongestant used to relieve nasal congestion.', '60mg', 'Johnson & Johnson', 'Dizziness, insomnia, dry mouth', 180),
(18, 'Betamethasone', 'A corticosteroid used to treat inflammation, including skin conditions like eczema and psoriasis.', 'Topical Cream (0.1%)', 'Merck', 'Burning, itching, thinning skin', 100),
(19, 'Sertraline', 'A selective serotonin reuptake inhibitor (SSRI) used to treat depression, anxiety, and panic disorders.', '25mg', 'Pfizer', 'Nausea, dizziness, drowsiness, sexual dysfunction', 160),
(20, 'Hydrocortisone', 'A corticosteroid used to reduce inflammation and treat conditions like eczema, psoriasis, and arthritis.', 'Topical Cream (1%)', 'Pfizer', 'Burning, itching, thinning skin', 90);


/* 12. Prescriptions Table
    Prescriptions given to patients with additional columns
*/
DROP TABLE IF EXISTS Prescriptions;
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY,
    PatientID INT,
    StaffID INT,
    MedicationID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Instructions TEXT, 
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

/* Insert Prescriptions */
INSERT INTO Prescriptions (PrescriptionID, PatientID, StaffID, MedicationID, Dosage, Frequency, StartDate, EndDate, Instructions)
VALUES
(1, 1, 11, 1, '5mg', 'Once daily', '2024-11-01', '2024-12-01', 'Take with or without food. Monitor blood pressure regularly.'),
(2, 2, 12, 2, '500mg', 'Twice daily', '2024-11-02', '2024-12-02', 'Take with meals. Avoid alcohol.'),
(3, 3, 13, 3, '400mg', 'Every 8 hours', '2024-11-02', '2024-11-09', 'Take with food. Do not exceed 1200mg/day.'),
(4, 4, 14, 4, 'Inhaler (90mcg)', 'Every 4-6 hours as needed', '2024-11-03', '2024-12-03', 'Inhale 1 puff when experiencing shortness of breath.'),
(5, 5, 15, 5, '10mg', 'Once daily', '2024-11-03', '2024-12-03', 'Take before bedtime. Avoid alcohol.'),
(6, 6, 16, 6, '20mg', 'Once daily', '2024-11-04', '2024-12-04', 'Take before a meal. Do not take more than the prescribed dose.'),
(7, 7, 17, 7, '50mg', 'Once daily', '2024-11-05', '2024-12-05', 'Take with food. Can cause drowsiness.'),
(8, 8, 18, 8, '500mg', 'Three times a day', '2024-11-05', '2024-11-12', 'Take with food. Complete full course even if you feel better.'),
(9, 9, 19, 9, '250mg', 'Twice daily', '2024-11-06', '2024-11-13', 'Take with a full glass of water. Do not skip doses.'),
(10, 10, 10, 10, '50mg', 'At onset of migraine', '2024-11-06', '2024-11-13', 'Take at the first sign of a migraine. Do not exceed 200mg in 24 hours.'),
(11, 11, 11, 11, '5mg', 'Once daily', '2024-11-07', '2024-12-07', 'Take with food. Monitor thyroid levels regularly.'),
(12, 12, 12, 12, '325mg', 'Once daily', '2024-11-07', '2024-12-07', 'Take with food to avoid stomach upset.'),
(13, 13, 13, 13, '150mg', 'Once daily', '2024-11-08', '2024-11-15', 'Take before meals. Do not drink alcohol while on this medication.'),
(14, 14, 1, 14, '50mcg', 'Once daily', '2024-11-08', '2024-11-22', 'Administer nasal spray into each nostril. Do not blow your nose for 10 minutes after use.'),
(15, 15, 5, 15, '75mg', 'Once daily for 5 days', '2024-11-09', '2024-11-14', 'Take with or without food. Best if taken within 48 hours of flu symptoms appearing.'),
(16, 16, 6, 16, '50mg', 'Once daily', '2024-11-09', '2024-12-09', 'Take with food. Monitor for dizziness and fatigue.'),
(17, 17, 7, 17, '60mg', 'Once daily', '2024-11-10', '2024-12-10', 'Take with or without food. May cause drowsiness.'),
(18, 18, 8, 18, 'None', 'As needed for pain', '2024-11-10', '2024-12-10', 'Follow up in 1 month. Engage in physical therapy as recommended.'),
(19, 19, 9, 19, '0.1%', 'Apply to affected area once or twice daily', '2024-11-11', '2024-12-11', 'Do not apply to broken skin. Wash hands after application.'),
(20, 20, 10, 20, '25mg', 'Once daily', '2024-11-11', '2024-12-11', 'Take with or without food. Do not discontinue abruptly. Monitor for side effects.');


/* 13. Wards Table
    Static Ward Details with additional columns
*/
DROP TABLE IF EXISTS Wards;
CREATE TABLE Wards (
    WardID INT PRIMARY KEY,
    WardName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    Capacity INT,
    Floor INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

/* Insert Wards */
INSERT INTO Wards (WardID, WardName, DepartmentID, Capacity, Floor) VALUES
(1, 'Ward A', 1, 20, 1),
(2, 'Ward B', 2, 25, 2),
(3, 'Ward C', 3, 30, 3),
(4, 'Ward D', 4, 15, 4),
(5, 'Ward E', 5, 10, 5);

/* 14. Rooms Table
    Static Room details with additional columns
*/
DROP TABLE IF EXISTS Rooms;
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY,
    WardID INT,
    RoomNumber VARCHAR(10) NOT NULL,
    RoomType ENUM('General', 'Private', 'ICU', 'Operating') NOT NULL,
    Capacity INT,
    Floor INT, 
    FOREIGN KEY (WardID) REFERENCES Wards(WardID)
);

/* Insert Rooms */
INSERT INTO Rooms (RoomID, WardID, RoomNumber, RoomType, Capacity, Floor)
VALUES
(1, 1, '101', 'General', 4, 1),
(2, 1, '102', 'General', 4, 1),
(3, 1, '103', 'Private', 1, 1),
(4, 1, '104', 'ICU', 1, 1),
(5, 2, '201', 'General', 4, 2),
(6, 2, '202', 'General', 4, 2),
(7, 2, '203', 'Private', 1, 2),
(8, 2, '204', 'Operating', 0, 2), -- Operating room, no capacity needed
(9, 3, '301', 'General', 4, 3),
(10, 3, '302', 'General', 4, 3),
(11, 3, '303', 'Private', 1, 3),
(12, 3, '304', 'ICU', 1, 3),
(13, 4, '401', 'General', 4, 4),
(14, 4, '402', 'General', 4, 4),
(15, 4, '403', 'Private', 1, 4),
(16, 4, '404', 'Operating', 0, 4), -- Operating room
(17, 5, '501', 'General', 4, 5),
(18, 5, '502', 'General', 4, 5),
(19, 5, '503', 'Private', 1, 5),
(20, 5, '504', 'ICU', 1, 5);


/* 15. Beds Table
    Static bed details with additional columns
*/
DROP TABLE IF EXISTS Beds;
CREATE TABLE Beds (
    BedID INT PRIMARY KEY,
    RoomID INT,
    BedNumber VARCHAR(10) NOT NULL,
    Status ENUM('Available', 'Occupied', 'Maintenance') NOT NULL,
    BedType ENUM('Standard', 'Deluxe', 'ICU', 'Surgical') DEFAULT 'Standard', 
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

/* Insert Beds */
INSERT INTO Beds (BedID, RoomID, BedNumber, Status, BedType) VALUES
(1, 1, 'B1', 'Available', 'Standard'),
(2, 1, 'B2', 'Occupied', 'Standard'),
(3, 1, 'B3', 'Occupied', 'Deluxe'),
(4, 1, 'B4', 'Available', 'Standard'),
(5, 1, 'B5', 'Maintenance', 'ICU'),
(6, 2, 'B1', 'Available', 'Surgical'),
(7, 2, 'B2', 'Occupied', 'ICU'),
(8, 2, 'B3', 'Available', 'Standard'),
(9, 2, 'B4', 'Occupied', 'Surgical'),
(10, 2, 'B5', 'Maintenance', 'Deluxe'),
(11, 3, 'B1', 'Occupied', 'Standard'),
(12, 3, 'B2', 'Available', 'Standard'),
(13, 3, 'B3', 'Occupied', 'ICU'),
(14, 3, 'B4', 'Available', 'Deluxe'),
(15, 3, 'B5', 'Occupied', 'Surgical'),
(16, 4, 'B1', 'Available', 'Standard'),
(17, 4, 'B2', 'Maintenance', 'Deluxe'),
(18, 4, 'B3', 'Occupied', 'Surgical'),
(19, 4, 'B4', 'Available', 'ICU'),
(20, 5, 'B1', 'Occupied', 'ICU');


/* 16. PatientAdmissions Table
    Records patient admissions with additional columns
*/
DROP TABLE IF EXISTS PatientAdmissions;
CREATE TABLE PatientAdmissions (
    AdmissionID INT PRIMARY KEY,
    PatientID INT,
    BedID INT,
    AdmissionDateTime DATETIME,
    DischargeDateTime DATETIME,
    AdmissionReason TEXT,
    DischargeSummary TEXT, 
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (BedID) REFERENCES Beds(BedID)
);

/* Insert Patient Admissions */
INSERT INTO PatientAdmissions (AdmissionID, PatientID, BedID, AdmissionDateTime, DischargeDateTime, AdmissionReason, DischargeSummary) VALUES
(1, 1, 1, '2024-11-01 08:00:00', '2024-11-07 10:00:00', 'Pneumonia', 'Patient stabilized and discharged after 7 days of antibiotic therapy'),
(2, 2, 2, '2024-11-02 09:30:00', '2024-11-05 14:00:00', 'Appendicitis', 'Appendectomy performed, discharged in stable condition'),
(3, 3, 3, '2024-11-03 14:00:00', '2024-11-10 12:00:00', 'Chronic back pain', 'Patient discharged after pain management and physical therapy'),
(4, 4, 4, '2024-11-04 07:00:00', '2024-11-08 09:00:00', 'Asthma attack', 'Patient stable and discharged after treatment with bronchodilators'),
(5, 5, 5, '2024-11-05 10:00:00', '2024-11-10 13:00:00', 'Post-surgery recovery', 'Recovery after knee surgery, discharged with follow-up care instructions'),
(6, 6, 6, '2024-11-06 08:00:00', '2024-11-09 11:00:00', 'Urinary tract infection', 'UTI treated with antibiotics, discharged after stabilization'),
(7, 7, 7, '2024-11-07 10:30:00', '2024-11-12 15:00:00', 'Influenza', 'Flu symptoms resolved, discharged with recommendations for rest and hydration'),
(8, 8, 8, '2024-11-08 13:00:00', '2024-11-14 14:00:00', 'Hypertension crisis', 'Blood pressure stabilized, discharged with medication plan and lifestyle changes'),
(9, 9, 9, '2024-11-09 11:00:00', '2024-11-14 16:00:00', 'Acid reflux', 'Patient discharged after successful treatment with proton pump inhibitors'),
(10, 10, 10, '2024-11-10 09:30:00', '2024-11-12 17:00:00', 'Diabetes complication', 'Blood sugar levels stabilized, patient discharged with diabetes management plan'),
(11, 11, 11, '2024-11-11 12:00:00', '2024-11-14 18:00:00', 'Post-surgery recovery', 'Recovery after appendectomy, patient discharged with follow-up instructions'),
(12, 12, 12, '2024-11-12 14:30:00', '2024-11-16 09:00:00', 'Gastritis', 'Patient stabilized, treated with acid-suppressants, discharged with dietary recommendations'),
(13, 13, 13, '2024-11-13 08:00:00', '2024-11-18 12:00:00', 'Chronic fatigue syndrome', 'Patient advised to manage symptoms with rest and lifestyle adjustments, discharged'),
(14, 14, 14, '2024-11-14 09:00:00', '2024-11-17 11:00:00', 'Rheumatoid arthritis flare', 'Medication adjustment and physical therapy, patient discharged with follow-up plan'),
(15, 15, 15, '2024-11-15 10:30:00', '2024-11-19 14:00:00', 'Severe dehydration', 'Hydration therapy administered, patient discharged in stable condition'),
(16, 16, 16, '2024-11-16 07:30:00', '2024-11-18 10:00:00', 'Chronic sinusitis', 'Nasal decongestant and rest, patient discharged after improvement'),
(17, 17, 17, '2024-11-17 08:00:00', '2024-11-20 12:00:00', 'Surgical recovery', 'Post-operative care after surgery, patient discharged with home care instructions'),
(18, 18, 18, '2024-11-18 09:30:00', '2024-11-22 13:00:00', 'Heart attack', 'Patient stabilized, discharged after cardiac rehabilitation and medication adjustments'),
(19, 19, 19, '2024-11-19 10:00:00', '2024-11-23 15:00:00', 'Stroke', 'Rehabilitation started, patient discharged with home care and follow-up therapy'),
(20, 20, 20, '2024-11-20 11:00:00', '2024-11-24 16:00:00', 'Pneumonia', 'Patient treated with antibiotics and respiratory therapy, discharged after improvement'),
(21, 21, 1, '2024-11-21 12:00:00', '2024-11-24 18:00:00', 'Back surgery recovery', 'Patient discharged after back surgery with pain management instructions'),
(22, 22, 2, '2024-11-22 09:00:00', '2024-11-25 11:00:00', 'Anemia', 'Iron supplements and dietary adjustments, patient discharged after recovery'),
(23, 23, 3, '2024-11-23 13:00:00', '2024-11-27 14:00:00', 'Chronic depression', 'Patient discharged after psychiatric stabilization and medication prescription'),
(24, 24, 4, '2024-11-24 10:00:00', '2024-11-27 15:00:00', 'Acute bronchitis', 'Bronchodilators and cough medication prescribed, patient discharged in stable condition'),
(25, 25, 5, '2024-11-25 09:30:00', '2024-11-29 13:30:00', 'Post-surgery recovery', 'Recovery after hip replacement surgery, patient discharged with physical therapy instructions'),
(26, 26, 6, '2024-11-26 14:00:00', '2024-11-30 10:00:00', 'Gout attack', 'Gout treated with colchicine, patient discharged with follow-up care'),
(27, 27, 7, '2024-11-27 15:00:00', '2024-11-30 11:00:00', 'Kidney stones', 'Patient discharged after pain management and recommendations for hydration'),
(28, 28, 8, '2024-11-28 16:00:00', '2024-12-02 09:00:00', 'Severe burns', 'Burns treated, patient discharged after skin graft surgery and care instructions'),
(29, 29, 9, '2024-11-29 10:00:00', '2024-12-03 14:00:00', 'Migraine', 'Patient stabilized with pain relief and lifestyle management, discharged after symptom resolution'),
(30, 30, 10, '2024-11-30 11:30:00', '2024-12-04 16:00:00', 'Gallstones', 'Laparoscopic cholecystectomy performed, patient discharged with post-surgery instructions'),
(31, 31, 11, '2024-12-01 13:00:00', '2024-12-05 17:00:00', 'Post-traumatic stress disorder', 'Stabilized with therapy, patient discharged with counseling recommendations'),
(32, 32, 12, '2024-12-02 10:00:00', '2024-12-06 14:00:00', 'Severe headache', 'Migraines treated with medication, patient discharged after symptom improvement'),
(33, 33, 13, '2024-12-03 11:00:00', '2024-12-07 12:00:00', 'Lung infection', 'Patient treated with antibiotics, discharged after recovery'),
(34, 34, 14, '2024-12-04 12:00:00', '2024-12-08 16:00:00', 'Fractured leg', 'Fracture treated with cast, patient discharged after pain management');

/* 17. Inventory Table
    Pharmacy inventory details with additional columns
*/
DROP TABLE IF EXISTS Inventory;
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    ItemName VARCHAR(100) NOT NULL,
    ItemType ENUM('Medication', 'Supply', 'Equipment') NOT NULL,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    ExpirationDate DATE,
    Supplier VARCHAR(100), 
    ReorderLevel INT DEFAULT 10
);

/* Insert Inventory Items */
INSERT INTO Inventory (InventoryID, ItemName, ItemType, Quantity, UnitPrice, ExpirationDate, Supplier, ReorderLevel) 
VALUES
(1, 'Amlodipine 5mg', 'Medication', 200, 0.10, '2025-12-01', 'PharmaCorp', 20),
(2, 'Albuterol Inhaler', 'Medication', 50, 15.00, '2026-06-15', 'RespiraMed', 10),
(3, 'Omeprazole 20mg', 'Medication', 150, 0.08, '2025-09-30', 'HealPlus', 15),
(4, 'Surgical Mask', 'Supply', 5000, 0.50, '2025-05-10', 'MedSupplies Co.', 200),
(5, 'Sterile Gauze Pads', 'Supply', 1000, 0.20, '2026-03-01', 'HealthCare Supplies', 100),
(6, 'Wheelchair', 'Equipment', 25, 150.00, '2027-08-15', 'CareEquip', 5),
(7, 'IV Fluid Set', 'Supply', 200, 5.00, '2025-11-20', 'MedSolutions', 20),
(8, 'Ciprofloxacin 500mg', 'Medication', 120, 0.25, '2026-02-10', 'CurePharma', 25),
(9, 'Defibrillator', 'Equipment', 5, 1200.00, '2027-06-01', 'HeartTech', 2),
(10, 'Blood Pressure Monitor', 'Equipment', 15, 75.00, Null, 'MedTech', 5),
(11, 'Fluticasone Nasal Spray', 'Medication', 100, 10.00,'2027-06-01', 'PharmaMed', 10),
(12, 'Loratadine 10mg', 'Medication', 300, 0.15, '2027-06-01','AllergyMed', 30),
(13, 'Nitrile Gloves (Box of 100)', 'Supply', 150, 7.50, null, 'GloveWorks', 50),
(14, 'Thermometer', 'Equipment', 50, 25.00, null,'HealthPro', 10),
(15, 'Acetaminophen 500mg', 'Medication', 500, 0.10,'2027-06-01', 'PainRelief Corp.', 50),
(16, 'Surgical Scissors', 'Equipment', 30, 40.00,null, 'MedEquip Ltd.', 5),
(17, 'Oxygen Tank', 'Equipment', 20, 350.00, null,'OxygenWorld', 3),
(18, 'Insulin Syringes (Box of 100)', 'Supply', 80, 12.00,'2027-06-01', 'DiabetesCare', 15),
(19, 'Antibiotic Cream 20g', 'Medication', 200, 3.00, null, 'WoundCare Inc.', 20),
(20, 'Face Shield', 'Supply', 500, 6.00,'2027-06-01', 'ProtectiveGear', 50);



/* 18. PharmacyOrderHistory Table
    Merged PharmacyOrders and PharmacyOrderDetails with additional columns
*/
DROP TABLE IF EXISTS PharmacyOrderHistory;
CREATE TABLE PharmacyOrderHistory (
    OrderHistoryID INT PRIMARY KEY,
    PatientID INT,
    StaffID INT,
    OrderDate DATE,
    Status ENUM('Pending', 'Filled', 'Cancelled') NOT NULL,
    MedicationID INT,
    Quantity INT,
    OrderComments TEXT, 
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (MedicationID) REFERENCES Medications(MedicationID)
);

/* Insert Pharmacy Order History */
INSERT INTO PharmacyOrderHistory (OrderHistoryID, PatientID, StaffID, OrderDate, Status, MedicationID, Quantity, OrderComments)
VALUES
(1, 1, 2, '2024-11-01', 'Pending', 1, 30, 'Initial prescription order for hypertension medication.'),
(2, 2, 3, '2024-11-02', 'Filled', 2, 10, 'Order for Albuterol inhalers to manage asthma symptoms.'),
(3, 3, 4, '2024-11-02', 'Cancelled', 3, 50, 'Patient canceled order for Omeprazole.'),
(4, 4, 5, '2024-11-03', 'Filled', 4, 100, 'Surgical masks for hospital staff and patients.'),
(5, 5, 6, '2024-11-03', 'Pending', 5, 200, 'Supply order for sterile gauze pads.'),
(6, 6, 7, '2024-11-04', 'Filled', 6, 25, 'Order for wheelchairs for new patients.'),
(7, 7, 8, '2024-11-05', 'Pending', 7, 200, 'IV Fluid sets required for emergency cases.'),
(8, 8, 9, '2024-11-05', 'Filled', 8, 60, 'Prescription for Ciprofloxacin to treat bacterial infection.'),
(9, 9, 10, '2024-11-06', 'Filled', 9, 2, 'Defibrillator units ordered for the cardiac care unit.'),
(10, 10, 11, '2024-11-06', 'Filled', 10, 15, 'Blood Pressure Monitors for routine patient checkups.'),
(11, 11, 12, '2024-11-07', 'Pending', 11, 50, 'Fluticasone nasal spray for allergy management.'),
(12, 12, 13, '2024-11-07', 'Pending', 12, 100, 'Loratadine ordered for seasonal allergies.'),
(13, 13, 14, '2024-11-08', 'Filled', 13, 150, 'Nitrile gloves (box of 100) for staff use.'),
(14, 14, 15, '2024-11-08', 'Cancelled', 14, 50, 'Thermometers order canceled due to low demand.'),
(15, 15, 16, '2024-11-09', 'Filled', 15, 200, 'Acetaminophen 500mg for pain management in patients.'),
(16, 16, 17, '2024-11-09', 'Pending', 16, 30, 'Surgical scissors for hospital operations.'),
(17, 17, 18, '2024-11-10', 'Filled', 17, 5, 'Oxygen tanks for ICU patient use.'),
(18, 18, 19, '2024-11-10', 'Pending', 18, 100, 'Insulin syringes (box of 100) for diabetic patients.'),
(19, 19, 20, '2024-11-11', 'Filled', 19, 200, 'Antibiotic cream 20g for wound care treatment.'),
(20, 20, 2, '2024-11-11', 'Pending', 20, 500, 'Face shields ordered for PPE in medical staff.');


/* 19. LabTests Table
    Lab Test details with additional columns
*/
DROP TABLE IF EXISTS LabTests;
CREATE TABLE LabTests (
    TestID INT PRIMARY KEY,
    TestName VARCHAR(100) NOT NULL,
    Description TEXT,
    Cost DECIMAL(10,2),
    RequiredEquipment VARCHAR(100),
    PreparationInstructions TEXT 
);

/* Insert Lab Tests */
INSERT INTO LabTests (TestID, TestName, Description, Cost, RequiredEquipment, PreparationInstructions) VALUES
(1, 'Blood Test', 'Complete Blood Count', 50.00, 'Blood Collection Kit', 'Fasting not required'),
(2, 'X-Ray', 'Chest X-Ray', 100.00, 'X-Ray Machine', 'Remove metallic objects'),
(3, 'MRI', 'Magnetic Resonance Imaging', 150.00, 'MRI Scanner', 'No metal implants'),
(4, 'CT Scan', 'Computed Tomography Scan', 200.00, 'CT Scanner', 'Fasting for 4 hours'),
(5, 'Urine Test', 'Urinalysis', 25.00, 'Urine Collection Kit', 'Midstream sample required');

/* 20. LabOrderHistory Table
    Merged LabOrders and LabResults with additional columns
*/
DROP TABLE IF EXISTS LabOrderHistory;
CREATE TABLE LabOrderHistory (
    LabOrderHistoryID INT PRIMARY KEY,
    PatientID INT,
    StaffID INT,
    OrderDate DATE,
    Status ENUM('Ordered', 'In Progress', 'Completed') NOT NULL,
    TestID INT,
    ResultValue TEXT,
    ReferenceRange VARCHAR(50),
    ResultDate DATE,
    OrderComments TEXT, 
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
    FOREIGN KEY (TestID) REFERENCES LabTests(TestID)
);

/* Insert Lab Order History */
-- Insert 20 LabOrderHistory entries
INSERT INTO LabOrderHistory (LabOrderHistoryID, PatientID, StaffID, OrderDate, Status, TestID, ResultValue, ReferenceRange, ResultDate, OrderComments)
VALUES 
(1, 1, 2, '2024-11-01', 'Ordered', 1, NULL, 'Red blood cells: 4.2 - 5.9 million/uL', NULL, 'General blood work for routine checkup.'),
(2, 2, 3, '2024-11-02', 'Completed', 2, 'Fracture detected in the left femur', 'Bone density: Normal', '2024-11-03', 'Patient underwent X-Ray for suspected bone fracture.'),
(3, 3, 4, '2024-11-03', 'In Progress', 3, NULL, 'pH: 4.5 - 8.0, Glucose: 0 - 100 mg/dL', NULL, 'Urine test for diabetes and kidney function.'),
(4, 4, 5, '2024-11-04', 'Ordered', 5, NULL, 'Heart rate: 60-100 bpm, Rhythm: Normal', NULL, 'ECG to assess heart activity after chest pain episode.'),
(5, 5, 6, '2024-11-04', 'Completed', 4, 'Red blood cell count: 4.5 million/uL', 'RBC count: 4.2 - 5.9 million/uL', '2024-11-05', 'Routine blood test to check for anemia.'),
(6, 6, 7, '2024-11-05', 'In Progress', 2, NULL, 'Normal bone structure', NULL, 'X-Ray ordered to assess suspected fractures.'),
(7, 7, 8, '2024-11-06', 'Ordered', 3, NULL, 'Glucose: 80 - 120 mg/dL', NULL, 'Urine test to monitor blood sugar levels in diabetic patient.'),
(8, 8, 9, '2024-11-07', 'In Progress', 4, NULL, 'Heart rhythm: Normal', NULL, 'ECG ordered to monitor heart rate for arrhythmia concerns.'),
(9, 9, 10, '2024-11-08', 'Completed', 1, 'Hemoglobin: 13.5 g/dL', 'Hemoglobin: 12 - 16 g/dL', '2024-11-09', 'Blood test to evaluate anemia and overall health.'),
(10, 10, 11, '2024-11-09', 'Ordered', 5, NULL, 'Normal lung and chest structure', NULL, 'X-Ray for chest pain and shortness of breath.'),
(11, 11, 12, '2024-11-10', 'In Progress', 3, NULL, 'Urine color: Pale yellow, pH: 6.0', NULL, 'Routine urine test to monitor kidney function.'),
(12, 12, 13, '2024-11-10', 'Ordered', 4, NULL, 'Heart rate: 70 bpm, Rhythm: Normal', NULL, 'ECG to monitor heart health after patient reported chest discomfort.'),
(13, 13, 14, '2024-11-11', 'Completed', 1, 'White blood cell count: 7.0 k/uL', 'WBC: 4.5 - 11.0 k/uL', '2024-11-12', 'Blood test to check for infections and immune function.'),
(14, 14, 15, '2024-11-12', 'In Progress', 5, NULL, 'Normal bone alignment', NULL, 'X-Ray to assess back pain and suspected spinal misalignment.'),
(15, 15, 16, '2024-11-13', 'Ordered', 4, NULL, 'Specific gravity: 1.005 - 1.030', NULL, 'Urine test for kidney function and hydration levels.'),
(16, 16, 17, '2024-11-13', 'Completed', 4, 'Heart rate: 72 bpm', 'Normal: 60 - 100 bpm', '2024-11-14', 'ECG to monitor for any irregularities in heart rate.'),
(17, 17, 18, '2024-11-14', 'Ordered', 1, NULL, 'Hematocrit: 37-47%', NULL, 'Blood test for ongoing evaluation of chronic fatigue.'),
(18, 18, 19, '2024-11-14', 'Completed', 2, 'No fractures detected', 'Normal bone structure', '2024-11-15', 'X-Ray to monitor for fractures after fall.'),
(19, 19, 20, '2024-11-15', 'In Progress', 3, NULL, 'Urine glucose: < 100 mg/dL', NULL, 'Urine test for diabetic monitoring.'),
(20, 20, 2, '2024-11-15', 'Completed', 5, 'Normal heart rhythm', 'Normal: 60 - 100 bpm', '2024-11-16', 'ECG performed due to patient’s heart palpitations.');


/* 21. PatientInsurance Table
    Insurance details with additional columns and replaced Insurance table with ENUM
*/
DROP TABLE IF EXISTS PatientInsurance;
CREATE TABLE PatientInsurance (
    PatientInsuranceID INT PRIMARY KEY,
    PatientID INT,
    InsuranceProvider ENUM('MediCare', 'HealthPlus', 'LifeGuard', 'SecureHealth', 'WellCare') NOT NULL, -- Available Insurances
    PolicyNumber VARCHAR(50),
    ExpirationDate DATE,
    CoverageDetails TEXT, 
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

/* Insert Patient Insurance */
INSERT INTO PatientInsurance (PatientInsuranceID, PatientID, InsuranceProvider, PolicyNumber, ExpirationDate, CoverageDetails)
VALUES
(1, 1, 'MediCare', 'MC12345', '2025-12-31', 'Full coverage for hospital stays, surgeries, and outpatient services.'),
(2, 2, 'HealthPlus', 'HP67890', '2026-01-15', 'Coverage includes outpatient care, emergency services, and prescription medications.'),
(3, 3, 'LifeGuard', 'LG23456', '2025-11-01', 'Full health insurance with wellness programs and preventive services included.'),
(4, 4, 'SecureHealth', 'SH98765', '2026-07-22', 'Provides coverage for inpatient care, mental health services, and emergency treatments.'),
(5, 5, 'WellCare', 'WC54321', '2026-03-10', 'Extensive dental and vision coverage, including preventive care.'),
(6, 6, 'MediCare', 'MC54321', '2027-05-30', 'Comprehensive coverage for hospital, outpatient, and rehabilitation services.'),
(7, 7, 'HealthPlus', 'HP11223', '2025-09-20', 'Includes preventive services, emergency care, and mental health benefits.'),
(8, 8, 'LifeGuard', 'LG99887', '2025-06-25', 'Complete health plan with hospital stays, diagnostic services, and emergency treatments.'),
(9, 9, 'SecureHealth', 'SH44556', '2026-12-05', 'Coverage includes surgery, outpatient services, and chronic disease management.'),
(10, 10, 'WellCare', 'WC78789', '2026-09-15', 'Full coverage for health checkups, vaccinations, and hospitalization needs.'),
(11, 11, 'MediCare', 'MC10234', '2025-08-19', 'General health insurance with coverage for prescription drugs and hospital care.'),
(12, 12, 'HealthPlus', 'HP54678', '2026-04-10', 'Coverage for inpatient, outpatient care, and rehabilitation services.'),
(13, 13, 'LifeGuard', 'LG65432', '2025-12-25', 'Full coverage for preventive health services, including screenings and immunizations.'),
(14, 14, 'SecureHealth', 'SH34211', '2026-02-20', 'Comprehensive medical insurance for maternity, child care, and outpatient services.'),
(15, 15, 'WellCare', 'WC78765', '2027-01-18', 'Emergency care, hospital stays, and routine checkups with prescription coverage.'),
(16, 16, 'MediCare', 'MC32456', '2025-10-30', 'Coverage for chronic disease management, outpatient care, and surgery.'),
(17, 17, 'HealthPlus', 'HP23122', '2026-03-25', 'Full coverage for outpatient treatment, surgeries, and emergency care.'),
(18, 18, 'LifeGuard', 'LG99812', '2025-04-10', 'Includes vision, dental, and mental health benefits along with hospitalization.'),
(19, 19, 'SecureHealth', 'SH12345', '2027-08-01', 'Complete insurance for all medical needs, including surgery and inpatient care.'),
(20, 20, 'WellCare', 'WC67890', '2026-11-30', 'Comprehensive coverage including physical therapy, diagnostics, and surgery.');


/* 22. Billing Table
    Billing details with additional columns
*/
DROP TABLE IF EXISTS Billing;
CREATE TABLE Billing (
    BillingID INT PRIMARY KEY,
    PatientID INT,
    AdmissionID INT,
    BillingDate DATE,
    TotalAmount DECIMAL(10,2),
    PaymentStatus ENUM('Pending', 'Partial', 'Paid') NOT NULL,
    InsuranceClaim DECIMAL(10,2),
    PatientResponsibility DECIMAL(10,2),
    PaymentMethod ENUM('Cash', 'Credit Card', 'Insurance', 'Online Payment') NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (AdmissionID) REFERENCES PatientAdmissions(AdmissionID)
);

/* Insert Billing Records */
INSERT INTO Billing (BillingID, PatientID, AdmissionID, BillingDate, TotalAmount, PaymentStatus, InsuranceClaim, PatientResponsibility, PaymentMethod)
VALUES
(1, 1, 1, '2024-11-01', 2500.00, 'Pending', 1500.00, 1000.00, 'Insurance'),
(2, 2, 2, '2024-11-02', 3000.00, 'Paid', 2000.00, 1000.00, 'Credit Card'),
(3, 3, 3, '2024-11-03', 4500.00, 'Partial', 3500.00, 1000.00, 'Online Payment'),
(4, 4, 4, '2024-11-04', 1200.00, 'Paid', 800.00, 400.00, 'Cash'),
(5, 5, 5, '2024-11-05', 2000.00, 'Pending', 1500.00, 500.00, 'Insurance'),
(6, 6, 6, '2024-11-06', 5000.00, 'Paid', 3000.00, 2000.00, 'Credit Card'),
(7, 7, 7, '2024-11-07', 3500.00, 'Partial', 2000.00, 1500.00, 'Insurance'),
(8, 8, 8, '2024-11-08', 1000.00, 'Paid', 0.00, 1000.00, 'Cash'),
(9, 9, 9, '2024-11-09', 1800.00, 'Pending', 1300.00, 500.00, 'Online Payment'),
(10, 10, 10, '2024-11-10', 2500.00, 'Paid', 2000.00, 500.00, 'Insurance'),
(11, 11, 11, '2024-11-11', 3500.00, 'Partial', 2500.00, 1000.00, 'Credit Card'),
(12, 12, 12, '2024-11-12', 4200.00, 'Paid', 3000.00, 1200.00, 'Cash'),
(13, 13, 13, '2024-11-13', 1500.00, 'Pending', 1000.00, 500.00, 'Insurance'),
(14, 14, 14, '2024-11-14', 5500.00, 'Partial', 3500.00, 2000.00, 'Credit Card'),
(15, 15, 15, '2024-11-15', 2400.00, 'Paid', 2000.00, 400.00, 'Online Payment'),
(16, 16, 16, '2024-11-16', 1800.00, 'Pending', 1000.00, 800.00, 'Cash'),
(17, 17, 17, '2024-11-17', 3000.00, 'Partial', 1500.00, 1500.00, 'Insurance'),
(18, 18, 18, '2024-11-18', 2300.00, 'Paid', 1800.00, 500.00, 'Credit Card'),
(19, 19, 19, '2024-11-19', 4000.00, 'Pending', 2500.00, 1500.00, 'Online Payment'),
(20, 20, 20, '2024-11-20', 3800.00, 'Paid', 3000.00, 800.00, 'Cash');


/* 23. BillingHistory Table
    Tracks history of billing status changes
*/
DROP TABLE IF EXISTS BillingHistory;
CREATE TABLE BillingHistory (
    BillingHistoryID INT PRIMARY KEY,
    BillingID INT,
    ChangedBy INT, -- StaffID who made the change
    ChangeDateTime DATETIME,
    PreviousPaymentStatus ENUM('Pending', 'Partial', 'Paid'),
    NewPaymentStatus ENUM('Pending', 'Partial', 'Paid'),
    PreviousInsuranceClaim DECIMAL(10,2),
    NewInsuranceClaim DECIMAL(10,2),
    PreviousPatientResponsibility DECIMAL(10,2),
    NewPatientResponsibility DECIMAL(10,2),
    Comments TEXT,
    FOREIGN KEY (BillingID) REFERENCES Billing(BillingID),
    FOREIGN KEY (ChangedBy) REFERENCES Staff(StaffID)
);

/* Insert BillingHistory Records */
INSERT INTO BillingHistory (BillingHistoryID, BillingID, ChangedBy, ChangeDateTime, PreviousPaymentStatus, NewPaymentStatus, PreviousInsuranceClaim, NewInsuranceClaim, PreviousPatientResponsibility, NewPatientResponsibility, Comments)
VALUES
(1, 1, 1, '2024-11-02 10:15:00', 'Pending', 'Paid', 1500.00, 1500.00, 1000.00, 0.00, 'Insurance claim processed and full payment received.'),
(2, 2, 2, '2024-11-03 11:00:00', 'Paid', 'Partial', 2000.00, 1800.00, 1000.00, 1200.00, 'Partial payment made; insurance claim adjusted.'),
(3, 3, 3, '2024-11-04 14:30:00', 'Partial', 'Paid', 3500.00, 3700.00, 1000.00, 0.00, 'Patient made final payment and insurance coverage was adjusted.'),
(4, 4, 4, '2024-11-05 16:45:00', 'Paid', 'Pending', 800.00, 0.00, 400.00, 800.00, 'Payment reversed due to billing dispute.'),
(5, 5, 5, '2024-11-06 09:00:00', 'Pending', 'Paid', 1500.00, 1700.00, 500.00, 0.00, 'Insurance claim was approved and full payment received.'),
(6, 6, 6, '2024-11-07 12:00:00', 'Paid', 'Pending', 3000.00, 0.00, 2000.00, 3000.00, 'Patient’s payment rejected due to insufficient funds, payment reverted.'),
(7, 7, 7, '2024-11-08 08:30:00', 'Partial', 'Paid', 2000.00, 2200.00, 1500.00, 0.00, 'Patient made an additional payment and insurance amount updated.'),
(8, 8, 8, '2024-11-09 10:15:00', 'Pending', 'Paid', 0.00, 500.00, 1000.00, 0.00, 'Patient paid in full after initial pending status due to insurance claim finalization.'),
(9, 9, 9, '2024-11-10 11:30:00', 'Paid', 'Pending', 1300.00, 1000.00, 500.00, 1000.00, 'Reversed payment due to incorrect insurance billing.'),
(10, 10, 10, '2024-11-11 13:45:00', 'Paid', 'Partial', 2000.00, 2200.00, 500.00, 1200.00, 'Patient paid partial amount after insurance claim was updated.'),
(11, 11, 11, '2024-11-12 09:30:00', 'Pending', 'Paid', 0.00, 1200.00, 800.00, 0.00, 'Final payment received after insurance settlement.'),
(12, 12, 12, '2024-11-13 14:00:00', 'Paid', 'Partial', 3000.00, 2800.00, 1200.00, 1500.00, 'Partial payment received, insurance coverage adjusted.'),
(13, 13, 13, '2024-11-14 17:00:00', 'Pending', 'Paid', 1500.00, 2000.00, 500.00, 0.00, 'Payment completed after insurance adjustment.'),
(14, 14, 14, '2024-11-15 10:15:00', 'Partial', 'Paid', 3500.00, 3300.00, 1500.00, 0.00, 'Patient paid additional amount to finalize billing.'),
(15, 15, 15, '2024-11-16 12:00:00', 'Paid', 'Pending', 2000.00, 0.00, 500.00, 2000.00, 'Payment reversed due to billing error. Awaiting insurance update.'),
(16, 16, 16, '2024-11-17 14:30:00', 'Pending', 'Paid', 1500.00, 1700.00, 800.00, 0.00, 'Patient’s insurance claim was approved and final payment completed.'),
(17, 17, 17, '2024-11-18 08:00:00', 'Paid', 'Partial', 2500.00, 2300.00, 1000.00, 1500.00, 'Partial payment received after insurance was billed.'),
(18, 18, 18, '2024-11-19 09:45:00', 'Partial', 'Paid', 1800.00, 2100.00, 1000.00, 800.00, 'Patient paid off partial balance, insurance payment adjusted accordingly.'),
(19, 19, 19, '2024-11-20 10:30:00', 'Paid', 'Pending', 1800.00, 0.00, 500.00, 1800.00, 'Insurance claim adjustment caused delay in final payment.'),
(20, 20, 20, '2024-11-21 11:30:00', 'Pending', 'Paid', 2500.00, 2800.00, 800.00, 0.00, 'Payment finalized after insurance was confirmed to cover the entire amount.');


/* 24. AdmissionStaff Table
    Junction table to handle many-to-many relationships between PatientAdmissions and Staff
*/
DROP TABLE IF EXISTS AdmissionStaff;
CREATE TABLE AdmissionStaff (
    AdmissionID INT,
    StaffID INT,
    PRIMARY KEY (AdmissionID, StaffID),
    FOREIGN KEY (AdmissionID) REFERENCES PatientAdmissions(AdmissionID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

/* Insert AdmissionStaff Records */
INSERT INTO AdmissionStaff (AdmissionID, StaffID) VALUES
(1, 1),
(1, 2),
(2, 12),
(3, 3),
(4, 13),
(5, 5),
(13, 12),
(2, 2),
(20, 13),
(4, 3),
(15, 14),
(16, 2),
(20, 2),
(3, 16),
(4, 10),
(5, 6),
(20, 7),
(6, 3),
(7, 9),
(8, 4),
(10, 5);

/* 25. Department Head Table
    Junction table to handle cyclic relationships between Department and Staff
*/
DROP TABLE IF EXISTS DepartmenHeads;
CREATE TABLE DepartmenHeads (
    DepartmentID INT,
    StaffID INT,
    PRIMARY KEY (DepartmentID, StaffID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

INSERT INTO DepartmenHeads (DepartmentID, StaffID) VALUES
(1, 1),
(2, 7),
(3, 6),
(5, 14);









