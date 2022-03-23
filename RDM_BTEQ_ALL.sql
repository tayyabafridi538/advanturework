.LOGON 192.168.119.128/dbc,dbc
DATABASE DP_RDM;

--PERSON MODULE
CREATE MULTISET TABLE DP_RDM.Address AS DP_STG2.Address
WITH DATA;

CREATE MULTISET TABLE DP_RDM.AddressType AS DP_STG2.AddressType
WITH DATA;

CREATE MULTISET TABLE DP_RDM.BusinessEntityAddress AS DP_STG2.BusinessEntityAddress
WITH DATA;

CREATE MULTISET TABLE DP_RDM.Passwords AS DP_STG2.Passwords
WITH DATA;

CREATE MULTISET TABLE DP_RDM.BusinessEntity AS DP_STG2.BusinessEntity
WITH DATA;

CREATE MULTISET TABLE DP_RDM.CountryRegion AS DP_STG2.CountryRegion
WITH DATA;

CREATE MULTISET TABLE DP_RDM.StateProvince AS DP_STG2.StateProvince
WITH DATA;

CREATE MULTISET TABLE DP_RDM.EmailAddress AS DP_STG2.EmailAddress
WITH DATA;

CREATE MULTISET TABLE DP_RDM.Person AS DP_STG2.Person
WITH DATA;

CREATE MULTISET TABLE DP_RDM.PersonPhone AS DP_STG2.PersonPhone
WITH DATA;

CREATE MULTISET TABLE DP_RDM.PurchaseOrderHeader AS DP_STG2.PurchaseOrderHeader
WITH DATA;

CREATE MULTISET TABLE DP_RDM.PurchaseOrderDetail AS DP_STG2.PurchaseOrderDetail
WITH DATA;

CREATE MULTISET TABLE DP_RDM.Vendor AS DP_STG2.Vendor
WITH DATA;

CREATE MULTISET TABLE DP_RDM.ShipMethod AS DP_STG2.ShipMethod
WITH DATA;

CREATE MULTISET TABLE DP_RDM.PhoneNumberType (
PhoneNumberType INTEGER,
Name1 VARCHAR(8)
)
UNIQUE PRIMARY INDEX (PhoneNumberType);
INSERT INTO DP_RDM.PhoneNumberType
SELECT *
FROM DP_STG2.PhoneNumberType;

--HR MODULE
CREATE MULTISET TABLE DP_RDM.Employee AS DP_STG2.Employee WITH DATA;

CREATE MULTISET TABLE Dp_RDM.Department
(
            DepartmentID INTEGER ,
			DepartmentName VARCHAR(32),
			GroupName VARCHAR(32)
)

UNIQUE PRIMARY INDEX (DepartmentID);
INSERT INTO DP_RDM.Department
Select *
From DP_STG2.Department;

CREATE MULTISET TABLE DP_RDM.EmployeeDepartmentHistory AS DP_STG2.EmployeeDepartmentHistory WITH DATA;

CREATE MULTISET TABLE DP_RDM.Shift 
     (
      ShiftID INTEGER ,
      Name1 CHAR(8) CHARACTER SET LATIN NOT CASESPECIFIC,
      StartTime TIME(6),
      EndTime TIME(6))
UNIQUE PRIMARY INDEX ( ShiftID );

INSERT INTO DP_RDM.Shift
Select *
FROM DP_STG2.Shift;

--Product Module

CREATE MULTISET TABLE dp_rdm.TransactionHistory( 
TransactionID INTEGER,
ProductID INTEGER,
ReferenceOrderID INTEGER,
ReferenceOrderLineID SMALLINT,
TransactionDate DATE FORMAT 'MM/DD/YYYY',
TransactionType VARCHAR(8),
Quantity SMALLINT,
ActualCost DECIMAL(10,2)
)
PRIMARY INDEX ( TransactionID )
PARTITION BY RANGE_N(TransactionDate  BETWEEN DATE '2007-08-01' AND '2020-07-31' EACH INTERVAL '1' DAY );

INSERT INTO dp_rdm.TransactionHistory
SELECT * FROM  dp_stg2.TransactionHistory;


CREATE MULTISET TABLE DP_RDM.Culture 
AS dp_stg2.Culture
WITH DATA;


