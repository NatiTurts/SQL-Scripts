select 
	C.Account
	, C.Name as AccountDescription
	, C.uiARStarrating as [Star Rating]
	, P.ulIDSOrdSalesRep as [Internal Sales]
	, P.InvNumber as [Invoice Number]
	, P.OrderNum as [Order Number]
	, S.Code as ItemCode
	, S.Description_1 AS ItemDescription
    , S.ucIIitemstyle AS ItemStyleCode
    , S.ItemGroup
    , C.PriceListName AS Pricelist
    , CASE WHEN C.uiARStarrating = '0' THEN S.DefaultPriceExcl
           WHEN C.uiARStarrating = '1' THEN S.ExPr2 
           WHEN C.uiARStarrating = '2' THEN S.ExPr3 
           WHEN C.uiARStarrating = '3' THEN (S.ExPr3 * 0.95) 
           WHEN C.uiARStarrating = '4' THEN (S.ExPr3 * 0.925)
           WHEN C.uiARStarrating = '5' THEN (S.ExPr3 * 0.90) 
       END AS [Pricelist Price]
	, S.ItemGroupDescription
    , S.ulIIClassification AS Classification
    , P.RepCode
    , P.RepName
    , S.LastGRVCost AS [Last GRV Unit Cost]
	, NULLIF (SUM(P.fQtyProcessedLineTotExcl), 0) / NULLIF (SUM(P.fQtyProcessed), 0) AS [Selling Price]
	, P.InvDate AS Date
    , DATENAME(month, P.InvDate) AS Month
    , CAST(YEAR(P.InvDate) AS VARCHAR(4)) AS Year
    , CASE WHEN datename(month, P.InvDate) = 'December' THEN '1' 
           WHEN datename(month, P.InvDate) = 'January' THEN '2' 
           WHEN datename(month, P.InvDate) = 'February' THEN '3' 
           WHEN datename(month, P.InvDate) = 'March' THEN '4' 
           WHEN datename(month, P.InvDate) = 'April' THEN '5' 
           WHEN datename(month, P.InvDate) = 'May' THEN '6' 
           WHEN datename(month, P.InvDate) = 'June' THEN '7' 
           WHEN datename(month, P.InvDate) = 'July' THEN '8' 
           WHEN datename(month, P.InvDate) = 'August' THEN '9' 
           WHEN datename(month, P.InvDate) = 'September' THEN '10' 
           WHEN datename(month, P.InvDate) = 'October' THEN '11' 
           WHEN datename(month, P.InvDate) = 'November' THEN '12' 
       END AS MonthNo
	, SUM(P.fQtyProcessed) AS Quantity
    , SUM(P.fUnitCost * P.fQtyProcessed) AS LineCost
    , SUM(S.LastGRVCost * P.fQtyProcessed) AS LastGRVCost
    , SUM(P.fQtyProcessedLineTotExcl) AS LineSales
    , SUM(P.fQtyProcessedLineTotExcl) - SUM(P.fUnitCost * P.fQtyProcessed) AS Profit
    , SUM(P.fQtyProcessedLineTotExcl) - SUM(S.LastGRVCost * P.fQtyProcessed) AS GRVProfit
from [Database].dbo._bvSalesOrdersFull P
LEFT OUTER JOIN [Database].dbo._bvARAccountsFull AS C ON C.DCLink = P.AccountID
LEFT OUTER JOIN [Database].dbo._bvStockFull AS S ON S.StockLink = P.StockLink 
where (P.InvDate >= '2019-12-01') AND (P.InvDate <= '2020-11-30') and P.OrderNum not in ('Quote') and InvNumber not like '%TPS%' and P.InvNumber = '498621'
Group By C.Account, C.Name, C.uiARStarrating, P.ulIDSOrdSalesRep, P.InvNumber, P.OrderNum, S.Code, S.Description_1, S.ucIIitemstyle, S.ItemGroup
, C.PriceListName, S.ItemGroupDescription, S.ulIIClassification, P.RepName, P.RepCode, S.LastGRVCost, P.InvDate, P.fQtyProcessedLineTotExcl, P.fQtyProcessed
, DATENAME(month, P.InvDate), CAST(YEAR(P.InvDate) AS VARCHAR(4)), P.fUnitCost, S.DefaultPriceExcl, S.ExPr2, S.ExPr3