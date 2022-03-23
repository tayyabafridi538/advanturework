.LOGON 192.168.119.128/dbc,dbc; 
DATABASE DP_STG2;
--HR Module


CREATE TABLE DP_STG2.Department
(
DepartmentID INTEGER GENERATED ALWAYS AS IDENTITY
           (START WITH 1 
            INCREMENT BY 1 
            MINVALUE 1 
            NO CYCLE),
			DepartmentName VARCHAR(32),
			GroupName VARCHAR(32)
)

PRIMARY INDEX (DepartmentID);

CREATE TABLE DP_STG2.Shift
(
           ShiftID INTEGER GENERATED ALWAYS AS IDENTITY (
		   START WITH 1
		   INCREMENT BY 1
		   MINVALUE 1
		   NO CYCLE),
		   Name1 VARCHAR(8),
		   StartTime TIME(6),
		   EndTime TIME(6)
)
PRIMARY INDEX (ShiftID);

CREATE TABLE DP_STG2.Employee
(
           BusinessEntityID INTEGER,
		   NationalIDNumber INTEGER,
		   LoginID VARCHAR(32),
		   --ShiftID no relation defined in LDM
		   JobTitle VARCHAR(32),
		   BirthDate DATE FORMAT 'MM/DD/YYYY',
		   --MaritalStatus not available
		   Gender CHAR(1),
		   HireDate DATE FORMAT 'MM/DD/YYYY',
		   --SalariedFlag not available
		   VacationHours INTEGER,
		   SickLeaveHours INTEGER
		   --CurrentFlag Not available		   
)
PRIMARY INDEX (BusinessEntityID);

CREATE TABLE DP_STG2.EmployeeDepartmentHistory
(
           BusinessEntityID INTEGER,
		   DepartmentID INTEGER,        
		   StartDate DATE FORMAT 'MM/DD/YYYY',
		   ShiftID INTEGER,
		   EndDate DATE FORMAT 'MM/DD/YYYY'
)
PRIMARY INDEX (StartDate);


--Purchase Module

CREATE TABLE DP_STG2.ProductVendor
(
           BusinessEntityID INTEGER,
		   ProductID INTEGER,
		   AverageLeadTime INTEGER,
           StandardPrice DECIMAL(4,2),
		   LastReceiptCost DECIMAL(4,2), 
		   LastReceiptDate DATE FORMAT 'MM/DD/YYYY',
		   MinOrderQty INTEGER,
		   MaxOrderQty INTEGER,
		   OnOrderQty INTEGER,
		   UnitMeasureCode CHAR(3)
)
PRIMARY INDEX ( BusinessEntityID);

CREATE TABLE DP_STG2.PurchaseOrderDetail
(
           PurchaseOrderID INTEGER,
           PurchaseOrderDetailID INTEGER,
		   DueDate DATE FORMAT 'MM/DD/YYYY',
		   ProductID INTEGER,
		   OrderQty INTEGER,
		   UnitPrice DECIMAL(7,2),
		   LineTotal DECIMAL(9,2),
		   ReceivedQty INTEGER,
		   RejectedQty INTEGER,
		   StockedQty INTEGER
)
PRIMARY INDEX (PurchaseOrderDetailID);

CREATE TABLE DP_STG2.PurchaseOrderHeader
(
           PurchaseOrderID INTEGER,
		   ShipMethodID INTEGER,
		   VendorID INTEGER,
		   RevisionNumber INTEGER,
		   Status INTEGER,
		   EmployeeID INTEGER,
		   OrderDate DATE FORMAT 'MM/DD/YYYY',
		   ShipDate DATE FORMAT 'MM/DD/YYYY',
		   SubTotal DECIMAL(9,2),
		   TaxAmt DECIMAL(7,2),
		   Freight DECIMAL(7,2),
		   TotalDue DECIMAL(9,2)
)
PRIMARY INDEX (PurchaseOrderID);

CREATE TABLE DP_STG2.ShipMethod
(
           ShipMethodID INTEGER,
           Name1 VARCHAR(32),
		   ShipBase DECIMAL(4,2),
		   ShipRate DECIMAL(4,2)
)
PRIMARY INDEX (ShipMethodID);

