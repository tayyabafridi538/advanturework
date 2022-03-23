.LOGON 192.168.119.128/dbc,dbc
DATABASE DP_SDM;


/*********************************Vendor_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Vendor_DIM
(
      Vendor_id INTEGER,
      Vendor_Name VARCHAR(50)
)
PRIMARY INDEX ( Vendor_id );

/*********************************Country_Region_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Country_Region_DIM
(
      Country_Region_id VARCHAR(8),
      Country_Region_Name VARCHAR(50)
)
PRIMARY INDEX ( Country_Region_id );

/*********************************Payment_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Payment_Type_DIM
(
      Payment_Type_id INTEGER,
      Payment_Type_Name VARCHAR(50)
)
PRIMARY INDEX ( Payment_Type_id );

/*********************************Person_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Person_DIM
(
      Person_id INTEGER,
      First_Name VARCHAR(50),
      Middle_Name VARCHAR(50),
      Last_Name VARCHAR(50)
)
PRIMARY INDEX ( Person_id );

/*********************************Product_Cat_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Product_Cat_DIM
(
      Product_Cat_id INTEGER,
      Product_Cat_Name VARCHAR(50)
)
PRIMARY INDEX ( Product_Cat_id );

/*********************************Product_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Product_DIM
(
      Product_id INTEGER,
      Product_Sub_cat_id INTEGER,
      Product_Name VARCHAR(50)
)
PRIMARY INDEX ( Product_id );


/*********************************Product_Purchase_Fact_Monthly***********************************/

CREATE MULTISET TABLE DP_SDM.Product_Purchase_Fact_Monthly
(
      Vendor_id INTEGER,
      Product_id INTEGER,
      Order_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Type_id INTEGER,
      Purchase_Amt DECIMAL(19,2),
      Purchase_Qty INTEGER,
      Recieved_Qty INTEGER,
      Rejected_Qty INTEGER
)
PRIMARY INDEX ( Order_Month_id ,Ship_Month_id )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2000-05-17' AND DATE '2020-10-23' EACH INTERVAL '1' MONTH);

/*********************************Product_Sales_Fact_Monthly***********************************/

CREATE MULTISET TABLE DP_SDM.Product_Sales_Fact_Monthly
(
      Customer_ID INTEGER,
      Order_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Product_ID INTEGER,
      Sales_Person_ID INTEGER,
      Territory_ID INTEGER,
      Sale_Type_ID INTEGER,
      Payment_Type_ID INTEGER,
      Shipt_Type_ID INTEGER,
      Sales_Amt DECIMAL(19,2),
      Sales_Qty INTEGER,
      Unit_Price DECIMAL(19,2),
      Cost_Price DECIMAL(19,2),
      Discount_Amount DECIMAL(19,2),
      Profit DECIMAL(19,2)
)
PRIMARY INDEX ( Customer_id ,Order_Month_id )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2000-04-01' AND DATE '2020-06-27' EACH INTERVAL '1' MONTH);

/*********************************Product_Sub_Cat_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Product_Sub_Cat_DIM
(
      Product_Sub_Cat_id INTEGER,
      Product_Sub_Cat_Name VARCHAR(50),
      Product_Cat_id INTEGER
)
PRIMARY INDEX ( Product_Sub_Cat_id );

/*********************************Purchase_Fact_Monthly***********************************/

CREATE MULTISET TABLE DP_SDM.Purchase_Fact_Monthly
(
      Vendor_id INTEGER,
      Order_Month_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Type_id DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_id INTEGER,
      Purchase_Amt DECIMAL(19,2),
      Purchase_Qty INTEGER,
      Freight DECIMAL(19,2),
      Tax_Amt DECIMAL(19,2),
      Recieved_Qty INTEGER,
      Rejected_Qty INTEGER
)
PRIMARY INDEX ( Order_Month_id ,Ship_Month_id )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2000-05-17' AND DATE '2020-10-23' EACH INTERVAL '1' MONTH);

/*********************************Sales_Fact_Monthly***********************************/

CREATE MULTISET TABLE DP_SDM.Sales_Fact_Monthly
     (
      Customer_ID INTEGER,
      Order_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Ship_Month_ID DATE FORMAT 'MM/DD/YYYY',
      Sales_Person_ID INTEGER,
      Territory_ID INTEGER,
      Sale_Type_ID INTEGER,
      Payment_Type_ID INTEGER,
      Ship_Type_ID INTEGER,
      Sales_Amt DECIMAL(19,2),
      Freight_Amt DECIMAL(19,2),
      Tax_Amt DECIMAL(19,2)
	)
PRIMARY INDEX ( Customer_ID ,Order_Month_ID )
PARTITION BY RANGE_N (Order_Month_ID BETWEEN DATE '2005-04-01' AND DATE '2012-06-27' EACH INTERVAL '1' MONTH);

/*********************************Sales_Type_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Sales_Type_DIM
(
      Sales_Type_id INTEGER,
      Sales_Type_Name VARCHAR(50)
)
PRIMARY INDEX ( Sales_Type_id );

/*********************************Ship_Type_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Ship_Type_DIM
(
      Ship_Type_id INTEGER,
      Ship_Type_Name VARCHAR(50)
)
PRIMARY INDEX ( Ship_Type_id );

/*********************************Territory_DIM***********************************/

CREATE MULTISET TABLE DP_SDM.Territory_DIM
(
      Territory_id INTEGER,
      Territory_Name VARCHAR(50),
      Country_Region_id VARCHAR(8)
)
PRIMARY INDEX ( Territory_id );

