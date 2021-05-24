select 
S.code as [Code]
, W.Code
, S.Description_1 as [Description]
, S.ucIIitemstyle as [Parent Code]
, S.ulIIClassification as [Classification]
, S.ItemGroup	as [Item Group]
, S.ucIIitemcolour as [Colour]
, S.ucIIitemsize as [Size]
, [Qty Available] = SUM(W.WHQtyOnHand) - SUM(W.WHQtyReserved)
, SUM(W.WHQtyReserved) as [Qty on SO]
, SUM(W.WHQtyOnPO) as [Qty on PO]
from ICC_NEW.dbo._bvStockFull S
inner join ICC_NEW.dbo._bvWarehouseStockFull W on W.WHStockLink = S.StockLink
where W.WhCode in ('FGS01', 'FGSG4', 'FGSH9', 'WFS01')
group by W.Code, S.code, S.Description_1, S.ucIIitemstyle, S.ulIIClassification, S.ItemGroup, S.ucIIitemcolour, S.ucIIitemsize
order by S.Code
