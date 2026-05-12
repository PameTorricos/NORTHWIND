USE Northwind;
GO


INSERT INTO Region VALUES
(1,'North',DEFAULT),
(2,'South',DEFAULT),
(3,'East',DEFAULT),
(4,'West',DEFAULT);


INSERT INTO Categories(CategoryName, Description)
VALUES
('Beverages','Drinks'),
('Food','Food products'),
('Electronics','Electronic items'),
('Clothing','Clothes'),
('Sports','Sports products');


INSERT INTO Shippers(CompanyName, Phone)
VALUES
('Speedy Express','111111'),
('Quick Delivery','222222'),
('Fast Shipping','333333');


DECLARE @i INT = 1;

WHILE @i <= 20
BEGIN

INSERT INTO Suppliers (
    CompanyName,
    ContactName,
    Country,
    Phone
)
VALUES (
    CONCAT('Supplier ', @i),
    CONCAT('Contact ', @i),
    'USA',
    CONCAT('7000', @i)
);

SET @i = @i + 1;

END



INSERT INTO Customers (
CustomerID,
CompanyName,
ContactName,
Country
)
VALUES
('C001','Alpha Corp','Juan Perez','Bolivia'),
('C002','Beta SRL','Maria Lopez','Peru'),
('C003','Gamma SA','Luis Gomez','Chile'),
('C004','Delta Corp','Ana Ruiz','Argentina'),
('C005','Omega Ltd','Carlos Diaz','Brazil'),
('C006','Nova SRL','Pedro Luna','Bolivia'),
('C007','Star Corp','Lucia Flores','Peru'),
('C008','Vision SA','Mario Castro','Chile'),
('C009','Tech SRL','Sofia Vega','Argentina'),
('C010','Data Corp','Elena Rios','Brazil'),
('C011','Cloud SA','Diego Perez','Bolivia'),
('C012','Future Corp','Laura Diaz','Peru'),
('C013','NextGen','Raul Gomez','Chile'),
('C014','SmartTech','Andres Ruiz','Argentina'),
('C015','Digital SA','Miguel Luna','Brazil'),
('C016','Global SRL','Julia Flores','Bolivia'),
('C017','Prime Corp','Jose Castro','Peru'),
('C018','Blue Ocean','Carla Vega','Chile'),
('C019','Vertex SA','Fernando Rios','Argentina'),
('C020','Matrix Corp','Paola Diaz','Brazil');


SET @i = 1;

WHILE @i <= 20
BEGIN

INSERT INTO Employees (
LastName,
FirstName,
Title,
Country,
City
)
VALUES (
CONCAT('Last', @i),
CONCAT('First', @i),
'Sales Representative',
'USA',
'New York'
);

SET @i = @i + 1;

END

SET @i = 1;

WHILE @i <= 20
BEGIN

INSERT INTO Products (
ProductName,
SupplierID,
CategoryID,
QuantityPerUnit,
UnitPrice,
UnitsInStock,
UnitsOnOrder,
ReorderLevel,
Discontinued
)
VALUES (
CONCAT('Product ', @i),
1 + (@i % 5),
1 + (@i % 5),
'10 boxes',
10 + @i,
100,
10,
5,
0
);

SET @i = @i + 1;

END

SET @i = 1;

WHILE @i <= 20
BEGIN

INSERT INTO Orders (
CustomerID,
EmployeeID,
OrderDate,
RequiredDate,
ShippedDate,
ShipVia,
Freight,
ShipName,
ShipCountry
)
VALUES (
CONCAT('C0', RIGHT('00'+CAST(@i AS VARCHAR),2)),
1 + (@i % 5),
GETDATE(),
DATEADD(DAY,5,GETDATE()),
DATEADD(DAY,2,GETDATE()),
1,
50 + @i,
CONCAT('Shipment ', @i),
'USA'
);

SET @i = @i + 1;

END


SET @i = 1;

WHILE @i <= 20
BEGIN

INSERT INTO OrderDetails (
OrderID,
ProductID,
UnitPrice,
Quantity,
Discount
)
VALUES (
@i,
@i,
20 + @i,
2 + (@i % 5),
0.10
);

SET @i = @i + 1;

END

GO