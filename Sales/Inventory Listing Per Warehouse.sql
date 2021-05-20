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
, Case when M.Name = 'ICC Finished Goods' then '1'
       when M.Name = 'G4 Finished Goods' then '2'
	   when M.Name = 'H9 Goods' then '3'
	   when M.Name = 'WORKWEAR FACTORY SHOP' then '4'
	   when M.Name = 'Backorder Warehouse' then '5'
	   when M.Name = 'Promotion Warehouse' then '6'
end as WarehouseSort
from iCC_NEW.dbo.WhseStk W
left join ICC_NEw.dbo.StkItem S on S.StockLink = W.WHStockLink
left join ICC_NEW.dbo.WhseMst M on M.WhseLink = W.WHWhseID
where S.ulIIClassification NOT IN ('Raw Materials') AND S.Code NOT IN ('2')
and M.Name in ('ICC Finished Goods','WORKWEAR FACTORY SHOP','G4 Finished Goods','Promotion Warehouse','H9 Goods','Backorder Warehouse')
