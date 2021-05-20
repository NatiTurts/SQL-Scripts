select c.account as Account
, D.CustomerName as AccountDescription
, C.uiARStarrating as [Star Rating]
, C.Area as Area
, C.ulARInternalrep1 as InternalRep
, I.Target
, P.Order_No as [Order Number]
, S.Code as ItemCode
, S.Description_1 as ItemDescription
, S.ucIIitemstyle as ItemStyleCode
, S.ItemGroup as ItemGroup
, C.PriceListName as Pricelist
, case  when C.uiARStarrating = '0' then S.DefaultPriceExcl
		when C.uiARStarrating = '1' then S.ExPr2
		when C.uiARStarrating = '2' then S.ExPr3
		when C.uiARStarrating = '3' then (S.ExPr3*0.95)
		when C.uiARStarrating = '4' then (S.ExPr3*0.925)
		when C.uiARStarrating = '5' then (S.ExPr3*0.90)
		end as [Pricelist Price]
, NULLIF(sum(ActualValue),0)/NULLIF(sum(P.ActualQuantityInvoiced),0) as [Selling Price]
, S.ItemGroupDescription as ItemGroupDescription
, S.ulIIClassification as Classification
, p.RepCode as RepCode
, p.RepName as RepName
, p.txdate as Date
, Case when sum(ActualValue) > I.Target then 'Target Achieved' else 'Target not Achieved' end as [Target Status]
, Datename(month,p.txdate) as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum(ActualValue)-sum((P.Cost * P.ActualQuantityInvoiced))
from icc_new.dbo._bvSTTransactionsFull P
LEFT JOIN icc_new.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN ICC_NEW.dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN icc_new.dbo._bvStockFull S on S.StockLink = P.AccountLink 
Inner Join ICC_APP.dbo.Internal_Sales_Targets I on I.Full_Name = C.ulARInternalrep1
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2020-1-01') and (P.TxDate<='2020-12-31')
Group by c.account, S.ExPr3, S.ExPr2, C.PriceListName, S.DefaultPriceExcl, P.Order_No, I.Target, C.uiARStarrating, p.txdate, D.CustomerName, C.ulARInternalrep1, c.area, s.code, s.Description_1, s.ucIIitemstyle, s.ItemGroup, s.ItemGroupDescription, S.ulIIClassification, p.repcode, p.repname, CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))