select ST.*,GroupByField = IsNull(ST.ItemGroup, ''),GroupByFieldCode = IsNull(ST.ItemGroup, ''),GroupByFieldDesc = IsNull(ST.ItemGroupDescription, '(None)'),SecondGroupByField = '',SecondGroupByFieldCode = '',SecondGroupByFieldDesc = '(None)',LineValue = ST.ItemCost * ST.QtyInStock,UnitCost = ST.ItemCost,QtyBalance = ST.QtyInStockExclLots + IsNull( (select case when ST.ServiceItem = 0 then IsNull(sum (QtyOut),0) else 0 end from _bvSTTransactionsFull where (AccountLink=ST.StockLink) and (IsNull(WarehouseID,0)=IsNull(ST.iWarehouseID,0))  and TxDate>'2020-03-31') - (select case when ST.ServiceItem = 0 then IsNull(sum (QtyIn), 0) else 0 end from _bvSTTransactionsFull where (AccountLink=ST.StockLink) and (IsNull(WarehouseID,0)=IsNull(ST.iWarehouseID,0))  and TxDate>'2020-03-31'), 0)
from _evInvCostTracking ST join (select iStockID as LastStockID, iWarehouseID as LastWarehouseID,  MAX(dTxDate) as LastTxDate
from _etblInvCostTracking where (dTxDate<'2020-04-01') 
group by iStockID, iWarehouseID ) CT on ST.StockLink = CT.LastStockID and ST.iWarehouseID = CT.LastWarehouseID  and ST.dTxDate = CT.LastTxDate Left outer join StkItem S on S.StockLink = ST.StockLink
where ((((ST.Whseitem = 0) or ((ST.Whseitem = 1) and (ST.iWarehouseID > 0)))) and (ST.ItemActive=1)) and (ST.ServiceItem<>1)

order by ST.ItemGroup, ST.Code
