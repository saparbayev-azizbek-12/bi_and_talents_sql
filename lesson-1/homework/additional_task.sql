use MyDB
go

/* Shippers Table */
drop table if exists Shippers;
create table Shippers
(
	ShipperID int primary key,
	ShipperName varchar(255),
	Phone varchar(255)
);

insert into Shippers
values
	(1, 'Adam', '+998123456'),
	(2, 'Smith', '+998123456'),
	(3, 'Gorge', '+998123456'),
	(4, 'John', '+998123456'),
	(5, 'Anna', '+998123456');

select * from Shippers


/* Customers Table */
drop table if exists Customers;
create table Customers
(
	CustomerID int primary key,
	CustomerName varchar(255),
	ContactName varchar(255),
	Address varchar(255),
	City varchar(255),
	PostalCode varchar(255),
	Country varchar(255),
);

insert into Customers
values
	(1, 'Sanjar', 'Sanjar', 'Turtkul', 'Turtkul', '2002100', 'Uzbekistan'),
	(2, 'Ahmad', 'Ahmad', 'Ellikqala', 'Ellikqala', '2002100', 'Uzbekistan'),
	(3, 'Jasur', 'Jasur', 'Beruniy', 'Beruniy', '2002100', 'Uzbekistan'),
	(4, 'Jahongir', 'Jahongir', 'Yangiariq', 'Yangiariq', '2002100', 'Uzbekistan'),
	(5, 'Abbos', 'Abbos', 'Urganch', 'Urganch', '2002100', 'Uzbekistan');

select * from Customers


/* Employees Table */
drop table if exists Employees;
create table Employees
(
	EmployeeID int primary key,
	LastName varchar(255),
	FirstName varchar(255),
	BirthDate date,
	Photo varchar(255),
	Notes text
);

insert into Employees
select 1, 'Adam', 'Smith', '1990-01-01', 'images/ada.jpg', 'no commnet';

insert into Employees
values
	(2, 'George', 'Washington', '1776-07-04', 'images/george.png', 'no comment'),
	(3, 'Steave', 'Jobs', '1956-07-04', 'images/steave.png', 'no comment'),
	(4, 'Bill', 'Gates', '1856-07-04', 'images/bill.png', 'no comment'),
	(5, 'Benjamin', 'Farnklin', '1776-07-04', 'images/franklin.png', 'no comment');



select * from Employees


/* Categories Table */
drop table if exists Categories
create table Categories
(
	CategoryID int primary key,
	CategoryName varchar(255),
	Description varchar(255)
);

insert into Categories
values 
	(1, 'Fruit', 'This category includes only fruits'),
	(2, 'Gadjets', 'This category includes only gadjects');

/* Suppliers Table */
drop table if exists Suppliers
create table Suppliers
(
	SupplierID int primary key,
	SupplierName varchar(255),
	ContactName varchar(255),
	Address varchar(255),
	City varchar(255),
	PostalCode varchar(255),
	Country varchar(255),
	Phone varchar(255)
);

insert into Suppliers
values
	(1, 'Sanjar', 'Sanjar', 'Turtkul', 'Turtkul', '2002100', 'Uzbekistan', '+9898877'),
	(2, 'Ahmad', 'Ahmad', 'Ellikqala', 'Ellikqala', '2002100', 'Uzbekistan', '+9898877'),
	(3, 'Jasur', 'Jasur', 'Beruniy', 'Beruniy', '2002100', 'Uzbekistan', '+9898877'),
	(4, 'Jahongir', 'Jahongir', 'Yangiariq', 'Yangiariq', '2002100', 'Uzbekistan', '+9898877'),
	(5, 'Abbos', 'Abbos', 'Urganch', 'Urganch', '2002100', 'Uzbekistan', '+9898877');


/* Products Table */
drop table if exists Products
create table Products
(
	ProductID int primary key,
	ProductName varchar(255),
	SupplerID int foreign key references Suppliers(SupplierID),
	CategoryID int foreign key references Categories(CategoryID),
	Unit varchar(255),
	Price float
);

insert into Products
values
	(1, 'Apple', 3, 2, 'kg', 12.59),
	(2, 'Pineapple', 3, 2, 'kg', 12.59),
	(3, 'Cherry', 3, 2, 'kg', 12.59),
	(4, 'Phone', 3, 1, 'unit', 1299.59),
	(5, 'Laptop', 3, 1, 'unit', 1599.59);



/* Order_details Table */
drop table if exists Order_details
create table Order_details
(
	OrderDetailID int primary key,
	OrderID int foreign key references Orders(OrderID),
	ProductID int foreign key references Products(ProductID),
	Quantity int,
);

insert into Order_details
values
	(1, 2, 2, 30),
	(2, 1, 2, 25),
	(3, 4, 2, 80),
	(4, 5, 2, 45),
	(5, 3, 2, 50);

select * from Order_details


/* Orders Table */
drop table if exists Orders
create table Orders
(
	OrderID int primary key,
	CustomerID int foreign key references Customers(CustomerID),
	EmployeeID int foreign key references Employees(EmployeeID),
	OrderDate date,
	ShipperID int foreign key references Shippers(ShipperID)
);

insert into Orders
values 
	(1, 1, 1, '2025-02-15', 2),
	(2, 5, 2, '2025-02-15', 2),
	(3, 4, 2, '2025-02-15', 1),
	(4, 2, 4, '2025-02-15', 3),
	(5, 3, 3, '2025-02-15', 4);



select * from Orders;
select * from Shippers;
select * from Customers;
select * from Employees;
select * from Order_details;
select * from Products;
select * from Suppliers;
select * from Categories;