CREATE TABLE DP_STG2.Vendor
(
           BusinessEntityID INTEGER,
           AccountNumber VARCHAR(24),
		   Name1 VARCHAR(32), 
		   CreditRating BYTEINT,
		   PreferredVendorStatus BYTEINT,
		   ActiveFlag BYTEINT,
		   PurchasingWebServiceURL VARCHAR(64)
)
PRIMARY INDEX ( BusinessEntityID);

--Person Module

CREATE TABLE DP_STG2.Address
(
AddressID INTEGER,
AddressLine1 VARCHAR(100),
AddressLine2 VARCHAR(100),
City VARCHAR(16),
StateProvinceID INTEGER,
PostalCode VARCHAR(32),
SpatialLocation VARCHAR(200)
)
PRIMARY INDEX(AddressID);

CREATE TABLE DP_STG2.AddressType(
AddressTypeID INTEGER,
Name1 VARCHAR(8)
)
PRIMARY INDEX(AddressTypeID);

CREATE TABLE DP_STG2.BusinessEntity
(
BusinessEntityID INTEGER
)
PRIMARY INDEX(BusinessEntityID);

CREATE TABLE DP_STG2.BusinessEntityAddress(
AddressID INTEGER,
BusinessEntityID INTEGER,
AddressTypeID VARCHAR(8)
)
PRIMARY INDEX(AddressID);

CREATE TABLE DP_STG2.ContactType
(
BusinessEntityID INTEGER,
Name1 VARCHAR(16)
)
PRIMARY INDEX(BusinessEntityID);

CREATE TABLE DP_STG2.CountryRegion
(
CountryRegionCode CHAR(4),
Name1 VARCHAR(32)

)
PRIMARY INDEX(CountryRegionCode);

CREATE TABLE DP_STG2.EmailAddress
(
BusinessEntityID INTEGER,
EmailAddressID INTEGER,
EmailAddress VARCHAR(64)
)
PRIMARY INDEX(BusinessEntityID);

CREATE TABLE DP_STG2.Passwords
(
BusinessEntityID INTEGER,
PasswordHash VARCHAR(256),
PasswordSalt VARCHAR(32)
)
PRIMARY INDEX(BusinessEntityID);

CREATE TABLE DP_STG2.Person
(
           BusinessEntityID INTEGER,
		   PersonType CHAR(2),
		   --NameStyle INTEGER  has nothing only zero so drop it,
		   Title1 CHAR(4),
		   FirstName VARCHAR(16),
		   MiddleName VARCHAR(16),
		   LastName VARCHAR(16),
		   Suffix CHAR(5),
		   EmailPromotion BYTEINT,
		   --AdditionalContactInfo VARCHAR(200) WE DON'T NEED THIS,
		 DemoGraphics1 VARCHAR(200)
)
PRIMARY INDEX (BusinessEntityID);

CREATE TABLE DP_STG2.PhoneNumberType(
PhoneNumberTypeID INTEGER GENERATED ALWAYS AS IDENTITY
(START WITH 1
INCREMENT BY 1
MINVALUE 1
NO CYCLE),
Name1 VARCHAR(8)
)
PRIMARY INDEX(PhoneNumberTypeID);

CREATE TABLE DP_STG2.PersonPhone
(
BusinessEntityID INTEGER,
PhoneNumber VARCHAR(64),
PhoneNumberTypeID INTEGER
)
PRIMARY INDEX(BusinessEntityID);

CREATE TABLE DP_STG2.StateProvince
(
StateProvinceID INTEGER,
StateProvinceCode CHAR(6),
CountryRegionCode CHAR(4),
isOnlyStateProvinceFlag BYTEINT,
Name1 VARCHAR(32),
TerritoryID INTEGER

)
PRIMARY INDEX(StateProvinceID);

--Product Module

CREATE TABLE DP_STG2.BillofMaterials(
BillOfMaterialsID INTEGER,
ProductAssemblyID INTEGER,
ComponentID INTEGER,
StartDate DATE FORMAT 'MM/DD/YYYY',
EndDate DATE FORMAT 'MM/DD/YYYY',
UnitMeasureCode VARCHAR(8),
BOMLevel INTEGER,
PerAssemblyQty DECIMAL(10,2)
)
PRIMARY INDEX(BillOfMaterialsID);