CREATE MULTISET TABLE DP_RDM.Location 
AS dp_stg2.Location
WITH DATA;


CREATE MULTISET TABLE DP_RDM.Product 
AS dp_stg2.Product
WITH DATA;

CREATE MULTISET TABLE DP_RDM.ProductCostHistory 
AS dp_stg2.ProductCostHistory
WITH DATA;


CREATE MULTISET TABLE DP_RDM.ProductDescription 
AS dp_stg2.ProductDescription
WITH DATA;


CREATE MULTISET TABLE DP_RDM.ProductInventory 
AS dp_stg2.ProductInventory
WITH DATA;


CREATE MULTISET TABLE DP_RDM.ProductListPriceHistory 
AS dp_stg2.ProductListPriceHistory
WITH DATA;


CREATE MULTISET TABLE DP_RDM.ProductModel 
AS dp_stg2.ProductModel
WITH DATA;


CREATE MULTISET TABLE DP_RDM.ProductModelProductDesctriptionCulture 
AS dp_stg2.ProductModelProductDesctriptionCulture
WITH DATA;


CREATE MULTISET TABLE DP_RDM.WorkOrder
AS dp_stg2.WorkOrder
WITH DATA;

CREATE MULTISET TABLE DP_RDM.WorkOrderRouting
AS dp_stg2.WorkOrderRouting
WITH DATA;

CREATE MULTISET TABLE DP_RDM.UnitMeasure
AS dp_stg2.UnitMeasure
WITH DATA;

CREATE MULTISET TABLE DP_RDM.ProductCategory 
AS dp_stg2.ProductCategory
WITH DATA;

CREATE MULTISET TABLE DP_RDM.ProductSubcategory 
AS dp_stg2.ProductSubcategory
WITH DATA;

CREATE MULTISET TABLE DP_RDM.ScrapReason
AS dp_stg2.ScrapReason
WITH DATA;

CREATE MULTISET TABLE DP_RDM.BillofMaterials
AS dp_stg2.BillofMaterials
WITH DATA;


--Sales Module

CREATE MULTISET TABLE DP_RDM.ShoppingCartItem AS DP_STG2.ShoppingCartItem
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SpecialOffer AS DP_STG2.SpecialOffer
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SpecialOfferProduct AS DP_STG2.SpecialOfferProduct
WITH DATA;

CREATE MULTISET TABLE DP_RDM.Store AS DP_STG2.Store
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SalesOrderHeaderSalesReason AS DP_STG2.SalesOrderHeaderSalesReason
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SalesPerson AS DP_STG2.SalesPerson
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SalesPersonQuotaHistory AS DP_STG2.SalesPersonQuotaHistory
WITH DATA;


CREATE MULTISET TABLE DP_RDM.SalesReason AS DP_STG2.SalesReason
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SalesTaxRate AS DP_STG2.SalesTaxRate
WITH DATA;


CREATE MULTISET TABLE DP_RDM.SalesTerritory AS DP_STG2.SalesTerritory
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SalesTerritoryHistory AS DP_STG2.SalesTerritoryHistory
WITH DATA;

CREATE MULTISET TABLE DP_RDM.Currency AS DP_STG2.Currency
WITH DATA;

CREATE MULTISET TABLE DP_RDM.CurrencyRate AS DP_STG2.CurrencyRate
WITH DATA;

CREATE MULTISET TABLE DP_RDM.Customer AS DP_STG2.Customer
WITH DATA;

CREATE MULTISET TABLE DP_RDM.CreditCard AS DP_STG2.CreditCard
WITH DATA;

CREATE MULTISET TABLE DP_RDM.PersonCreditCard AS DP_STG2.PersonCreditCard
WITH DATA;

CREATE MULTISET TABLE DP_RDM.SalesOrderHeader AS DP_STG2.SalesOrderHeader
WITH DATA
PRIMARY INDEX(SalesOrderID) 
PARTITION BY RANGE_N  (
   OrderDate BETWEEN DATE '2000-01-01' AND '2019-12-31' EACH INTERVAL '1' MONTH);

CREATE MULTISET TABLE DP_RDM.SalesOrderDetail AS DP_STG2.SalesOrderDetail
WITH DATA
PRIMARY INDEX(SalesOrderID) 
PARTITION BY ProductID;

.LOGOFF