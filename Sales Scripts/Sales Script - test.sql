select c.account COLLATE Latin1_General_CI_AS as Account
, C.Name COLLATE Latin1_General_CI_AS as AccountDescription
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, S.ucIIitemstyle COLLATE Latin1_General_CI_AS as ItemStyleCode
, S.ItemGroup COLLATE Latin1_General_CI_AS as ItemGroup
, S.ItemGroupDescription COLLATE Latin1_General_CI_AS as ItemGroupDescription
, N.ulIDSOrdSalesRep COLLATE Latin1_General_CI_AS as InternalSales
, p.RepCode COLLATE Latin1_General_CI_AS as RepCode
, p.RepName COLLATE Latin1_General_CI_AS as RepName
, Datename(month,p.txdate) COLLATE Latin1_General_CI_AS as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum((P.Cost * P.ActualQuantityInvoiced))-sum(P.ActualQuantityInvoiced)
from icc_new.dbo._bvSTTransactionsFull P
LEFT JOIN icc_new.dbo._bvSalesOrdersFull N on P.Account = n.ulIDSOrdSalesRep
LEFT JOIN icc_new.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN icc_new.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2019-01-01') and (P.TxDate<='2019-12-31')
Group by c.account, C.Name, s.code, s.Description_1, s.ucIIitemstyle, s.ItemGroup, s.ItemGroupDescription, n.ulIDSOrdSalesRep, p.repcode, p.repname, CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))

union all

select c.account COLLATE Latin1_General_CI_AS as Account
, C.Name COLLATE Latin1_General_CI_AS as AccountDescription
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, S.ucIIitemstyle COLLATE Latin1_General_CI_AS as ItemStyleCode
, S.ItemGroup COLLATE Latin1_General_CI_AS as ItemGroup
, S.ItemGroupDescription COLLATE Latin1_General_CI_AS as ItemGroupDescription
, N.ulIDSOrdSalesRep COLLATE Latin1_General_CI_AS as InternalSales
, p.RepCode COLLATE Latin1_General_CI_AS as RepCode
, p.RepName COLLATE Latin1_General_CI_AS as RepName
, Datename(month,p.txdate) COLLATE Latin1_General_CI_AS as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum((P.Cost * P.ActualQuantityInvoiced))-sum(P.ActualQuantityInvoiced)
from The_Industrial_Clothing_Company.dbo._bvSTTransactionsFull P 
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvSalesOrdersFull N on P.Account = N.ulIDSOrdSalesRep
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2019-01-01') and (P.TxDate<='2019-12-31')
Group by c.account, C.Name, s.code, s.Description_1, s.ucIIitemstyle, s.ItemGroup, s.ItemGroupDescription, n.ulIDSOrdSalesRep, p.repcode, p.repname,CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))