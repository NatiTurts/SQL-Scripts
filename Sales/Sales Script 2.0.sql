select c.account COLLATE Latin1_General_CI_AS as Account
, D.CustomerName COLLATE Latin1_General_CI_AS as AccountDescription
, c.ulARInternalrep1 COLLATE Latin1_General_CI_AS as InternalRep
, C.Area COLLATE Latin1_General_CI_AS as Area
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, S.ucIIitemstyle COLLATE Latin1_General_CI_AS as ItemStyleCode
, S.ItemGroup COLLATE Latin1_General_CI_AS as ItemGroup
, S.ItemGroupDescription COLLATE Latin1_General_CI_AS as ItemGroupDescription
, S.ulIIClassification COLLATE Latin1_General_CI_AS as Classification
, p.RepCode COLLATE Latin1_General_CI_AS as RepCode
, p.RepName COLLATE Latin1_General_CI_AS as RepName
, Datename(month,p.txdate) COLLATE Latin1_General_CI_AS as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum(ActualValue)-sum((P.Cost * P.ActualQuantityInvoiced))
from icc_new.dbo._bvSTTransactionsFull P
LEFT JOIN icc_new.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN ICC_NEW.dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN icc_new.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2018-01-01') and (P.TxDate<='2018-12-31')
Group by c.account,  D.CustomerName, c.ulARInternalrep1, c.area, s.code, s.Description_1, s.ucIIitemstyle, s.ItemGroup, s.ItemGroupDescription, s.ulIIClassification, p.repcode, p.repname, CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))

union all

select c.account COLLATE Latin1_General_CI_AS as Account
, D.CustomerName COLLATE Latin1_General_CI_AS as AccountDescription
, c.ulARInternalrep1 COLLATE Latin1_General_CI_AS as InternalRep
, C.Area COLLATE Latin1_General_CI_AS as Area
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, S.ucIIitemstyle COLLATE Latin1_General_CI_AS as ItemStyleCode
, S.ItemGroup COLLATE Latin1_General_CI_AS as ItemGroup
, S.ItemGroupDescription COLLATE Latin1_General_CI_AS as ItemGroupDescription
, S.ulIIClassification COLLATE Latin1_General_CI_AS as Classifiaction
, p.RepCode COLLATE Latin1_General_CI_AS as RepCode
, p.RepName COLLATE Latin1_General_CI_AS as RepName
, Datename(month,p.txdate) COLLATE Latin1_General_CI_AS as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum(ActualValue)-sum((P.Cost * P.ActualQuantityInvoiced))
from The_Industrial_Clothing_Company.dbo._bvSTTransactionsFull P 
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2018-01-01') and (P.TxDate<='2018-12-31')
Group by c.account, D.CustomerName, c.ulARInternalrep1, c.area, s.code, s.Description_1, s.ucIIitemstyle, s.ItemGroup, s.ItemGroupDescription, s.ulIIClassification, p.repcode, p.repname,CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))