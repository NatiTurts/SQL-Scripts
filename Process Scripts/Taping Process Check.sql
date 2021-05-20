select
S.Code
, T.OrderNum as [Order Number]
, T.Account as [Customer Code]
, T.ulIDSOrdSalesRep as [Internal Sales]
, T.fQuantity as[Order Quantity]
, S.Qty_On_Hand as SOH
, S.QtyOnPO as WIP
, S.QtyOnSO as Committed
from ICC_NEW.dbo._bvSalesOrdersFull AS T
LEFT OUTER JOIN ICC_NEW.dbo._bvStockFull AS S ON S.StockLink = T.StockLink 
where S.ItemGroup = 'EM01'
order by S.Code