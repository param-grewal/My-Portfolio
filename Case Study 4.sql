CREATE TABLE Salesman (
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);
INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);

	select * from Salesman

CREATE TABLE Customer (
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT,
    );

INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);

CREATE TABLE Orders (OrderId int, CustomerId int, SalesmanId int, Orderdate Date, Amount money)

INSERT INTO Orders Values 
(5001,2345,101,'2021-07-01',550),
(5003,1234,105,'2022-02-15',1500)

---1. Insert a new record in your Orders table.

INSERT INTO Orders (OrderId, CustomerId, SalesmanId, Orderdate, Amount)
VALUES (5007,2304,104,'2022-06-24',7400)

select * from Orders
select * from Salesman
select * from Customer

---2. Add Primary key constraint for SalesmanId column in Salesman table. ---Add default constraint for City column in Salesman table. ---Add Foreign key constraint for SalesmanId column in Customer table. ---Add not null constraint in Customer_name column for the Customer table.ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;

ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman PRIMARY KEY (SalesmanId);

-- Add default constraint for City column in Salesman table
ALTER TABLE Salesman
ADD CONSTRAINT DF_City DEFAULT 'Unknown' FOR City;

-- Add Foreign key constraint for SalesmanId column in Customer table
SELECT DISTINCT c.SalesmanId
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 FROM Salesman s WHERE s.SalesmanId = c.SalesmanId
);

UPDATE Customer
SET SalesmanId = (SELECT TOP 1 SalesmanId FROM Salesman)
WHERE SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

ALTER TABLE Customer
ADD CONSTRAINT FK_SalesmanId FOREIGN KEY (SalesmanId) REFERENCES Salesman(SalesmanId);

-- Add not null constraint in Customer_name column for the Customer table
ALTER TABLE Customer
ALTER COLUMN Customername VARCHAR(100) NOT NULL;


---3. Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase amount value greater than 500.
SELECT *
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
WHERE c.Customername LIKE '%W' AND o.Amount > 500;
/*
4. Using SET operators, retrieve the first result with unique SalesmanId values from two tables, and the other result containing SalesmanId with duplicates from two tables.*/SELECT SalesmanId FROM Salesman
UNION
SELECT SalesmanId FROM Customer;

SELECT SalesmanId FROM Salesman
UNION ALL
SELECT SalesmanId FROM Customer;

/*
5. Display the below columns which has the matching data.
Orderdate, Salesman Name, Customer Name, Commission, and City which has the
range of Purchase Amount between 500 to 1500.
*/

SELECT o.OrderDate, s.Name, c.Customername, s.Commission, s.City
FROM Orders o
JOIN Customer c ON o.CustomerID = c.CustomerID
JOIN Salesman s ON o.SalesmanID = s.SalesmanId
WHERE o.Amount BETWEEN 500 AND 1500;

/*
6. Using right join fetch all the results from Salesman and Orders table.
*/
SELECT *
FROM Salesman s
RIGHT JOIN Orders o ON s.SalesmanId = o.SalesmanID;