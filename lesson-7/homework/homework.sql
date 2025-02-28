create database lesson_7;
go

use lesson_7;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

DROP TABLE IF EXISTS OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);



-- Insert into Customers
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Carol Williams'),
(4, 'David Brown'),
(5, 'Emily Davis'),
(6, 'Frank Miller'),
(7, 'Grace Wilson'),
(8, 'Hannah Moore'),
(9, 'Ian Clark'),
(10, 'Jane Adams'),
(11, 'Bob Brown');

-- Insert into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-02-01'),
(2, 2, '2025-02-02'),
(3, 3, '2025-02-03'),
(4, 4, '2025-02-04'),
(5, 5, '2025-02-05'),
(6, 6, '2025-02-06'),
(7, 7, '2025-02-07'),
(8, 8, '2025-02-08'),
(9, 9, '2025-02-09'),
(10, 10, '2025-02-10'),
(11, 1, '2025-02-03'),
(12, 2, '2025-02-09');

-- Insert into Products
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Desk Chair', 'Furniture'),
(4, 'Headphones', 'Electronics'),
(5, 'Notebook', 'Stationery'),
(6, 'Pen Set', 'Stationery'),
(7, 'Water Bottle', 'Accessories'),
(8, 'Backpack', 'Accessories'),
(9, 'Smartphone', 'Electronics'),
(10, 'Desk Lamp', 'Furniture');

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 1000.00),
(2, 1, 2, 2, 500.00),
(3, 2, 3, 1, 150.00),
(4, 3, 4, 1, 200.00),
(5, 4, 5, 3, 15.00),
(6, 5, 6, 2, 10.00),
(7, 6, 7, 1, 25.00),
(8, 7, 8, 1, 60.00),
(9, 8, 9, 1, 800.00),
(10, 9, 10, 1, 75.00),
(11, 1, 1, 1, 1300.00),
(12, 1, 2, 2, 1500.00);


-- TASK 1
SELECT C.CustomerID, C.CustomerName, O.OrderID, O.OrderDate
FROM Orders O
RIGHT JOIN Customers C
ON O.CustomerID = C.CustomerID

-- TASK 2
SELECT C.CustomerID, C.CustomerName, O.OrderID, O.OrderDate
FROM Orders O
RIGHT JOIN Customers C
ON O.CustomerID = C.CustomerID
WHERE O.OrderID IS NULL

-- TASK 3
SELECT O.OrderDetailID, P.ProductName, O.Quantity, O.Price
FROM OrderDetails O
JOIN Products P
ON O.ProductID = P.ProductID

-- TASK 4
SELECT 
	C.CustomerID,
	C.CustomerName
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CustomerName
HAVING COUNT(O.CustomerID) > 1

-- TASK 5
SELECT O.OrderID, MAX(O.Price) AS MaxPrice
FROM OrderDetails AS O
JOIN Products AS P
ON O.ProductID = P.ProductID
GROUP BY O.OrderID

-- TASK 6
SELECT O.CustomerID, C.CustomerName, MAX(O.OrderDate)
FROM Customers AS C
JOIN Orders AS O
ON O.CustomerID = C.CustomerID
GROUP BY O.CustomerID, C.CustomerName

-- TASK 7
SELECT C.CustomerName
FROM Customers C
JOIN Orders O
	ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
	ON OD.OrderID = O.OrderID
JOIN Products P
	ON P.ProductID = OD.ProductID
WHERE P.Category NOT IN ('Stationery', 'Furniture', 'Accessories')

-- TASK 8
SELECT DISTINCT C.CustomerName
FROM Customers C
JOIN Orders O
	ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
	ON OD.OrderID = O.OrderID
JOIN Products P
	ON P.ProductID = OD.ProductID
WHERE P.Category = 'Stationery'

-- TASK 9
SELECT C.CustomerName,
	SUM(OD.Price) AS TotalSpent
FROM Customers C
JOIN Orders O
	ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD
	ON OD.OrderID = O.OrderID
JOIN Products P
	ON P.ProductID = OD.ProductID
GROUP BY O.CustomerID, C.CustomerName