Declare @DateStart@ date = '2019-01-01'
Declare @DateEnd@ date 	= '2019-07-30'


Create table #Temp
(
	
	Parent varchar(max),
	Classification varchar(max),
	Quantity float,
	LineCost float,
	LineSales float,
	Profit float,
)

Insert Into #Temp

select 
 S.ucIIitemstyle COLLATE Latin1_General_CI_AS as Parent
, S.ulIIClassification COLLATE Latin1_General_CI_AS as  Classification
, Quantity = sum(P.ActualQuantityInvoiced)
, LineCost = sum((P.Cost * P.ActualQuantityInvoiced))
, LineSales = sum(ActualValue)
, Profit = sum(ActualValue)-sum((P.Cost * P.ActualQuantityInvoiced))
from ICC_NEW.dbo._bvSTTransactionsFull P
LEFT JOIN ICC_NEW.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN ICC_NEW.dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN ICC_NEW.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@DateStart@) and (P.TxDate<=@DateEnd@)
Group by s.ucIIitemstyle, S.ulIIClassification


union all

select 
 S.ucIIitemstyle COLLATE Latin1_General_CI_AS as Parent
, S.ulIIClassification COLLATE Latin1_General_CI_AS as  Classification
, Quantity = sum(P.ActualQuantityInvoiced)
, LineCost = sum((P.Cost * P.ActualQuantityInvoiced))
, LineSales = sum(ActualValue)
, Profit = sum(ActualValue)-sum((P.Cost * P.ActualQuantityInvoiced))
from The_Industrial_Clothing_Company.dbo._bvSTTransactionsFull P
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvCMCustomerFull D on D.Customer = C.Account
LEFT JOIN The_Industrial_Clothing_Company.dbo._bvStockFull S on S.StockLink = P.AccountLink 
where (P.Id in ('Inv','Crn','OInv','POSI','POSC'))  and  (P.TxDate>=@DateStart@) and (P.TxDate<=@DateEnd@)
Group by s.ucIIitemstyle, S.ulIIClassification

Select
  T.Parent
, T.Classification
, ROUND(T.LineCost,2) as LineCost
, ROUND(T.LineSales,2) as Sales
, ROUND(T.Profit,2) as Profit
, WIP = SUM(S.QtyOnPO)
, SOH = SUM(S.Qty_On_Hand)
, Quantity = (T.Quantity)
, Valuation = ROUND(AVG(S.AveUCst)*SUM(S.Qty_On_Hand),2)
, Ave_Selling_Price = ROUND((t.LineSales)/ NULLIF(T.Quantity, 0),2)
, Ave_Cost_Price = ROUND((T.LineCost)/ NULLIF(T.Quantity, 0),2)
, GP = ROUND((T.Profit)/ NULLIF(T.LineSales, 0),2)
from #Temp T
inner join ICC_NEW.dbo.StkItem S on S.ucIIitemstyle = T.Parent
group by T.Parent, T.Classification, T.Quantity, T.LineCost, T.LineSales, T.Profit

If(OBJECT_ID('tempdb..#temp') Is Not Null)
Begin
    Drop Table #Temp
End



