ALTER VIEW [dbo].[vw_Backorders_2021]
AS
SELECT P.LineItem AS Code
, P.Description_1 AS Description
, P.ucIIitemstyle AS Parent
, P.OrderNum AS Order_Number
, P.RepName AS Rep
, P.OrderDate AS Order_Date
, P.DueDate
, P.DeliveryDate
, P.ulARInternalrep1 AS Internal_Rep
, P.Account AS Customer
, C.CustomerName AS Customer_Name
, P.Qty_On_Hand AS SOH
, SUM(P.QtyOutstanding) AS Qty_Outstanding
, SUM(P.QtyOutstanding * P.fUnitPriceExcl) AS Value
, DATENAME(month, P.OrderDate) AS Month
, CAST(YEAR(P.OrderDate) AS VARCHAR(4)) AS Year
, Case when datename(month, P.OrderDate) = 'December' then '1'
	   when datename(month, P.OrderDate) = 'January' then '2'
	   when datename(month, P.OrderDate) = 'February' then '3'
	   when datename(month, P.OrderDate) = 'March' then '4'
	   when datename(month, P.OrderDate) = 'April' then '5'
	   when datename(month, P.OrderDate) = 'May' then '6'
	   when datename(month, P.OrderDate) = 'June' then '7'
	   when datename(month, P.OrderDate) = 'July' then '8'
	   when datename(month, P.OrderDate) = 'August' then '9'
	   when datename(month, P.OrderDate) = 'September' then '10'
	   when datename(month, P.OrderDate) = 'October' then '11'
	   when datename(month, P.OrderDate) = 'November' then '12'
	   end as [MonthNo]
, P.ulIIClassification, P.ItemGroup
FROM [Database].dbo._bvSalesOrdersFull AS P
LEFT OUTER JOIN [Database].dbo._bvCMCustomerFull AS C ON C.Customer = P.Account
WHERE  (C.Customer NOT IN ('ALL030', 'TJO002', 'TOY001')) AND (P.On_Hold = '0') AND (P.bCODAccount = '0') AND (P.DocumentStateDesc IN ('Partially Processed', 'Unprocessed', 'Unprocessed and Patrcially')) AND (P.QtyOutstanding > 0) AND 
(P.OrderDate >= '2020-01-01') AND (P.OrderDate <= '2021-12-31') AND (P.ubIIPlanning = 'TRUE') AND (P.WarehouseCode NOT IN ('IN01')) AND (P.ubIDSOrdEmbroideryorder = '0') AND (P.DueDate < GETDATE()) AND 
(P.OrderDate < DATEADD(MONTH, DATEDIFF(MONTH, - 1, GETDATE()) - 1, 0))
GROUP BY P.LineItem, P.Description_1, P.ucIIitemstyle, P.Qty_On_Hand, P.OrderNum, P.RepName, P.DueDate, P.OrderDate, P.DeliveryDate, P.ulARInternalrep1, P.Account, C.CustomerName, P.ulIIClassification, P.ItemGroup

