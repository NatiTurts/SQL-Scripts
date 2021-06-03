SELECT 
  C.Account
, D.CustomerName AS AccountDescription
, C.uiARStarrating AS [Star Rating]
, C.Area, C.ulARInternalrep1 AS InternalRep
, I.Target
, P.Reference AS [Invoice Number]
, P.Order_No AS [Order Number]
, S.Code AS ItemCode
, S.Description_1 AS ItemDescription
, S.ucIIitemstyle AS ItemStyleCode
, S.ItemGroup
, C.PriceListName AS Pricelist
, C.ulARRegion as Region
, CASE WHEN C.uiARStarrating = '0' THEN S.DefaultPriceExcl WHEN C.uiARStarrating = '1' THEN S.ExPr2
	   WHEN C.uiARStarrating = '2' THEN S.ExPr3 
	   WHEN C.uiARStarrating = '3' THEN (S.ExPr3 * 0.95) 
       WHEN C.uiARStarrating = '4' THEN (S.ExPr3 * 0.925)
	   WHEN C.uiARStarrating = '5' THEN (S.ExPr3 * 0.90)
	END AS [Pricelist Price]
, NULLIF (SUM(P.ActualValue), 0) / NULLIF (SUM(P.ActualQuantityInvoiced), 0) AS [Selling Price]
, SUM(S.LastGRVCost) as [Selling Cost]
, NULLIF (SUM(P.ActualValue), 0) / NULLIF (SUM(P.ActualQuantityInvoiced), 0) - SUM(P.Cost) AS [Unit Profit]
, NULLIF (SUM(P.ActualValue), 0) / NULLIF (SUM(P.ActualQuantityInvoiced), 0) - SUM(S.LastGRVCost) AS [Unit GRV Profit]
, S.ItemGroupDescription
, S.ulIIClassification AS Classification
, P.RepCode
, P.RepName
, S.LastGRVCost AS [Last GRV Unit Cost]
, P.TxDate AS Date
, CASE WHEN SUM(ActualValue) > I.Target THEN 'Target Achieved' ELSE 'Target not Achieved' END AS [Target Status]
, DATENAME(month, P.TxDate) AS Month
, CAST(YEAR(P.TxDate) AS VARCHAR(4)) AS Year
, CASE WHEN datename(month, P.txdate) = 'December' THEN '1'
	   WHEN datename(month, P.txdate) = 'January' THEN '2' 
	   WHEN datename(month, P.txdate) = 'February' THEN '3' 
	   WHEN datename(month, P.txdate) = 'March' THEN '4'
	   WHEN datename(month, P.txdate) = 'April' THEN '5' 
	   WHEN datename(month, P.txdate) = 'May' THEN '6' 
	   WHEN datename(month, P.txdate) = 'June' THEN '7' 
	   WHEN datename(month, P.txdate) = 'July' THEN '8' 
	   WHEN datename(month, P.txdate) = 'August' THEN '9' 
	   WHEN datename(month, P.txdate) = 'September' THEN '10' 
	   WHEN datename(month, P.txdate) = 'October' THEN '11'
	   WHEN datename(month, P.txdate) = 'November' THEN '12' END AS MonthNo
, SUM(P.ActualQuantityInvoiced) AS Quantity
, SUM(P.Cost * P.ActualQuantityInvoiced) AS LineCost
, SUM(S.LastGRVCost * P.ActualQuantityInvoiced) AS LastGRVCost
, SUM(P.ActualValue) AS LineSales
, SUM(P.ActualValue) - SUM(P.Cost * P.ActualQuantityInvoiced) AS Profit
, SUM(P.ActualValue) - SUM(S.LastGRVCost * P.ActualQuantityInvoiced) AS GRVProfit
FROM ICC_NEW.dbo._bvSTTransactionsFull AS P
LEFT JOIN ICC_NEW.dbo._bvARAccountsFull AS C ON C.DCLink = P.DrCrAccount
LEFT JOIN ICC_NEW.dbo._bvCMCustomerFull AS D ON D.Customer = C.Account
LEFT JOIN ICC_NEW.dbo._bvStockFull AS S ON S.StockLink = P.AccountLink
INNER JOIN ICC_APP.dbo.Internal_Sales_Targets AS I ON I.Full_Name = C.ulARInternalrep1
WHERE (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2020-12-01') AND (P.TxDate <= '2021-11-30')
GROUP BY C.Account, P.Reference, S.LastGRVCost, S.ExPr3, S.ExPr2, C.PriceListName, S.DefaultPriceExcl, P.Order_No, I.Target, C.uiARStarrating, P.TxDate, D.CustomerName, C.ulARInternalrep1, C.Area, S.Code, S.Description_1, S.ucIIitemstyle, 
                  , C.ulARRegion,S.ItemGroup, S.ItemGroupDescription, S.ulIIClassification, P.RepCode, P.RepName, CAST(YEAR(P.TxDate) AS VARCHAR(4)), DATENAME(month, P.TxDate), CAST(MONTH(P.TxDate) AS VARCHAR(4))