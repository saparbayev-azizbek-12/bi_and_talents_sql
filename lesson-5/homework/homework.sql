create database lesson_5;
go

use lesson_5;

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate) VALUES
(1, 'Alice Johnson', 'HR', 60000.00, '2020-03-15'),
(2, 'Bob Smith', 'IT', 75000.00, '2018-07-22'),
(3, 'Charlie Brown', 'Finance', 80000.00, '2019-11-05'),
(4, 'Diana Prince', 'Marketing', 70000.00, '2021-06-30'),
(5, 'Edward Wilson', 'IT', 85000.00, '2017-09-12'),
(6, 'Fiona Adams', 'Finance', 78000.00, '2016-05-20'),
(7, 'George Taylor', 'Sales', 72000.00, '2019-02-14'),
(8, 'Hannah White', 'HR', 62000.00, '2022-01-10'),
(9, 'Ian Black', 'IT', 88000.00, '2015-08-25'),
(10, 'Julia Green', 'Marketing', 69000.00, '2020-09-30'),
(11, 'Kevin Brown', 'Sales', 73000.00, '2018-11-12'),
(12, 'Laura Scott', 'Finance', 81000.00, '2017-07-03'),
(13, 'Michael King', 'IT', 92000.00, '2016-03-18'),
(14, 'Natalie Cooper', 'HR', 65000.00, '2019-12-05'),
(15, 'Oscar Rivera', 'Marketing', 71000.00, '2021-04-22'),
(16, 'Michael King', 'HR', 60000.00, '2020-03-15'),
(17, 'Ian Black', 'HR', 60000.00, '2020-03-15');


-- TASK 1
SELECT *, 
	ROW_NUMBER() OVER(ORDER BY Salary) AS RNK
FROM Employees
ORDER BY EmployeeID;

-- TASK 2
SELECT STRING_AGG(Name, ' ** '), RNK
FROM (
	SELECT 
		*,
		DENSE_RANK() OVER(ORDER BY Salary) AS RNK 
	FROM Employees
) NewTable
GROUP BY RNK
HAVING COUNT(RNK) > 1

-- TASK 3
SELECT *
FROM 
	(SELECT *,
		DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS RNK
	FROM Employees) NewTable
WHERE RNK IN (1,2)
ORDER BY Department, Salary

-- TASK 4
SELECT DISTINCT * 
FROM
	(SELECT *,
		DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary) AS RNK
	FROM Employees) NewTable
WHERE RNK = 1
ORDER BY Department

-- TASK 5
SELECT *,
	SUM(Salary)
	OVER(PARTITION BY Department) AS TotalSalary 
FROM Employees

-- TASK 6
SELECT *,
	SUM(Salary)
	OVER(
		PARTITION BY Department 
		ORDER BY Salary
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS TotalSalary 
FROM Employees

-- TASK 7
SELECT *,
	AVG(Salary)
	OVER(PARTITION BY Department) AS AvarageSalary 
FROM Employees

-- TASK 8
SELECT *,
	ABS(Salary - AVG(Salary)
	OVER(PARTITION BY Department)) AS DiffSalary
FROM Employees

-- TASK 9
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    AVG(Salary) OVER (
        ORDER BY EmployeeID 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees;

-- TASK 10
SELECT *, SUM(Salary) OVER() AS TotalSalary
FROM
(
	SELECT * FROM Employees
	ORDER BY HireDate DESC
	OFFSET 0 ROW FETCH NEXT 3 ROWS ONLY 
) NewTable;

-- TASK 11
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    AVG(Salary) OVER (
        ORDER BY EmployeeID 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningAvgSalary
FROM Employees;

-- TASK 12
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    MAX(Salary) OVER (
        ORDER BY EmployeeID 
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    ) AS MaxSalaryWindow
FROM Employees;

-- TASK 13
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    (Salary * 100.0) / SUM(Salary) OVER (PARTITION BY Department) AS PercentageContribution
FROM Employees;



