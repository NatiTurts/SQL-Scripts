select
 P.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, S.ulIIClassification COLLATE Latin1_General_CI_AS as Classification
, Datename(month,p.InvDate) COLLATE Latin1_General_CI_AS as Month
, CAST(YEAR(p.InvDate) AS VARCHAR(4))[Year]
, CAST(MONTH(p.InvDate) AS VARCHAR(4))[MonthNo]
, Qty_Ordered = SUM(P.fQuantity)
, Qty_Processed = SUM(P.fQtyLastProcess)
, Value_Local = SUM(P.fQuantityLineTotIncl)
from ICC_NEW.DBO._bvStockFull S
Left Join ICC_NEW.dbo._bvPurchaseOrdersFull p on P.Code = S.Code
where (P.InvDate>='2018-06-01') and (P.InvDate<='2019-12-31') and S.ulIIClassification = 'Manufacturing'
group by p.code, s.Description_1, s.ulIIClassification, CAST(YEAR(p.InvDate) AS VARCHAR(4)), Datename(month,p.InvDate), CAST(MONTH(p.InvDate) AS VARCHAR(4))


union all

select
 P.Code COLLATE Latin1_General_CI_AS as ItemCode
, S.Description_1 COLLATE Latin1_General_CI_AS as ItemDescription
, S.ulIIClassification COLLATE Latin1_General_CI_AS as Classification
, Datename(month,p.InvDate) COLLATE Latin1_General_CI_AS as Month
, CAST(YEAR(p.InvDate) AS VARCHAR(4))[Year]
, CAST(MONTH(p.InvDate) AS VARCHAR(4))[MonthNo]
, Qty_Ordered = SUM(P.fQuantity)
, Qty_Processed = SUM(P.fQtyLastProcess)
, Value_Local = SUM(P.fQuantityLineTotIncl)
from The_Industrial_Clothing_Company.DBO._bvStockFull S
Left Join The_Industrial_Clothing_Company.dbo._bvPurchaseOrdersFull p on P.Code = S.Code
where (P.InvDate>='2016-01-01') and (P.InvDate<='2018-05-31') and S.ulIIClassification = 'Manufacturing'
group by p.code, s.Description_1, s.ulIIClassification, CAST(YEAR(p.InvDate) AS VARCHAR(4)), Datename(month,p.InvDate), CAST(MONTH(p.InvDate) AS VARCHAR(4))
