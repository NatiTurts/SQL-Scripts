Select P.ItemStyleCode
, ISNULL(P.[2020],0) as [2020]
, T.ulIIClassification as [Classification]
, SUM(T.Qty_On_Hand) as SOH
, SUM(T.QtyOnPO) as WIP
--WIPS
--Reserved
-- work on 12 month range for getdate()
, Case when ((P.[2020]/12)*3)>= SUM(T.Qty_On_Hand) then 'Under' else 'Safe' end as [Test]
, SUM(T.Qty_On_Hand) + SUM(T.QtyOnPO) as [Potential Stock]
, ISNULL(NULLIF(Round(P.[2020]/(CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)) as INT)),2),0),0) as [Ave Consumption 2020]
, [Ave mnt stock 2020 ave] = ISNULL(Round(NULLIF(SUM(T.Qty_On_Hand)/NULLIF((P.[2020]/CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)) as INT)),0),0),2),0)
, [Pot ave mnt Stock 2020 Ave] = ISNULL(Round(NULLIF((SUM(T.Qty_On_Hand)+SUM(T.QtyOnPO))/NULLIF((P.[2020]/CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)) as INT)),0),0),2),0)
, [Growth 2020] = ISNULL(Round(NULLIF(((P.[2020]/CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)) as INT))-NULLIF((P.[2019]/12),0))/NULLIF((P.[2019]/12),0),0),2),0) 
from 
		(
		Select
		 S.ucIIitemstyle COLLATE Latin1_General_CI_AS as [ItemStyleCode]
		, Sum(P.ActualQuantityInvoiced) as Qty
		, CAST(YEAR(p.txdate) AS VARCHAR(4)) as [Year]
		from [Database].dbo._bvSTTransactionsFull P
		LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
		where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>='2020-01-01') and (P.TxDate<='2020-12-31')
		Group by s.ucIIitemstyle, CAST(YEAR(p.txdate) AS VARCHAR(4))

) T

PIVOT(
    sum(T.Qty)
		FOR [Year] 
		IN(
			[2019],
			[2020])
) as P

inner join [Database].dbo.StkItem T on T.ucIIitemstyle = P.ItemStyleCode 
group by P.ItemStyleCode, P.[2019], P.[2020], T.ulIIClassification;