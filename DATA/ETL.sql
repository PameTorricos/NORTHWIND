USE NorthwindDW;
GO

---------------------------------------------------
-- LIMPIAR TABLAS
---------------------------------------------------

TRUNCATE TABLE FactSales;
TRUNCATE TABLE DimCustomer;
TRUNCATE TABLE DimProduct;
TRUNCATE TABLE DimEmployee;
TRUNCATE TABLE DimDate;

GO

---------------------------------------------------
-- CARGAR DIMCUSTOMER
---------------------------------------------------

INSERT INTO DimCustomer (
    CustomerID,
    CompanyName,
    Country,
    City,
    Region
)
SELECT
    CustomerID,
    CompanyName,
    Country,
    City,
    Region
FROM Northwind.dbo.Customers;

GO

---------------------------------------------------
-- CARGAR DIMPRODUCT
---------------------------------------------------

INSERT INTO DimProduct (
    ProductID,
    ProductName,
    CategoryName,
    SupplierName,
    UnitPrice,
    Discontinued
)
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName,
    p.UnitPrice,
    p.Discontinued
FROM Northwind.dbo.Products p
INNER JOIN Northwind.dbo.Categories c
    ON p.CategoryID = c.CategoryID
INNER JOIN Northwind.dbo.Suppliers s
    ON p.SupplierID = s.SupplierID;

GO

---------------------------------------------------
-- CARGAR DIMEMPLOYEE
---------------------------------------------------

INSERT INTO DimEmployee (
    EmployeeID,
    FullName,
    Title,
    Country,
    City
)
SELECT
    EmployeeID,
    FirstName + ' ' + LastName,
    Title,
    Country,
    City
FROM Northwind.dbo.Employees;

GO

---------------------------------------------------
-- CARGAR DIMDATE
---------------------------------------------------

DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2030-12-31';

WHILE @StartDate <= @EndDate
BEGIN

    INSERT INTO DimDate (
        DateKey,
        FullDate,
        Year,
        Quarter,
        Month,
        MonthName,
        Day
    )
    VALUES (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        YEAR(@StartDate),
        DATEPART(QUARTER, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DAY(@StartDate)
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);

END

GO

---------------------------------------------------
-- CARGAR FACTSALES
---------------------------------------------------

INSERT INTO FactSales (
    DateKey,
    CustomerKey,
    ProductKey,
    EmployeeKey,

    Quantity,
    UnitPrice,
    Discount,
    Freight,
    TotalAmount
)

SELECT

    CONVERT(INT, FORMAT(o.OrderDate, 'yyyyMMdd')),

    dc.CustomerKey,

    dp.ProductKey,

    de.EmployeeKey,

    od.Quantity,

    od.UnitPrice,

    od.Discount,

    o.Freight,

    (
        od.Quantity *
        od.UnitPrice *
        (1 - od.Discount)
    ) + o.Freight

FROM Northwind.dbo.Orders o

INNER JOIN Northwind.dbo.OrderDetails od
    ON o.OrderID = od.OrderID

INNER JOIN DimCustomer dc
    ON o.CustomerID = dc.CustomerID

INNER JOIN DimProduct dp
    ON od.ProductID = dp.ProductID

INNER JOIN DimEmployee de
    ON o.EmployeeID = de.EmployeeID;

GO