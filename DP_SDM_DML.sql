.LOGON 192.168.119.128/dbc,dbc
DATABASE DP_SDM;

INSERT INTO DP_SDM.Sales_Fact_Monthly
SELECT 
SOH.BusinessEntityID AS Customer_ID, 
(CAST(SOH.OrderDate AS DATE) - EXTRACT(DAY FROM SOH.OrderDate)+1) AS Order_Month_ID,			
(CAST(SOH.ShipDate AS DATE) - EXTRACT(DAY FROM SOH.ShipDate)+1) AS Ship_Month_ID,	
CAST (SOH.SalesPersonID AS INT) AS Sales_Person_ID,  
CAST (SOH.TerritoryID AS INT) AS Territory_ID, 
CAST((CASE	
			WHEN SOH.OnlineOrderFlag = '1' THEN 1 
			WHEN SOH.OnlineOrderFlag = '0' THEN 2 
			ELSE SOH.OnlineOrderFlag 
			END) AS INT) AS Sale_Type_ID,  --- 	1 is online and 2 is from the store
CAST((CASE	SOH.CreditCardID 
		    WHEN '0' THEN 1 
			ELSE 2 
			END) AS INT) AS Payment_Type_ID,	-- 1 is non creaditCard Payment and 2 is creditCard Payment
SOH.ShipMethodID AS Ship_Type_ID,
SUM(SOH.TotalDue) AS Sales_Amt,
SUM(SOH.Freight)	AS Freight_Amt,
SUM(SOH.TaxAmt)	AS Tax_Amt
FROM	
DP_RDM.SalesOrderHeader SOH
GROUP BY 1,2,3,4,5,6,7,8;

-------------------------------PURCHASE_FACT_MONTHLY-------------------------------------

INSERT INTO DP_SDM.PURCHASE_FACT_MONTHLY
SEL
		     POH.vendorid AS Vendor_id , 
			 (CAST(POH.orderdate AS DATE) - EXTRACT(DAY FROM POH.orderdate)+1) AS Order_Month_id,
             (CAST(POH.shipdate AS DATE) - EXTRACT(DAY FROM POH.shipdate)+1) AS Ship_Month_id,
	          POH.Shipmethodid AS Ship_Type_id,
	         SUM	(POH.subtotal) AS Purchase_Amt,
			 SUM   (POD.OrderQty) AS  Purchase_Qty, 
			 SUM    (POH.Freight) AS Freight,
			 SUM    (POH.Taxamt) AS Taxamt,
			 SUM (POD.ReceivedQty) AS Recieved_Qty,
			 SUM ( POD.RejectedQty) AS Rejected_Qty
	FROM 
	       DP_RDM.PurchaseOrderHeader POH
	LEFT JOIN  DP_RDM.PurchaseOrderDetail POD 
	ON POH.purchaseorderid=POD.purchaseorderid
	GROUP BY 1,2,3,4;
	
	

------------------------------PRODUCT_PURCHASE_FACT_MONTHLY--------------------------------------

INSERT INTO DP_SDM.PRODUCT_PURCHASE_FACT_MONTHLY
SELECT 
POH.VendorID,
POD.ProductID,
CAST((CAST(POH.OrderDate AS DATE) - EXTRACT(DAY FROM POH.OrderDate)+1) AS DATE FORMAT 'MM/DD/YYYY') AS OrderMonthId,
CAST((CAST(POH.ShipDate AS DATE) - EXTRACT(DAY FROM POH.ShipDate)+1)  AS DATE FORMAT 'MM/DD/YYYY') AS ShipMonthId,
SM.ShipMethodID,
SUM(POD.linetotal) AS Purchase_Amt,
CAST(SUM(POD.OrderQty) AS INTEGER) AS Purchase_Qty,
CAST(SUM(POD.ReceivedQty) AS INTEGER) AS Recieved_Qty,
CAST(SUM(POD.RejectedQty) AS INTEGER) AS Rejected_Qty

FROM DP_RDM.PurchaseOrderDetail AS POD
	JOIN DP_RDM.PurchaseOrderHeader AS POH 
	 ON POD.PurchaseOrderID = POH.PurchaseOrderID
	JOIN DP_RDM.ShipMethod AS SM 
	 ON POH.ShipMethodID = SM.ShipMethodID
GROUP BY POH.VendorID, POD.ProductID, POH.OrderDate, SM.ShipMethodID, POH.ShipDate, POH.Status;

-------------------------------Product_Sales_Fact_Monthly-------------------------------------

