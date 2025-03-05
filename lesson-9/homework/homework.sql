create database lesson_9;
go

use lesson_9;

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


-- TASK 1
with cte as 
(
	select EmployeeID, ManagerID, JobTitle, 0 as Depth from Employees
	where ManagerID is null
		union all
	select e.EmployeeID, e.ManagerID, e.JobTitle, Depth + 1 from Employees e
	join cte c
		on e.ManagerID = c.EmployeeID
)
select * from cte;


-- TASK 2
with cte as 
(
	select 1 as num, 1 as mult
		union all
	select num + 1, mult * (num + 1) from cte where num < 10
)
select * from cte;


-- TASK 3
with cte as 
(
	select 1 as n, 1 as num1, 1 as num2
		union all
	select n + 1, num2, num1 + num2 from cte where n < 10
)
select n, num1 as Fibonacci_Number from cte;