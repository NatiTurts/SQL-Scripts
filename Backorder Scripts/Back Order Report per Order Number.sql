Declare @DateStart@ date = '2019-01-01'
Declare @DateEnd@ date 	= '2019-12-31'
select
 P.OrderNum as Order_Number
, P.RepName as Rep
, P.OrderDate as Order_Date
, P.DeliveryDate as Delivery_Date
, P.ulARInternalrep1 as Internal_Rep
, P.Account as Customer
, C.CustomerName as Customer_Name
, Qty_Outstanding = SUM(P.QtyOutstanding)
, Value = (SUM(P.QtyOutstanding*P.fUnitPriceExcl))
, Datename(month,p.OrderDate) as Month
, CAST(MONTH(p.OrderDate) AS VARCHAR(4))[MonthNo]
, CAST(YEAR(p.OrderDate) AS VARCHAR(4))[Year]
from ICC_NEW.dbo._bvSalesOrdersFull P
left join ICC_NEW.dbo._bvCMCustomerFull C on C.Customer = P.Account
where C.Customer not in ('ALL030', 'TJO002', 'TOY001')
and P.On_Hold = '0' and P.bCODAccount = '0' and P.DocumentStateDesc in ('Partially Processed', 'Unprocessed', 'Unprocessed and Patrcially')
and P.QtyOutstanding >0 and  (P.OrderDate>=@DateStart@) and (P.OrderDate<=@DateEnd@)
and P.WarehouseCode not in ('IN01')
and P.ubIIPlanning = 'TRUE'
and P.ubIDSOrdEmbroideryorder = '0'
and (P.DeliveryDate<GETDATE())
and P.OrderDate<DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)
group by P.OrderNum, P.RepName, P.OrderDate, P.DeliveryDate, P.ulARInternalrep1, P.Account, C.CustomerName
