select 
 c.ulARInternalrep1 as [Internal Sales]
, T.Target as [Target]
, Case when sum(ActualValue)>= T.Target then (sum(ActualValue)-T.Target)/1000000 * 350	   
			else '0'
    end as Prize
, Datename(month,p.txdate) as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year]
, CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo]
, Quantity = sum(P.ActualQuantityInvoiced)
, Sales = sum(ActualValue)
from [Database].dbo._bvSTTransactionsFull P
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN [Database].dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink
Inner Join [Database].dbo.Internal_Sales_Targets T on Full_Name = C.ulARInternalrep1
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and Datename(month,p.txdate) = DATENAME(MONTH, GETDATE()) and Datename(Year,p.txdate) = DATENAME(Year, GETDATE())
Group by c.ulARInternalrep1, T.Target, CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))
