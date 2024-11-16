CREATE DATABASE RestaurantManagement
USE RestaurantManagement
CREATE TABLE Meals
(
 Meal_id int primary key identity,
 Meal_name nvarchar(20),
 Meal_price decimal
);
CREATE TABLE [Table]
(
Table_id int primary key identity,
Table_no int
);
CREATE TABLE Orders
(
 Order_id int primary key identity,
 Order_date date,
 Meal_id int,
 FOREIGN KEY(Meal_id) REFERENCES Meals(Meal_id),
 Table_id int,
 FOREIGN KEY(Table_id) REFERENCES [Table](Table_id)
);

ALTER TABLE Orders ALTER COLUMN Order_date datetime;

UPDATE Orders SET Order_date='2024.11.16 21:57:00' WHERE Order_id=1;
UPDATE Orders SET Order_date='2024.11.16 20:52:00' WHERE Order_id=2;
UPDATE Orders SET Order_date='2024.11.16 18:17:00' WHERE Order_id=3;
UPDATE Orders SET Order_date='2024.11.16 00:00:00' WHERE Order_id=4;

SELECT * FROM Orders
SELECT * FROM Meals
SELECT * FROM [Table]

--Query 1

SELECT t.* ,COUNT (o.Table_id) AS 'Count of order' FROM [Table] t
LEFT JOIN Orders o
ON o.Table_id=t.Table_id GROUP BY t.Table_id,t.Table_no

--Query 2
SELECT m.Meal_name,COUNT(o.Meal_id) AS 'Order count' FROM Meals m
LEFT JOIN Orders o
ON m.Meal_id=o.Meal_id GROUP BY m.Meal_name;

--Query 3
SELECT o.Order_id,m.Meal_name,o.Order_Date FROM Orders o
JOIN Meals m 
ON o.Meal_id = m.Meal_id;

--Query 4
SELECT o.Order_id,m.Meal_name,t.Table_no,o.Order_Date FROM Orders o
JOIN Meals m 
ON o.Meal_id = m.Meal_id
JOIN [Table] t
ON o.Table_id=t.Table_id;

--Query 5
SELECT t.*,SUM(m.Meal_price) AS 'Total amount' FROM [Table] t
JOIN Orders o
ON o.Table_id=t.Table_id
JOIN Meals m
ON m.Meal_id=o.Meal_id
GROUP BY t.Table_id,T.Table_no

--Query 6
SELECT DATEDIFF(HOUR,MIN(o.Order_date),MAX(o.Order_date)) AS 'Order time difference' FROM Orders o WHERE o.Table_id=1;
--Minute yazsaq mence daha yaxsi olar

--Query 7
SELECT * FROM Orders o WHERE o.Order_date< DATEADD(MINUTE, -30, GETDATE());

--Query 8
SELECT t.Table_no FROM [Table] t
LEFT JOIN Orders o ON t.Table_id = o.Table_id
WHERE o.Order_id IS NULL;

--Query 9
SELECT t.Table_no FROM [Table] t
LEFT JOIN Orders o ON t.Table_id = o.Table_id AND  o.Order_date>DATEADD(MINUTE, -60, GETDATE())
WHERE o.Order_id IS NULL;	

