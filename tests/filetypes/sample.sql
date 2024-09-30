-- SQL example to test editor settings

-- Create a new database
CREATE DATABASE CompanyDB;

-- Use the database
USE CompanyDB;

-- Create a table with various data types and constraints
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    HireDate DATE NOT NULL,
    JobTitle VARCHAR(50),
    Salary DECIMAL(10, 2) CHECK (Salary >= 0),
    DepartmentID INT,
    IsActive BOOLEAN DEFAULT TRUE,
    -- Foreign key constraint to reference the Departments table
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create a Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(50) NOT NULL,
    Location VARCHAR(100)
);

-- Insert data into Departments
INSERT INTO Departments (DepartmentName, Location)
VALUES
    ('Human Resources', 'New York'),
    ('Engineering', 'San Francisco'),
    ('Sales', 'Chicago');

-- Insert multiple records into Employees table
INSERT INTO Employees (FirstName, LastName, Email, PhoneNumber, HireDate, JobTitle, Salary, DepartmentID)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '2021-01-15', 'Software Engineer', 80000.00, 2),
    ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2020-05-22', 'HR Manager', 60000.00, 1),
    ('Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '2019-11-10', 'Sales Executive', 70000.00, 3);

-- Basic SELECT queries
SELECT * FROM Employees;

-- SELECT specific columns and use aliases
SELECT
    EmployeeID AS ID,
    FirstName AS Name,
    Salary * 1.05 AS 'Salary After Raise'
FROM Employees;

-- WHERE clause with multiple conditions
SELECT * FROM Employees
WHERE DepartmentID = 2 AND Salary > 50000;

-- ORDER BY clause to sort results
SELECT * FROM Employees
ORDER BY LastName ASC, FirstName DESC;

-- Aggregate functions: COUNT, SUM, AVG, MIN, MAX
SELECT
    COUNT(*) AS EmployeeCount,
    AVG(Salary) AS AverageSalary,
    SUM(Salary) AS TotalSalary
FROM Employees;

-- GROUP BY clause with HAVING
SELECT DepartmentID, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 60000;

-- JOIN two tables: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN
-- Inner Join example
SELECT
    Employees.EmployeeID,
    Employees.FirstName,
    Employees.LastName,
    Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- Left Join example
SELECT
    Employees.EmployeeID,
    Employees.FirstName,
    Employees.LastName,
    Departments.DepartmentName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- Subquery in a WHERE clause
SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- Subquery in a FROM clause
SELECT AVG(Salary) AS AverageSalary
FROM (SELECT Salary FROM Employees WHERE DepartmentID = 2) AS DeptSalaries;

-- Use of CASE statement for conditional logic
SELECT
    EmployeeID,
    FirstName,
    LastName,
    CASE
        WHEN Salary > 75000 THEN 'High Salary'
        WHEN Salary BETWEEN 50000 AND 75000 THEN 'Moderate Salary'
        ELSE 'Low Salary'
    END AS SalaryCategory
FROM Employees;

-- ALTER TABLE: Add a new column
ALTER TABLE Employees ADD COLUMN MiddleName VARCHAR(50);

-- Update rows in a table
UPDATE Employees
SET Salary = Salary * 1.1
WHERE JobTitle = 'Software Engineer';

-- DELETE rows from a table
DELETE FROM Employees
WHERE EmployeeID = 3;

-- Transactions: COMMIT and ROLLBACK
START TRANSACTION;

UPDATE Employees
SET Salary = Salary * 1.05
WHERE DepartmentID = 2;

-- Rollback the transaction if necessary
ROLLBACK;

-- Commit the transaction
COMMIT;

-- Creating an index
CREATE INDEX idx_department ON Employees (DepartmentID);

-- Dropping a table
DROP TABLE IF EXISTS Employees;

-- Dropping an index
DROP INDEX idx_department ON Employees;

-- View: Create a view
CREATE VIEW EmployeeOverview AS
SELECT
    Employees.EmployeeID,
    Employees.FirstName,
    Employees.LastName,
    Departments.DepartmentName,
    Employees.Salary
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;

-- Query the view
SELECT * FROM EmployeeOverview;

-- Stored Procedure: Create a stored procedure
DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN deptID INT)
BEGIN
    SELECT FirstName, LastName, JobTitle, Salary
    FROM Employees
    WHERE DepartmentID = deptID;
END $$

DELIMITER ;

-- Call the stored procedure
CALL GetEmployeesByDepartment(2);

-- Drop the stored procedure
DROP PROCEDURE IF EXISTS GetEmployeesByDepartment;

-- Stored Function: Create a stored function
DELIMITER $$

CREATE FUNCTION CalculateBonus (salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
    RETURN salary * 0.10;
END $$

DELIMITER ;

-- Use the stored function
SELECT FirstName, LastName, CalculateBonus(Salary) AS Bonus
FROM Employees;

-- Drop the stored function
DROP FUNCTION IF EXISTS CalculateBonus;
