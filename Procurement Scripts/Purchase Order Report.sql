select *
,OrderNum as SortByField,LineQtyOnHand = case when (bIsWhseItem=1)then WHQtyOnHand else UOMUnit_Qty_On_Hand end
from ICC_NEW.dbo._bvPurchaseOrdersFull
left join ICC_NEW.dbo.WhseStk on iStockCodeID=WHStockLink and iWarehouseID=WhWhseID
where (OrderDate>='2019-06-28') and (OrderDate<='2019-06-28') and ((AutoIndex in (select iInvoiceID from ICC_NEW.dbo._btblInvoiceLines L group by iInvoiceID
having ((sum(fQuantity)=sum(fQtyProcessed)) and (sum(fQtyProcessed)>0)))))
order by SortByField, iInvoiceID, Code