INSERT INTO DP_SDM.Product_Sales_Fact_Monthly
SELECT 
		SOH.BusinessEntityID AS Customer_ID, 
		(CAST(OrderDate AS DATE) - EXTRACT(DAY FROM OrderDate)+1) AS Order_Month_ID,
		(CAST(ShipDate AS DATE) - EXTRACT(DAY FROM ShipDate)+1) AS Ship_Month_ID,
		SOD.ProductID AS Product_ID, 
		SOH.SalesPersonID AS Sales_Person_ID, 
		SOH.TerritoryID AS Territory_ID,				
		(CASE	
			WHEN OnlineOrderFlag = 1 THEN 1 
			WHEN OnlineOrderFlag = 0 THEN 2 
			ELSE OnlineOrderFlag 
		END) AS Sale_Type_ID, 
		(CASE	
			WHEN SOH.CreditcardID = 0 THEN 1 
			ELSE 2 
		END) AS Payment_Type_ID,
		SOH.ShipMethodID AS Ship_Type_ID,
		SUM(SOD.LineTotal) AS Sales_Amt,
		SUM(SOD.OrderQty) AS Sales_Qty,
		SOD.UnitPrice AS Unit_Price,
		PD.StandardCost AS Standard_Cost,
		SOD.UnitPriceDiscount AS Discount_Amount,
		(COALESCE(Unit_Price,0) - (COALESCE(Standard_Cost,0) + COALESCE(Discount_Amount,0))) * COALESCE(Sales_Qty,1) AS PROFIT
FROM 
		DP_RDM.SalesOrderHeader SOH
		JOIN DP_RDM.SalesOrderDetail SOD
			ON SOH.SalesOrderID = SOD.SalesOrderID
		JOIN DP_RDM.Product PD 
			ON SOD.ProductID = PD.ProductID
		
GROUP BY 1,2,3,4,5,6,7,8,9,12,13,14;

-------------------------------VENDOR_DIM-------------------------------------

INSERT INTO DP_SDM.VENDOR_DIM
SELECT 
V.BusinessEntityID AS Vendor_id,
V.NAME1 AS vendor_name
FROM DP_RDM.Vendor V
GROUP BY 1,2;

--------------------------------PERSON_DIM------------------------------------

INSERT INTO DP_SDM.PERSON_DIM
SELECT 
businessentityid AS Person_id, 
FirstName AS First_Name, 
MiddleName AS Middle_Name, 
LastName AS Last_Name
FROM DP_RDM.Person
GROUP BY 1,2,3,4;

-----------------------------------PRODUCT_CAT_DIM---------------------------------

INSERT INTO DP_SDM.PRODUCT_CAT_DIM
SELECT 
productcategoryID, 
Name1
FROM DP_RDM.ProductCategory
GROUP BY 1,2;

--------------------------------PRODUCT_DIM------------------------------------

INSERT INTO DP_SDM.PRODUCT_DIM
SELECT 
productID AS Product_id, 
productsubcategoryID AS Product_Sub_cat_id,
Name1 AS Product_Name
FROM DP_RDM.product
GROUP BY 1,2,3;

----------------------------------PRODUCT_SUB_CAT_DIM---------------------------------

INSERT INTO DP_SDM.PRODUCT_SUB_CAT_DIM
SELECT 
productsubcategoryID AS Product_Sub_Cat_id, 
NAME1 AS Product_Sub_Cat_Name, 
productcategoryID AS Product_Cat_id
FROM DP_RDM.productsubcategory
GROUP BY 1,2,3;

---------------------------SHIP_TYPE_DIM-----------------------------------------

INSERT INTO DP_SDM.SHIP_TYPE_DIM
SELECT
		SM.ShipMethodID	AS Ship_Type_id,
		SM.NAME1 AS Ship_Type_Name
	FROM DP_RDM.ShipMethod SM
GROUP BY 1,2;

-------------------------------TERRITORY_DIM-------------------------------------

INSERT INTO DP_SDM.TERRITORY_DIM
SEL 
A.Territoryid AS Territory_id, A.Name1 AS Territory_Name, B.countryregioncode AS Country_Region_id
FROM DP_RDM.salesterritory AS A
LEFT JOIN DP_RDM.countryregion AS B
ON A.countryregioncode=B.countryregioncode
GROUP BY 1,2,3;
------------------------------Country_Region_DIM--------------------------------------

INSERT INTO DP_SDM.Country_Region_DIM
SEL 
Countryregioncode AS Country_Region_id, Name1 AS Country_Region_Name
FROM DP_RDM.CountryRegion
GROUP BY 1,2;

------------------------------Sales_Type_DIM--------------------------------------

INSERT INTO DP_SDM.Sales_Type_DIM
SEL
CASE 
	WHEN OnlineOrderFlag =1 THEN 1
	WHEN OnlineOrderFlag=0 THEN 2
	ELSE OnlineOrderFlag 
END	AS Sales_Type_id,
CASE 
	WHEN OnlineOrderFlag =1 THEN 'Online'
	WHEN OnlineOrderFlag=0 THEN 'Store'
	ELSE OnlineOrderFlag 
END	AS Sales_Type_Name
FROM
DP_RDM.Salesorderheader
GROUP BY 1,2;

-----------------------------Payment_Type_DIM---------------------------------------

INSERT INTO DP_SDM.Payment_Type_DIM
SEL
CASE 
	WHEN Creditcardid = 0 THEN 1
	ELSE 2 
END	AS Payment_Type_id,
CASE 
	WHEN Creditcardid = 0 THEN 'Cash'
	ELSE 'Credit Card' 
END	AS Payment_Type_Name
FROM
DP_RDM.Salesorderheader
GROUP BY 1,2;