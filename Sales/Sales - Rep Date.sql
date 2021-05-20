select c.account COLLATE Latin1_General_CI_AS as Account
, C.Name COLLATE Latin1_General_CI_AS as AccountDescription
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, p.RepCode COLLATE Latin1_General_CI_AS as RepCode
, p.RepName COLLATE Latin1_General_CI_AS as RepName
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum((P.Cost * P.ActualQuantityInvoiced))-sum(P.ActualQuantityInvoiced)
from icc_new.dbo._bvSTTransactionsFull P 
LEFT JOIN icc_new.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN icc_new.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@DateStart) and (P.TxDate<=@DateEnd)
Group by c.account, C.Name, s.code, s.Description_1, p.repcode, p.repname, CAST(YEAR(p.txdate) AS VARCHAR(4))

union all

select c.account COLLATE Latin1_General_CI_AS as Account
, C.Name COLLATE Latin1_General_CI_AS as AccountDescription
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, p.RepCode COLLATE Latin1_General_CI_AS as RepCode
, p.RepName COLLATE Latin1_General_CI_AS as RepName
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum((P.Cost * P.ActualQuantityInvoiced))-sum(P.ActualQuantityInvoiced)
from The_Industrial_Clothing_Company.dbo._bvSTTransactionsFull P 
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@DateStart) and (P.TxDate<=@DateEnd)
Group by c.account, C.Name, s.code, s.Description_1, p.repcode, p.repname,CAST(YEAR(p.txdate) AS VARCHAR(4))
