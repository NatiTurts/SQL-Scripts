select c.account as Account
, D.CustomerName as AccountDescription
, C.Area as Area
, C.ulARInternalrep1 as InternalRep
, P.Reference as [Invoice Number]
, P.Order_No as [Order Number]
, S.Code as ItemCode
, S.Description_1 as ItemDescription
, S.ucIIitemstyle as ItemStyleCode
, S.ItemGroup as ItemGroup
, S.ItemGroupDescription as ItemGroupDescription
, S.ulIIClassification as Classification
, p.RepCode as RepCode
, p.RepName as RepName
, p.txdate as Date
, S.LastGRVCost [Last GRV Unit Cost]
, Datename(month,p.txdate) as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((S.LastGRVCost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum(ActualValue)-sum((S.LastGRVCost * P.ActualQuantityInvoiced))
from [Database].dbo._bvSTTransactionsFull P
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN [Database].dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2020-01-01') and (P.TxDate<='2020-12-31')
Group by c.account, S.LastGRVCost, P.Order_No, P.Reference, p.txdate, D.CustomerName, C.ulARInternalrep1, c.area, s.code, s.Description_1, s.ucIIitemstyle, s.ItemGroup, s.ItemGroupDescription, S.ulIIClassification, p.repcode, p.repname, CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))