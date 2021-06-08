Declare @DateStart@ date = '2019-01-01'
Declare @DateEnd@ date = '2019-12-31'
select
  S.ucIIitemstyle as Parent_Code
, S.ulIIClassification as Classification
, S.ucIIitemcolour as Colour
, Qty_Outstanding = SUM(P.QtyOutstanding)
, Value = (SUM(P.QtyOutstanding*P.fUnitPriceExcl))
from [Database].dbo._bvSalesOrdersFull P
left join [Database].dbo._bvCMCustomerFull C on C.Customer = P.Account
left join [Database].dbo._bvStockFull S on P.LineItem = S.Code
where C.Customer not in ('ALL030', 'TJO002', 'TOY001') and P.On_Hold = '0'
and P.bCODAccount = '0' and P.DocumentStateDesc in ('Partially Processed', 'Unprocessed', 'Unprocessed and Patrcially')
and P.QtyOutstanding >0
and (P.OrderDate>=@DateStart@) and (P.OrderDate<=@DateEnd@)
and P.WarehouseCode not in ('IN01')
and S.ubIIPlanning = 'TRUE'
and P.ubIDSOrdEmbroideryorder = '0'
and (P.DeliveryDate<GETDATE())
and P.OrderDate<DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)
group by S.ucIIitemstyle, S.ulIIClassification, S.ucIIitemcolour
