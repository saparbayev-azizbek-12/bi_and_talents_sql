create database lesson_6;
go

use lesson_6;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);




-- INNER JOIN
SELECT Employees.Name, Departments.DepartmentName, Employees.Salary
FROM Employees
INNER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

-- LEFT JOIN
SELECT Employees.Name, Departments.DepartmentName, Employees.Salary
FROM Employees
LEFT OUTER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

-- RIGHT JOIN
SELECT Employees.Name, Departments.DepartmentName, Employees.Salary
FROM Employees
RIGHT OUTER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

-- FULL OUTER JOIN
SELECT Employees.Name, Departments.DepartmentName, Employees.Salary
FROM Employees
FULL OUTER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

-- JOIN with Aggregation
SELECT *, SUM(Salary) OVER(PARTITION BY DepartmentName ORDER BY DepartmentName DESC) AS TotalSalary FROM
(
	SELECT Employees.Name, Departments.DepartmentName, Employees.Salary
	FROM Employees
	FULL OUTER JOIN Departments
	ON Employees.DepartmentID = Departments.DepartmentID
) NewTable;

-- CROSS JOIN
SELECT Departments.DepartmentName, Projects.ProjectName
FROM Departments
CROSS JOIN Projects

-- MULTIPLE JOINS
SELECT 
    Employees.EmployeeID, 
    Employees.Name AS EmployeeName, 
    COALESCE(Departments.DepartmentName, 'Unassigned') AS DepartmentName,
    COALESCE(Projects.ProjectName, 'No Project') AS ProjectName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
LEFT JOIN Projects ON Employees.EmployeeID = Projects.EmployeeID;

