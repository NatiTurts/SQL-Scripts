select 
 c.ulARInternalrep1 as InternalRep
 , Case when c.ulARInternalrep1 =	'Cynthia Maphumulo'		then	'200' 
		when c.ulARInternalrep1	=	'Caileen Parker'		then	'100'
		when c.ulARInternalrep1	=	'Carol Tshuma'			then	'100'
		when c.ulARInternalrep1	=	'Cynthia Maphumulo'		then	'100'
		when c.ulARInternalrep1	=	'Cynthia Mwanza'		then	'100'
		when c.ulARInternalrep1	=	'Engela Venter'			then	'100'
		when c.ulARInternalrep1	=	'Gugulethu Gqeba'		then	'100'
		when c.ulARInternalrep1	=	'Jabu Manzini'			then	'100'
		when c.ulARInternalrep1	=	'Joyce Chauke'			then	'100'
		when c.ulARInternalrep1	=	'Khatazile Mathebula'	then	'100'
		when c.ulARInternalrep1	=	'Latishia Alberts'		then	'100'
		when c.ulARInternalrep1	=	'Lesedi Mothupi'		then	'100'
		when c.ulARInternalrep1	=	'Other'					then	'100'
		when c.ulARInternalrep1	=	'Patricia Mothibeli'	then	'100'
		when c.ulARInternalrep1	=	'Samkeliso Ntini'		then	'100'
		when c.ulARInternalrep1	=	'Shenaaz Hortense'		then	'100'
		when c.ulARInternalrep1	=	'Shirley Ngobeni'		then	'100'
		when c.ulARInternalrep1	=	'Sindiswa Mashigo'		then	'100'
		when c.ulARInternalrep1	=	'Siyabonga Tamesi'		then	'100'
    end as Target
, Case when c.ulARInternalrep1 =	'Cynthia Maphumulo'	and sum(ActualValue)>= '200'	then sum(ActualValue)/1000000 * 350
	   when c.ulARInternalrep1 =	'Sindiswa Mashigo'	and sum(ActualValue)>= '200'	then sum(ActualValue)/1000000 * 350
			else '0'
    end as Prize
, Datename(month,p.txdate) as Month
, CAST(YEAR(p.txdate) AS VARCHAR(4))[Year]
, CAST(MONTH(p.txdate) AS VARCHAR(4))[MonthNo]
, Quantity = sum(P.ActualQuantityInvoiced)
, LineSales = sum(ActualValue)
from icc_new.dbo._bvSTTransactionsFull P
LEFT JOIN icc_new.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN ICC_NEW.dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN icc_new.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and Datename(month,p.txdate) = DATENAME(MONTH, GETDATE()) and Datename(Year,p.txdate) = DATENAME(Year, GETDATE())
Group by c.ulARInternalrep1, CAST(YEAR(p.txdate) AS VARCHAR(4)), Datename(month,p.txdate), CAST(MONTH(p.txdate) AS VARCHAR(4))