CREATE TABLE DP_STG2.Culture(
CultureID VARCHAR(8),
Name1 VARCHAR(16)
)
PRIMARY INDEX(CultureID);

CREATE TABLE DP_STG2.Product (
ProductID INTEGER,
Name1 VARCHAR(32),
ProductNumber VARCHAR(16),
MakeFlag BYTEINT,
FinishedGoodsFlag BYTEINT,
Color VARCHAR(8),
SafetyStockLevel SMALLINT,
ReorderPoint SMALLINT,
StandardCost DECIMAL(10,2),
ListPrice DECIMAL(10,2),
Size1 VARCHAR(16),
SizeUnitMeasureCode VARCHAR(16),
WeightUnitMeasureCode VARCHAR(16),
Weight DECIMAL(5,2),
DayToManufacture SMALLINT,
ProductLine VARCHAR(8),
Class1 VARCHAR(8),
Style1 VARCHAR(8),
ProductSubcategoryID INTEGER,
ProductModelID INTEGER,
SellStartDate DATE FORMAT 'MM/DD/YYYY',
SellEndDate DATE FORMAT 'MM/DD/YYYY',
DiscontinuedDate DATE FORMAT 'MM/DD/YYYY'
)
PRIMARY INDEX(ProductID);

CREATE TABLE DP_STG2.ProductCategory(
ProductCategoryID SMALLINT,
Name1  VARCHAR(16)
)
PRIMARY INDEX(ProductCategoryID);

CREATE TABLE DP_STG2.ProductCostHistory  (
ProductID INTEGER,
StartDate DATE FORMAT 'MM/DD/YYYY',
EndDate DATE FORMAT 'MM/DD/YYYY',
StandardCost DECIMAL(10,2)
)
PRIMARY INDEX(ProductID);

CREATE TABLE DP_STG2.ProductDescription(
ProductDescriptionID INTEGER,
Description VARCHAR(512)
)
PRIMARY INDEX(ProductDescriptionID);

CREATE TABLE DP_STG2.ProductInventory (
ProductID INTEGER,
LocationID SMALLINT,
Shelf  VARCHAR(16),
Bin  VARCHAR(16),
Quantity SMALLINT
)
PRIMARY INDEX(ProductID);

CREATE TABLE DP_STG2.ProductListPriceHistory  (
ProductID INTEGER,
StartDate DATE FORMAT 'MM/DD/YYYY',
EndDate DATE FORMAT 'MM/DD/YYYY',
ListPrice DECIMAL(10,2)
)
PRIMARY INDEX(ProductID);

CREATE TABLE DP_STG2.ProductModel (
ProductModelID SMALLINT,
Name1 VARCHAR(32),
CatalogDescription VARCHAR(32),
Instruction VARCHAR(32)
)
PRIMARY INDEX(ProductModelID);

CREATE TABLE DP_STG2.ProductModelProductDesctriptionCulture (
ProductModelID SMALLINT,
ProductDescriptionID INTEGER,
CultureID VARCHAR(8)
)
PRIMARY INDEX(ProductModelID);

CREATE TABLE DP_STG2.ProductSubCategory(
ProductSubCategoryID SMALLINT,
ProductCategoryID SMALLINT,
Name1  VARCHAR(16)
)
PRIMARY INDEX(ProductSubCategoryID);

CREATE TABLE DP_STG2.ScrapReason (
ScrapReasonID INTEGER,
Name1 VARCHAR(64)
)
PRIMARY INDEX(ScrapReasonID);

CREATE TABLE DP_STG2.TransactionHistory(
TransactionID INTEGER,
ProductID INTEGER,
ReferenceOrderID INTEGER,
ReferenceOrderLineID SMALLINT,
TransactionDate DATE FORMAT 'MM/DD/YYYY',
TransactionType VARCHAR(8),
Quantity SMALLINT,
ActualCost DECIMAL(10,2)
)
PRIMARY INDEX(TransactionID);

CREATE TABLE DP_STG2.UnitMeasure (
UnitMeasureCode CHAR(8),
Name1 VARCHAR(32)
)
PRIMARY INDEX(UnitMeasureCode);

