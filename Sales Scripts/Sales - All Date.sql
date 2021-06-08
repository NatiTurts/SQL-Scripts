select c.account COLLATE Latin1_General_CI_AS as Account
, C.Name COLLATE Latin1_General_CI_AS as AccountDescription
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum((P.Cost * P.ActualQuantityInvoiced))-sum(P.ActualQuantityInvoiced)
from [Database].dbo._bvSTTransactionsFull P 
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@DateStart) and (P.TxDate<=@DateEnd)
Group by c.account, C.Name, s.code, s.Description_1, CAST(YEAR(p.txdate) AS VARCHAR(4))

union all

select c.account COLLATE Latin1_General_CI_AS as Account
, C.Name COLLATE Latin1_General_CI_AS as AccountDescription
, S.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year],
Quantity = sum(P.ActualQuantityInvoiced),  LineCost = sum((P.Cost * P.ActualQuantityInvoiced)),
LineSales = sum(ActualValue),
Profit = sum((P.Cost * P.ActualQuantityInvoiced))-sum(P.ActualQuantityInvoiced)
from [Database].dbo._bvSTTransactionsFull P 
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@DateStart) and (P.TxDate<=@DateEnd)
Group by c.account, C.Name, s.code, s.Description_1,CAST(YEAR(p.txdate) AS VARCHAR(4))
