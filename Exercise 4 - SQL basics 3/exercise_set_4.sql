-- ====== Exercise 4 - SQL Basics 3 ======

-- 1 | Select all products with product categories and include also products without the category. Product name and its category name should be presented in the result set.
-- --------------------------------------------------
SELECT p.ProductName, c.CategoryName FROM products p LEFT JOIN categories c ON p.CategoryID = c.CategoryID;

-- --------------------------------------------------

-- ##################################################
-- 2 | Select products that have never been ordered. Include product name in the result set.
-- --------------------------------------------------
SELECT p.ProductName FROM products p LEFT JOIN orderdetails od ON p.ProductID = od.ProductID WHERE od.ProductID IS NULL;

-- --------------------------------------------------

-- ##################################################
-- 3 | Count how many orders each shipper has delivered. Show shipper name and count in the result set. Use column name shipped_orders for the calculated column.
-- --------------------------------------------------
SELECT s.ShipperName, COUNT(o.OrderID) AS shipped_orders FROM orders o JOIN shippers s ON o.ShipperID = s.ShipperID GROUP BY s.ShipperName;
-- --------------------------------------------------

-- ##################################################
-- 4 | List categories with 10 or more products. Show category name and product count in the result set. Order the result set by product count in descending order.
-- --------------------------------------------------
SELECT c.CategoryName, COUNT(p.ProductID) AS product_count FROM products p JOIN categories c ON p.CategoryID = c.CategoryID GROUP BY c.CategoryName HAVING COUNT(p.ProductID) >= 10 ORDER BY product_count DESC;
-- --------------------------------------------------

-- ##################################################
-- 5 | Calculate how many products each customer have ordered (sum quantities). Use column name total_bought for the calculated column. In addition to this column show customers name in the result set.
-- --------------------------------------------------
SELECT c.CustomerName, SUM(od.Quantity) AS total_bought FROM customers c JOIN orders o ON c.CustomerID = o.CustomerID JOIN orderdetails od ON o.OrderID = od.OrderID GROUP BY c.CustomerName;
-- --------------------------------------------------

-- ##################################################
-- 6 | List products with price greater or equal than all products with product name starting with letter Q. Include productID, product name and price in the result set. Order the result set by price in descending order.
-- --------------------------------------------------
SELECT p.ProductID, p.ProductName, p.Price FROM products p WHERE p.Price >= ALL(SELECT p2.Price FROM products p2 WHERE p2.ProductName LIKE 'Q%') ORDER BY p.Price DESC;
-- --------------------------------------------------

-- ##################################################
-- 7 | Use UNION to gather the following customers:
-- 	- Customers coming from Argentina or Brazil
-- 	- Customers who have made at least one order in 17th of August 2023
-- Show customer name in the result set and order the result set by customer name in ascending order.

-- --------------------------------------------------
SELECT CustomerName FROM customers WHERE Country IN ('Argentina', 'Brazil') UNION SELECT c.CustomerName FROM customers c JOIN orders o ON c.CustomerID = o.CustomerID WHERE DATE(o.OrderDate) = '2023-08-17' ORDER BY CustomerName ASC;
-- --------------------------------------------------

-- ##################################################
-- 8 | Calculate the total price (quantity*price) for products in the following orderIDs: 10250, 10260, 10270 and 10280. Use column name total_price for the calculated column. In addition to this column, show product name in the result set.
-- --------------------------------------------------
SELECT p.ProductName, od.Quantity * p.Price AS total_price FROM products p JOIN orderdetails od ON p.ProductID = od.ProductID WHERE od.OrderID IN (10250, 10260, 10270, 10280);
-- --------------------------------------------------

-- ##################################################
-- 9 | Use UNION to gather the following suppliers:
-- 	- Suppliers having five or more products
-- 	- Suppliers with postal code length five or less and country is Japan
-- 	- Suppliers offering products in seafood and dairy products categories
-- Show supplier name, contact name and phone number in the result set. Order the result set by supplier name in ascending order.
-- --------------------------------------------------
-- Query to get suppliers having five or more products
SELECT s.SupplierName, s.ContactName, s.Phone
FROM suppliers s JOIN products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID HAVING COUNT(p.ProductID) >= 5
UNION SELECT SupplierName, ContactName, Phone FROM suppliers WHERE LENGTH(PostalCode) <= 5
AND Country = 'Japan' UNION SELECT s.SupplierName, s.ContactName, s.Phone FROM suppliers s
JOIN products p ON s.SupplierID = p.SupplierID JOIN categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Seafood', 'Dairy Products') GROUP BY s.SupplierID ORDER BY SupplierName ASC;

-- --------------------------------------------------

-- ##################################################
-- 10 | List customers who have bought the most popular product (most sold). Include customer name and quantity in the result set and order the result set by quantity in descending order.
-- --------------------------------------------------
SELECT c.CustomerName, SUM(od.Quantity) AS quantity
FROM customers c JOIN orders o ON c.CustomerID = o.CustomerID
JOIN orderdetails od ON o.OrderID = od.OrderID
WHERE od.ProductID = (SELECT ProductID FROM orderdetails GROUP BY ProductID ORDER BY SUM(Quantity) DESC LIMIT 1) GROUP BY c.CustomerName ORDER BY quantity DESC;
-- --------------------------------------------------