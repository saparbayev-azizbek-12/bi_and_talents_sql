CREATE DATABASE lesson_11;
GO
USE lesson_11;

-- PUZZLE 1
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
	Name VARCHAR(50),
	Department VARCHAR(30),
	Salary INT
)

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'HR', 5000),
(2, 'Bob', 'IT', 7000),
(3, 'Charlie', 'Sales', 6000),
(4, 'David', 'HR', 5500),
(5, 'Emma', 'IT', 7200);

DROP TABLE IF EXISTS #EmployeeTransfers;
CREATE TABLE #EmployeeTransfers (
	EmployeeID INT PRIMARY KEY,
	Name VARCHAR(50),
	Department VARCHAR(30),
	Salary INT
)

INSERT INTO #EmployeeTransfers
SELECT 
	EmployeeID, 
	Name, 
	LAG(Department, 1, (SELECT TOP 1 Department FROM Employees ORDER BY EmployeeID DESC)) OVER(ORDER BY EmployeeID) AS Department,
	Salary
FROM Employees

SELECT * FROM Employees
SELECT * FROM #EmployeeTransfers

-- PUZZLE 2
CREATE TABLE Orders_DB1 (
	OrderID INT,
	CustomerName VARCHAR(50),
	Product VARCHAR(50),
	Quantity INT
);

CREATE TABLE Orders_DB2 (
	OrderID INT,
	CustomerName VARCHAR(50),
	Product VARCHAR(50),
	Quantity INT
);

INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

DECLARE @MissingOrders TABLE (
	OrderID INT,
	CustomerName VARCHAR(50),
	Product VARCHAR(50),
	Quantity INT
)

INSERT INTO @MissingOrders
SELECT D1.* FROM Orders_DB1 D1
LEFT JOIN Orders_DB2 D2
	ON D1.OrderID = D2.OrderID
WHERE D2.OrderID IS NULL

SELECT * FROM @MissingOrders

-- PUZZLE 3
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked) VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

GO
DROP VIEW IF EXISTS vw_MonthlyWorkSummary;
CREATE VIEW vw_MonthlyWorkSummary AS
SELECT
	EmployeeID,
	EmployeeName,
	Department,
	SUM(HoursWorked) AS TotalHoursWorked,
	SUM(HoursWorked) AS TotalHoursDepartment,
	AVG(HoursWorked) AS AvgHoursDepartment
FROM WorkLog
GROUP BY EmployeeID, EmployeeName, Department;

SELECT * FROM vw_MonthlyWorkSummary;

