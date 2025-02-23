use lesson_3;
go

drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

drop table if exists Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

drop table if exists Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


-- Insert data into tables
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'IT', 60000.00, '2020-05-15'),
(2, 'Jane', 'Smith', 'HR', 55000.00, '2019-08-22'),
(3, 'Alice', 'Johnson', 'Finance', 70000.00, '2021-03-10'),
(4, 'Bob', 'Brown', 'Marketing', 50000.00, '2018-07-01'),
(5, 'Charlie', 'Davis', 'Sales', 48000.00, '2022-09-05'),
(6, 'Emma', 'Wilson', 'IT', 75000.00, '2017-11-30'),
(7, 'David', 'White', 'HR', 52000.00, '2020-02-14'),
(8, 'Olivia', 'Martinez', 'Finance', 68000.00, '2016-06-23'),
(9, 'Liam', 'Taylor', 'Marketing', 62000.00, '2015-12-01'),
(10, 'Sophia', 'Anderson', 'Sales', 49000.00, '2021-07-09'),
(11, 'Mason', 'Thomas', 'IT', 58000.00, '2019-10-15'),
(12, 'Isabella', 'Harris', 'HR', 53000.00, '2018-09-30'),
(13, 'Ethan', 'Clark', 'Finance', 72000.00, '2022-01-20'),
(14, 'Ava', 'Lewis', 'Marketing', 57000.00, '2017-05-10'),
(15, 'James', 'Walker', 'Sales', 51000.00, '2023-03-05'),
(16, 'James', 'Walker', 'Sales', 91000.00, '2023-03-05');

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(101, 'Michael Scott', '2024-01-10', 250.75, 'Shipped'),
(102, 'Pam Beesly', '2024-01-12', 120.50, 'Delivered'),
(103, 'Jim Halpert', '2024-02-01', 500.00, 'Pending'),
(104, 'Dwight Schrute', '2024-02-05', 325.00, 'Cancelled'),
(105, 'Angela Martin', '2024-02-10', 150.25, 'Shipped'),
(106, 'Oscar Martinez', '2024-01-18', 95.80, 'Pending'),
(107, 'Kevin Malone', '2024-02-08', 275.60, 'Shipped'),
(108, 'Stanley Hudson', '2024-02-12', 320.00, 'Delivered'),
(109, 'Toby Flenderson', '2024-02-15', 200.45, 'Cancelled'),
(110, 'Kelly Kapoor', '2024-02-17', 410.30, 'Pending'),
(111, 'Ryan Howard', '2024-02-20', 150.00, 'Shipped'),
(112, 'Meredith Palmer', '2024-02-22', 85.90, 'Delivered'),
(113, 'Phyllis Vance', '2024-02-24', 290.70, 'Shipped'),
(114, 'Creed Bratton', '2024-02-26', 60.25, 'Cancelled'),
(115, 'Darryl Philbin', '2024-02-28', 530.00, 'Pending'),
(116, 'Darryl Philbin', '2023-02-28', 530.00, 'Pending'),
(117, 'Darryl Philbin', '2023-02-28', 530.00, 'Pending'),
(118, 'David Wallace', '2023-03-10', 6200.00, 'Shipped'),
(119, 'Jan Levinson', '2023-04-15', 7500.00, 'Delivered'),
(120, 'Holly Flax', '2023-05-20', 8500.00, 'Cancelled'),
(121, 'Robert California', '2023-06-25', 9100.00, 'Shipped'),
(122, 'Jo Bennett', '2023-07-30', 5000.00, 'Delivered'),
(123, 'Gabe Lewis', '2023-08-10', 10000.00, 'Shipped'),
(124, 'Nellie Bertram', '2023-09-05', 4200.00, 'Delivered'),
(125, 'Clark Green', '2023-10-12', 8700.00, 'Cancelled'),
(126, 'Pete Miller', '2023-11-18', 9300.00, 'Cancelled'),
(127, 'Deangelo Vickers', '2023-12-20', 6000.00, 'Pending');




INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 800.00, 10),
(2, 'Office Chair', 'Furniture', 120.00, 25),
(3, 'Wireless Mouse', 'Accessories', 25.50, 50),
(4, 'Smartphone', 'Electronics', 600.00, 15),
(5, 'Desk Lamp', 'Furniture', 45.00, 30),
(6, 'Keyboard', 'Accessories', 35.75, 40),
(7, 'Monitor', 'Electronics', 250.00, 20),
(8, 'Printer', 'Electronics', 180.00, 12),
(9, 'Standing Desk', 'Furniture', 400.00, 8),
(10, 'Tablet', 'Electronics', 320.00, 14),
(11, 'External Hard Drive', 'Accessories', 100.00, 35),
(12, 'Webcam', 'Accessories', 60.00, 50),
(13, 'Router', 'Electronics', 90.00, 22),
(14, 'Speaker System', 'Electronics', 150.00, 18),
(15, 'Gaming Chair', 'Furniture', 250.00, 10);



-- TASK 1
-- Top 10% highest-paid emplyees
select top 10 percent *
from Employees
order by Salary desc;

-- Groups them by department
select top 10 percent Department, AVG(Salary) as Avg_Department
from Employees
group by Department
order by AVG(Salary) desc;

-- Displays a new column SalaryCategory:
select *, 'High' as SalaryCategory
from Employees
where Salary > 80000

	union all

select *, 'Medium' as SalaryCategory
from Employees
where Salary between 50000 and 80000

	union all

select *, 'Low' as SalaryCategory
from Employees
where Salary < 50000
order by EmployeeID

-- Orders the result by AverageSalary descending
select Department, AVG(Salary) as AverageSalary
from Employees
group by Department
order by AVG(Salary) desc;

-- Skips the first 2 records and fetches the next 5
select *
from Employees
order by EmployeeID
offset 3 row fetch next 5 rows only;


-- TASK 2
select 
	case 
		when Status in ('Shipped', 'Delivered') then 'Completed'
		when Status = 'Pending' then 'Pending'
		when Status = 'Cancelled' then 'Cancelled'
	end as OrderStatus,
	count(OrderID) as TotalOrders,
	sum(TotalAmount) as TotalRevenue
from Orders
where OrderDate between '2023-01-01' and '2023-12-31'
group by 
	case 
        when Status in ('Shipped', 'Delivered') then 'Completed'
        when Status = 'Pending' then 'Pending'
        when Status = 'Cancelled' then 'Cancelled'
    end
having sum(TotalAmount) > 5000
order by TotalRevenue desc;



-- TASK 3
-- Selects distinct product categories.Finds the most expensive product in each category
select 
	Category,
	max(Price) as MaxPrie
from Products
group by Category;

-- Assigns an inventory status 
select 
	Category,
	case 
		when Stock = 0 then 'Out of Stock'
		when Stock between 1 and 10 then 'Low Stock'
		when Stock > 10 then 'In Stock'
	end as StockStatus
from Products

-- Orders the result by Price descending and skips the first 5 rows.
select *
from Products
order by Price desc
offset 5 rows;