CREATE TABLE DP_STG2.WorkOrder(
WorkOrderID INTEGER,
ProductID INTEGER,
OrderQty INTEGER,
StockedQty INTEGER,
ScrappedQty INTEGER,
StartDate DATE FORMAT 'MM/DD/YYYY',
EndDate DATE FORMAT 'MM/DD/YYYY',
DueDate DATE FORMAT 'MM/DD/YYYY',
ScrapReasonID INTEGER
)
PRIMARY INDEX(WorkOrderID);

CREATE TABLE DP_STG2.WorkOrderRouting(
WorkOrderID INTEGER,
ProductID INTEGER,
OperationSequence INTEGER,
LocationID INTEGER,
ScheduledStartDate DATE FORMAT 'MM/DD/YYYY',
ScheduledEndDate DATE FORMAT 'MM/DD/YYYY',
ActualStartDate DATE FORMAT 'MM/DD/YYYY',
ActualEndDate DATE FORMAT 'MM/DD/YYYY',
ActualResourceHrs DECIMAL(10,2),
PlannedCost DECIMAL(10,2),
ActualCost DECIMAL(10,2)
)
PRIMARY INDEX(WorkOrderID);

--Sales

CREATE TABLE DP_STG2.CreditCard(
		CreditCardID INTEGER,
		CardType VARCHAR(16),
		CardNumber VARCHAR(64),
		ExpMonth SMALLINT,
		ExpYear SMALLINT
		)
		PRIMARY INDEX(CreditCardID);
		
CREATE TABLE DP_STG2.Currency
	(
		CurrencyCode CHAR(3) NOT NULL ,
		Name1 VARCHAR(64) NOT NULL
	)
		PRIMARY INDEX(CurrencyCode);

CREATE TABLE DP_STG2.CurrencyRate(
		CurrencyRateID INTEGER,
		CurrencyRateDate DATE FORMAT 'MM/DD/YYYY',
		FromCurrencyCode VARCHAR(4),
		ToCurrencyCode VARCHAR(4),
		AverageRate DECIMAL(8,2),
		EndOfDayRate DECIMAL(8,2) 
		)
		PRIMARY INDEX(CurrencyRateID);

CREATE TABLE DP_STG2.Customer
	(
	  CustomerID INTEGER,
	  PersonID INTEGER ,
	  StoreID INTEGER,
	  TerritoryID INTEGER,
	  AccountNumber VARCHAR(32)
	 )
PRIMARY INDEX (CustomerID);

	CREATE TABLE DP_STG2.PersonCreditCard(
	    BusinessEntityID INTEGER,
		CreditCardID INTEGER
		)
		PRIMARY INDEX(BusinessEntityID,CreditCardID);
		
CREATE TABLE DP_STG2.SalesOrderDetail
	(
		BusinessEntityID INTEGER,
		SalesOrderID INTEGER,
		SalesOrderDetailID INTEGER,
		CarrierTrackingNumber VARCHAR(16),
		 OrderQty INTEGER,
		 ProductID INTEGER,
		 SpecialOfferID INTEGER,
		 UnitPrice DECIMAL(10,2),
		 UnitPriceDiscount  DECIMAL(6,2),
		 LineTotal DECIMAL(10,2)
	 )
	PRIMARY INDEX (SalesOrderDetailID,SalesOrderID,BusinessEntityID);

CREATE TABLE DP_STG2.SalesOrderHeader
	(
		BusinessEntityID INTEGER,
		SalesOrderID	INTEGER,
		ShipMethodID	INTEGER,
		SalesPersonID   INTEGER,
		RevisionNumber	INTEGER,
		OrderDate	DATE  FORMAT 'MM/DD/YYYY',
		DueDate	DATE FORMAT 'MM/DD/YYYY',
		ShipDate	DATE  FORMAT 'MM/DD/YYYY',
		Status	BYTEINT,
		OnlineOrderFlag	BYTEINT,
		SalesOrderNumber	VARCHAR(16),
		PurchaseOrderNumber	VARCHAR(16),
		AccountNumber	VARCHAR(16),
		TerritoryID	INTEGER,
		BillToAddressID	INTEGER,
		ShipToAddressID	INTEGER,
		CreditCardID INTEGER,
		CreditCardApprovalCode VARCHAR(32),
		CurrencyRateID	INTEGER,
		SubTotal	DECIMAL (10,2),
		TaxAmt	DECIMAL (10,2),
		Freight	DECIMAL (10,2),
		TotalDue	DECIMAL (10,2)
	)
	PRIMARY INDEX (SalesOrderID,BusinessEntityID);

