-- ====== Exercise 6 - SQL Basics 5 ======

-- 1 | Create the following offices:
-- 	- Saint Louis office (address: Palm st 16, postalcode: 63107, city: Saint Louis, manager: Robert King)
-- 	- Springfield office (address: Ohio Ave 3, postalcode: 62702, city: Springfield, manager: Nancy Davolio)
-- 	- Kansas City office (address: Beverly st 80, postalcode: 66204, city: Kansas City, manager: Adam West)
-- --------------------------------------------------
INSERT INTO offices (OfficeName, Address, PostalCode, City, Manager)
VALUES 
    ('Saint Louis office', 'Palm st 16', '63107', 'Saint Louis', 
        (SELECT EmployeeID FROM employees WHERE FirstName = 'Robert' AND LastName = 'King')),
    ('Springfield office', 'Ohio Ave 3', '62702', 'Springfield', 
        (SELECT EmployeeID FROM employees WHERE FirstName = 'Nancy' AND LastName = 'Davolio')),
    ('Kansas City office', 'Beverly st 80', '66204', 'Kansas City', 
        (SELECT EmployeeID FROM employees WHERE FirstName = 'Adam' AND LastName = 'West'));
-- --------------------------------------------------

-- ##################################################
-- 2 | Create the following warehouses:
-- 	- Liberty warehouse (address: Grant Ave 400, postalcode: 64068, city: Liberty, surfacearea: 200m2, supplier: New Orleans Cajun Delights)
-- 	- Blue Springs warehouse (address: 1030 SE Forest Ridge Ct, postalcode: 64014, city: Blue Springs, surfacearea: 350m2, supplier: Tasty Roots)
-- 	- Eldon warehouse (address: 800 W Champain St, postalcode: 65026, city: Eldon, surfacearea: 400m2, supplier: New Orleans Cajun Delights)
-- 	- Quincy warehouse (address: 3100 Payson Rd, postalcode: 62305, city: Quincy, surfacearea: 280m2, supplier: Tropical Fruits)
-- 	- Cameron warehouse (address: 650 E Grand Ave, postalcode: 64429, city: Cameron, surfacearea: 310m2, supplier: Bigfoot Breweries)
-- --------------------------------------------------
ALTER TABLE suppliers
ADD COLUMN WarehouseID INT;
INSERT INTO warehouses (Address, PostalCode, City, SurfaceArea)
VALUES 
    ('Grant Ave 400', '64068', 'Liberty', 200),
    ('1030 SE Forest Ridge Ct', '64014', 'Blue Springs', 350),
    ('800 W Champain St', '65026', 'Eldon', 400),
    ('3100 Payson Rd', '62305', 'Quincy', 280),
    ('650 E Grand Ave', '64429', 'Cameron', 310);
UPDATE suppliers s
JOIN warehouses w ON 
    (w.Address = 'Grant Ave 400' AND s.SupplierName = 'New Orleans Cajun Delights') OR
    (w.Address = '1030 SE Forest Ridge Ct' AND s.SupplierName = 'Tasty Roots') OR
    (w.Address = '800 W Champain St' AND s.SupplierName = 'New Orleans Cajun Delights') OR
    (w.Address = '3100 Payson Rd' AND s.SupplierName = 'Tropical Fruits') OR
    (w.Address = '650 E Grand Ave' AND s.SupplierName = 'Bigfoot Breweries')
SET s.WarehouseID = w.WarehouseID;
-- --------------------------------------------------

