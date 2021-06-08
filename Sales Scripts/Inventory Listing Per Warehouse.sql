select 
 S.Code as [Item Code]
, S.Description_1 as [Description]
, S.ucIIitemstyle as [Parent Code]
, S.ucIIitemcolour as [Item Colour]
, S.ulIIClassification as [Classification]
, S.ItemGroup as [Item Group]
, S.ucIIitemsize as [Item Size]
, W.WHQtyOnHand as SOH
, W.WHQtyOnPO as [WIP]
, W.WHQtyOnSO as [Committed]
, (W.WHQtyOnHand - W.WHQtyReserved) as [Qty Available]
, M.Name as [Warehouse]
, WarehouseSort
from [Database].dbo.WhseStk W
left join [Database].dbo.StkItem S on S.StockLink = W.WHStockLink
left join [Database].dbo.WhseMst M on M.WhseLink = W.WHWhseID
where S.ulIIClassification NOT IN ('Raw Materials') AND S.Code NOT IN ('2')