CREATE TABLE DP_STG2.SalesOrderHeaderSalesReason
	(
	    BusinessEntityID INTEGER,
		SalesOrderID INTEGER,
		SalesReasonID INTEGER
	)
		PRIMARY INDEX(BusinessEntityID,SalesOrderID,SalesReasonID);

CREATE TABLE DP_STG2.SalesPerson(
		BusinessEntityID INTEGER,
		TerritoryID INTEGER,
		SalesQuota DECIMAL(10,2),
		Bonus DECIMAL(10,2) ,
		CommissionPct DECIMAL(10,2),
		SalesYTD DECIMAL(10,2) ,
		SalesLastYear DECIMAL(10,2)
		)
PRIMARY INDEX(BusinessEntityID);

CREATE TABLE DP_STG2.SalesPersonQuotaHistory
	(
	  BusinessEntityID INTEGER,
	  SalesQuota DECIMAL(10,2),
      QuotaDate DATE FORMAT 'MM/DD/YYYY'
	 )
PRIMARY INDEX (BusinessEntityID,QuotaDate);

CREATE TABLE DP_STG2.SalesReason
	(
		SalesReasonID INTEGER,
		Name1 VARCHAR(32),
		ReasonType VARCHAR(32) 
	)
		PRIMARY INDEX(SalesReasonID);

CREATE TABLE DP_STG2.SalesTerritory
	(
	  TerritoryID INTEGER,
      Name1 VARCHAR(40),
      CountryRegionCode CHAR(5),
      Group1 VARCHAR(20),
      SalesYtd DECIMAL(15,2),
      SalesLastYear DECIMAL(15,2),
      CostYtd DECIMAL(10,2),
      CostLastYear DECIMAL(10,2)
	 )
PRIMARY INDEX ( TerritoryID );

CREATE TABLE DP_STG2.SalesTaxRate
	(
		SalesTaxRateID INTEGER ,
		StateProvinceID INTEGER,
		TaxType BYTEINT,
		TaxRate DECIMAL(4,2),
		Name1 VARCHAR(32) 
	)
		PRIMARY INDEX(SalesTaxRateID);


CREATE TABLE DP_STG2.SalesTerritoryHistory
	(
	  BusinessEntityID INTEGER,
	  TerritoryID INTEGER,
      StartDate DATE FORMAT 'MM/DD/YYYY',
	  EndDate DATE FORMAT 'MM/DD/YYYY'
	 )
PRIMARY INDEX (BusinessEntityID,TerritoryID,StartDate);

	CREATE TABLE DP_STG2.ShoppingCartItem
	(
		ShoppingCartItemID INTEGER ,
		ShoppingCartID VARCHAR(64),
		Quantity INTEGER,  
		ProductID INTEGER,
		DateCreated DATE  FORMAT 'MM/DD/YYYY'
	)
		PRIMARY INDEX(ShoppingCartItemID);
		
CREATE TABLE DP_STG2.SpecialOffer
	(
		SpecialOfferID INTEGER ,
		Description VARCHAR(256),
		DiscountPct DECIMAL(8,2),
		Type1 VARCHAR(64),
		Category VARCHAR(64),
		StartDate DATE FORMAT 'MM/DD/YYYY',
		EndDate DATE FORMAT 'MM/DD/YYYY',
		MinQty INTEGER,
		MaxQty INTEGER 
	)
PRIMARY INDEX(SpecialOfferID);

CREATE TABLE DP_STG2.SpecialOfferProduct
	(
		SpecialOfferID INTEGER,
		ProductID INTEGER 
	)
PRIMARY INDEX(SpecialOfferID);

	CREATE TABLE DP_STG2.Store(
		BusinessEntityID INTEGER NOT NULL,
		SalesPersonID INTEGER,
		NAME1 VARCHAR(32),
		DEMOGRAPHICS1 VARCHAR(256)
		)
		PRIMARY INDEX(BusinessEntityID);
		

.LOGOFF