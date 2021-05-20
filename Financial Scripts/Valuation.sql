select GroupByField = IsNull(ST.ItemGroup, '(None)'),GroupByFieldDesc = min(IsNull(ST.ItemGroupDescription, '(None)')),LineValue = Sum(ST.ItemCost * ST.QtyInStock)
from _bvStockAndWhseItems ST
where ((ST.ItemActive=1)) and (ST.ServiceItem<>1)
group by ST.ItemGroup