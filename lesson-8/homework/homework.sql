create database lesson_8;
go

use lesson_8;

-- Create the table
DROP TABLE IF EXISTS Grouping;
CREATE TABLE Grouping (
    StepNumber INT,
    Status VARCHAR(10)
);
go
-- Insert data into the table
INSERT INTO Grouping (StepNumber, Status) VALUES (1, 'Passed');
INSERT INTO Grouping (StepNumber, Status) VALUES (2, 'Passed');
INSERT INTO Grouping (StepNumber, Status) VALUES (3, 'Passed');
INSERT INTO Grouping (StepNumber, Status) VALUES (4, 'Passed');
INSERT INTO Grouping (StepNumber, Status) VALUES (5, 'Failed');
INSERT INTO Grouping (StepNumber, Status) VALUES (6, 'Failed');
INSERT INTO Grouping (StepNumber, Status) VALUES (7, 'Failed');
INSERT INTO Grouping (StepNumber, Status) VALUES (8, 'Failed');
INSERT INTO Grouping (StepNumber, Status) VALUES (9, 'Failed');
INSERT INTO Grouping (StepNumber, Status) VALUES (10, 'Passed');
INSERT INTO Grouping (StepNumber, Status) VALUES (11, 'Passed');
INSERT INTO Grouping (StepNumber, Status) VALUES (12, 'Passed');


-- Create Table
DROP TABLE IF EXISTS EMPLOYEES_N
CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);
GO
-- Insert Sample Data
INSERT INTO [dbo].[EMPLOYEES_N] ([EMPLOYEE_ID], [FIRST_NAME], [HIRE_DATE]) 
VALUES 
(1, 'John', '1976-03-15'),
(2, 'Jane', '1977-07-21'),
(3, 'Alice', '1979-05-01'),
(4, 'Bob', '1980-09-17'),
(5, 'Charlie', '1982-02-03'),
(6, 'Dave', '1983-11-11'),
(7, 'Eva', '1984-06-23'),
(8, 'Frank', '1985-08-14'),
(9, 'Grace', '1990-04-10'),
(10, 'Hank', '1997-12-19'),
(11, 'Ivy', '2000-05-04'),
(12, 'Jack', '2005-01-01'),
(13, 'Karen', '2010-10-10'),
(14, 'Leo', '2015-03-03'),
(15, 'Mia', '2020-08-08');



-- TASK 1
select 
	min(gr1.StepNumber) as MinStepNumber,
	max(gr1.StepNumber) as MaxStepNumber,
	gr1.Status,
	Count(gr1.Status) as ConsecutiveCount
from (
	select
		StepNumber,
		Status,
		StepNumber - row_number() over(partition by Status order by StepNumber) as groupID
	from Grouping)  as gr1
group by gr1.Status, gr1.groupID
order by MinStepNumber

-- TASK 2
select
	concat(max(year(hire_date)) + 1,'-',lead(min(year(hire_date)) - 1, 1) over(order by groupID) ) as Years
from (
	select 
		employee_id,
		first_name,
		hire_date,
		year(hire_date) - row_number() over(order by year(hire_date)) as groupID
	from employees_n) as gr3
group by groupID
order by groupID
--offset 0 row fetch next (select count(*) - 1 from gr3) rows only;

