Declare @DateStart@ date = '2019-01-01'
Declare @DateEnd@ date 	= GETDATE()
Declare @Parent@ nvarchar(max) ='4022dedw'


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
 S.ucIIitemstyle as Parent
, S.ulIIClassification as  Classification
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


Select
  T.Parent
, T.Classification
, ROUND(T.LineCost,2) as Cost
, ROUND(T.LineSales,2) as Sales
, ROUND(T.Profit,2) as Profit
, WIP = SUM(S.QtyOnPO)
, SOH = SUM(S.Qty_On_Hand)
, Quantity = (T.Quantity)
, Valuation = ROUND(AVG(S.AveUCst)*SUM(S.Qty_On_Hand),2)
, Ave_Selling_Price = ROUND((t.LineSales)/ NULLIF(T.Quantity, 0),2)
, Ave_Cost_Price = ROUND((T.LineCost)/ NULLIF(T.Quantity, 0),2)
, GP = ROUND((T.Profit)/ NULLIF(T.LineSales, 0)*100,2)
from #Temp T
inner join ICC_NEW.dbo.StkItem S on S.ucIIitemstyle = T.Parent
where T.Parent = @Parent@
group by T.Parent, T.Classification, T.Quantity, T.LineCost, T.LineSales, T.Profit

If(OBJECT_ID('tempdb..#temp') Is Not Null)
Begin
    Drop Table #Temp
End



