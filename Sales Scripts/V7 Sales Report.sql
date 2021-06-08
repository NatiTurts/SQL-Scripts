Declare @StartDate@ date = '2017-01-01'
Declare @EndDate@ date = '2019-07-30'

Select *
Into #Temp
From
(Select 
 S.ucIIitemstyle COLLATE Latin1_General_CI_AS as [ItemStyleCode]
, Datename(month,p.txdate) COLLATE Latin1_General_CI_AS as Month_Sales
,CAST(MONTH(p.txdate) AS INT)[MonthNo]
,Case  
 when CAST(YEAR(p.txdate) AS VARCHAR(4)) = '2017' Then Sum(P.ActualQuantityInvoiced)
End as 'Year 2017',
Case  
 when CAST(YEAR(p.txdate) AS VARCHAR(4)) = '2018' Then sum(P.ActualQuantityInvoiced)
End as 'Year 2018',
Case  
 when CAST(YEAR(p.txdate) AS VARCHAR(4)) = '2019' Then sum(P.ActualQuantityInvoiced)
End as 'Year 2019'

from [Database].dbo._bvSTTransactionsFull P
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2018-06-01') and (P.TxDate<=@EndDate@)
Group by s.ucIIitemstyle,Datename(month,p.txdate), CAST(YEAR(p.txdate) AS VARCHAR(4)), CAST(MONTH(p.txdate) as INT)

union all

select
S.ucIIitemstyle COLLATE Latin1_General_CI_AS as [ItemStyleCode]
, Datename(month,p.txdate) COLLATE Latin1_General_CI_AS as Month_Sales
,CAST(MONTH(p.txdate) AS INT)[MonthNo]
,Case  
 when CAST(YEAR(p.txdate) AS VARCHAR(4)) = '2017' Then Sum(P.ActualQuantityInvoiced)
End as 'Year 2017',
Case  
 when CAST(YEAR(p.txdate) AS VARCHAR(4)) = '2018' Then sum(P.ActualQuantityInvoiced)
End as 'Year 2018',
Case  
 when CAST(YEAR(p.txdate) AS VARCHAR(4)) = '2019' Then sum(P.ActualQuantityInvoiced)
End as 'Year 2019'

from [Database].dbo._bvSTTransactionsFull P 
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@StartDate@) and (P.TxDate<='2018-05-31')
Group by s.ucIIitemstyle,Datename(month,p.txdate), CAST(YEAR(p.txdate) AS VARCHAR(4)),CAST(MONTH(p.txdate) as INT) ) as T


Select *
Into #Temp1
from

(Select
ItemStyleCode
, [Sales 2017] = SUM([Year 2017])
, [Sales 2018] = SUM([Year 2018])
, [Sales 2019] = SUM([Year 2019])
from #Temp

group by ItemStyleCode) as T1

select 
T1.ItemStyleCode
, ISNULL(T1.[Sales 2017],0) as [Sales 2017]
, ISNULL(T1.[Sales 2018],0) as [Sales 2018]
, ISNULL(T1.[Sales 2019],0) as [Sales 2019]
, S.ulIIClassification as Classification
, [SOH] = SUM(S.Qty_On_Hand)
, [WIP] = SUM(S.QtyOnPO)
, [POT Stock] = (SUM(S.Qty_On_Hand)+SUM(S.QtyOnPO))
, [Ave Consumption 2017] = ISNULL(NULLIF(Round(T1.[Sales 2017]/12,2),0),0)
, [Ave Consumption 2018] = ISNULL(NULLIF(Round(T1.[Sales 2018]/12,2),0),0)
, [Ave Consumption 2019] = ISNULL(NULLIF(Round(T1.[Sales 2019]/CAST(MONTH(@EndDate@) as INT),2),0),0)
, [Ave mnt stock 2018 ave] = ISNULL(Round(NULLIF(SUM(S.Qty_On_Hand)/NULLIF((T1.[Sales 2018]/12),0),0),2),0)
, [Pot ave mnt Stock 2018 Ave] = ISNULL(Round(NULLIF((SUM(S.Qty_On_Hand)+SUM(S.QtyOnPO))/NULLIF((T1.[Sales 2018]/12),0),0),2),0)
, [Ave mnt stock 2019 ave] = ISNULL(Round(NULLIF(SUM(S.Qty_On_Hand)/NULLIF((T1.[Sales 2019]/CAST(MONTH(@EndDate@) as INT)),0),0),2),0)
, [Pot ave mnt Stock 2019 Ave] = ISNULL(Round(NULLIF((SUM(S.Qty_On_Hand)+SUM(S.QtyOnPO))/NULLIF((T1.[Sales 2019]/CAST(MONTH(@EndDate@) as INT)),0),0),2),0)
, [Growth 2018] = Format(ISNULL(Round(NULLIF(((T1.[Sales 2018]/12)-NULLIF((T1.[Sales 2017]/12),0))/NULLIF((T1.[Sales 2017]/12),0),0),2),0),'P')
, [Growth 2019] = Format(ISNULL(Round(NULLIF(((T1.[Sales 2019]/CAST(MONTH(@EndDate@) as INT))-NULLIF((T1.[Sales 2018]/12),0))/NULLIF((T1.[Sales 2018]/12),0),0),2),0),'P') 
from #Temp1 T1 
inner join [Database].dbo.StkItem S on S.ucIIitemstyle = T1.ItemStyleCode
group by ItemStyleCode, [Sales 2017], [Sales 2018], [Sales 2019], ulIIClassification
order by T1.ItemStyleCode



If(OBJECT_ID('tempdb..#temp') Is Not Null)
Begin
    Drop Table #Temp
	Drop Table #Temp1
End
