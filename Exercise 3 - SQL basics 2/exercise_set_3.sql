-- ====== Exercise 3 - SQL Basics 2 ======

-- 1 | Select the average price of products with categoryID 2, 4, 6 and 8. Use column name price_average and present the result with one decimal.
-- --------------------------------------------------
SELECT ROUND(AVG(price), 1) AS price_average FROM products WHERE categoryID IN (2, 4, 6, 8);
-- --------------------------------------------------

-- ##################################################
-- 2 | Count how many products in orders have a quantity of 50 or more (all occurrences should be counted!). Use column name fifty_or_over.
-- --------------------------------------------------
SELECT COUNT(*) AS fifty_or_over FROM ( SELECT ProductID, SUM(Quantity) AS total_quantity FROM orderdetails GROUP BY ProductID HAVING SUM(Quantity) >= 50 ) AS subquery;
-- --------------------------------------------------

-- ##################################################
-- 3 | Count the sum for quantity values of orders in orderID range of 10250-10350? Use column name total_quantity.
-- --------------------------------------------------
SELECT SUM(Quantity) AS total_quantity FROM orderdetails WHERE OrderID BETWEEN 10250 AND 10350;
-- --------------------------------------------------

-- ##################################################
-- 4 | Calculate how many suppliers operate in each country. Show country and count of suppliers in the result set. Use the column name of suppliers_in_country for the count column. Order the result set by count value in descending order.
-- --------------------------------------------------

-- --------------------------------------------------

-- ##################################################
-- 5 | Calculate the average price for the products in each categoryID. Present calculation with two decimals. Include only categories with average price in range 20-30. Use column name price_averages and present also categoryID in the result set. Order results by calculated average price in descending order.
-- --------------------------------------------------

-- --------------------------------------------------

-- ##################################################
-- 6 | Create new usernames for employees using string functions. Username should include first three letters from firstname, first two letters from lastname and year from the birthdate of employee. Present username using lowercase letters. Use column name username.
-- --------------------------------------------------

-- --------------------------------------------------

-- ##################################################
-- 7 | Do the categorisation for products in the following manner:
-- 	- Units as box -> Category_A
-- 	- Units as bottle -> Category_B
-- 	- Units as jar -> Category_C
-- 	- In any other case -> Category_D
-- Use column name unit_categorisation for the categorisation column. In addition to categorisation column, product name and unit should be included in the result set. Order the results by categorisation column in ascending order.
-- --------------------------------------------------

-- --------------------------------------------------

-- ##################################################
-- 8 | Count the length of employees firstname and lastname (both together, for example JanetLeverling -> 14). Use column name name_length. Show only employees with name length over 12 characters. In addition to name_length, show firstname and lastname in the result set.
-- --------------------------------------------------

-- --------------------------------------------------

-- ##################################################
-- 9 | Perform a phone number check for the suppliers. Do the following categorisation using case sentence:
-- 	- If phone number includes brackets () and line -, it is considered to be valid
-- 	- If phone number includes either brackets or line (not both), it is considered to be partly valid
-- 	- If both are missing, phone number is considered to be invalid
-- Use the name phone_number_check for the categorisation column. In addition to phone number categorisation column present supplier name, contact name and phone number in the result set.
-- --------------------------------------------------

-- --------------------------------------------------

-- ##################################################
-- 10 | Perform the following calculations for each orderid:
-- 	- Count the number of products (use column name products_in_order)
-- 	- All quantities in total for each order (use column name total_quantity)
-- Show only orders having at least three different products (three different productid:s required). In addition to the aforementioned columns include orderid in the result set. Order the result set in descending order by total quantity of the order.
-- --------------------------------------------------

-- --------------------------------------------------