-- ##################################################
-- 3 | Let's add couple of products into some of previously created warehouses (more specifically into storage shelves inside warehouses). Add the following products:
-- 	- Products in Liberty Warehouse (Grant Ave 400):
-- 		* product: Chang, quantity: 16000, shelf: A7
-- 		* product: Tofu, quantity: 12000, shelf: T8
-- 	- Products in Blue Springs Warehouse (1030 SE Forest Ridge Ct):
-- 		* product: Maxilaku, quantity: 50000, shelf: B5
-- 		* product: Ipoh Coffee, quantity: 35000, shelf: C9
-- 	- Products in Eldon Warehouse (800 W Champain St):
-- 		* product: Sun-Dried Tomatoes, quantity: 95000, shelf: A1
-- 		* product: Almond Milk, quantity: 15000, shelf: Q7
-- --------------------------------------------------
-- Liberty Warehouse (Grant Ave 400)
INSERT INTO storages (ProductID, WarehouseID, Quantity, Shelf)
VALUES 
    ((SELECT ProductID FROM products WHERE ProductName = 'Chang'), 
        (SELECT WarehouseID FROM warehouses WHERE Address = 'Grant Ave 400'), 16000, 'A7'),
    ((SELECT ProductID FROM products WHERE ProductName = 'Tofu'), 
        (SELECT WarehouseID FROM warehouses WHERE Address = 'Grant Ave 400'), 12000, 'T8'),
    ((SELECT ProductID FROM products WHERE ProductName = 'Maxilaku'), 
        (SELECT WarehouseID FROM warehouses WHERE Address = '1030 SE Forest Ridge Ct'), 50000, 'B5'),
    ((SELECT ProductID FROM products WHERE ProductName = 'Ipoh Coffee'), 
        (SELECT WarehouseID FROM warehouses WHERE Address = '1030 SE Forest Ridge Ct'), 35000, 'C9'),
    ((SELECT ProductID FROM products WHERE ProductName = 'Sun-Dried Tomatoes'), 
        (SELECT WarehouseID FROM warehouses WHERE Address = '800 W Champain St'), 95000, 'A1'),
    ((SELECT ProductID FROM products WHERE ProductName = 'Almond Milk'), 
        (SELECT WarehouseID FROM warehouses WHERE Address = '800 W Champain St'), 15000, 'Q7');
-- --------------------------------------------------

-- ##################################################
-- 4 | Springfield office moves to a new address in Springfield. Do the following changes:
-- 	- address: 1500 Knotts St
-- 	- postalcode: 62703
-- --------------------------------------------------
UPDATE offices SET Address = '1500 Knotts St', PostalCode = 62703 WHERE OfficeName LIKE 'Springfield%';
-- --------------------------------------------------

-- ##################################################
-- 5 | Manager of Kansas City office has left the company and Laura Callahan will be the new manager. Do the update using subquery (tip: get the employeeid for manager column using subquery)!
-- --------------------------------------------------
UPDATE offices SET manager = (SELECT EmployeeID FROM employees WHERE LastName LIKE 'Callahan%' AND FirstName LIKE 'Laura%') WHERE OfficeName LIKE 'Kansas City%';
-- --------------------------------------------------

-- ##################################################
-- 6 | Double the quantity of Tofu and move the product to W8 shelf which has more space for the greater quantity in Liberty Warehouse.
-- --------------------------------------------------
UPDATE storages
SET Quantity = Quantity * 2, Shelf = 'W8'
WHERE ProductID = (SELECT ProductID FROM products WHERE ProductName = 'Tofu') AND
    WarehouseID = (SELECT WarehouseID FROM warehouses WHERE Address = 'Grant Ave 400');
-- --------------------------------------------------

-- ##################################################
-- 7 | Create a copy of the storages table. New table should be called storages_backup.
-- --------------------------------------------------
CREATE TABLE storages_backup LIKE storages;
-- --------------------------------------------------

-- ##################################################
-- 8 | Copy the data from storages table into storages_backup table.
-- --------------------------------------------------
INSERT INTO storages_backup SELECT * FROM storages;
-- --------------------------------------------------

-- ##################################################
-- 9 | The lease for the warehouse in Liberty is coming to an end and the supplier plans to move the products to a larger warehouse in Eldon (Do this same update into the storages_backup table too!).
-- Transfer the Liberty warehouse products to Eldon and remove the Liberty warehouse from the warehouses table.
-- --------------------------------------------------
UPDATE storages SET WarehouseID = (SELECT WarehouseID FROM warehouses WHERE City LIKE 'Eldon%')
WHERE WarehouseID = (SELECT WarehouseID FROM warehouses WHERE City LIKE 'Liberty%');

UPDATE storages_backup SET WarehouseID = (SELECT WarehouseID FROM warehouses WHERE City LIKE 'Eldon%')
WHERE WarehouseID = (SELECT WarehouseID FROM warehouses WHERE City LIKE 'Liberty%');

DELETE FROM warehouses WHERE City LIKE 'Liberty%';
-- --------------------------------------------------

-- ##################################################
-- 10 | Remove all products from storages table with 0 as a quantity value.
-- --------------------------------------------------
DELETE FROM storages WHERE quantity = 0;
-- --------------------------------------------------