select Account[CustomerCode], Name[CustomerName],code[StockCode], description_1[StockDescription], OrderNum, OrderDate, DueDate,Qty_On_Hand, QtyOnPO, QtyOnSO,WarehouseCode, fQuantity[OrderQty],fQtyReserved[ReservedQty],fqtyprocessed[ConfirmedQty],QtyOutstanding[OutstandingQty], funitcost[UnitCost],funitpriceexcl[UnitPriceExcl],Fquantitylinetotexcl[LineTotalExcl]
from _bvSalesOrdersFull 
where  (DocFlag in (0, 1)) and ((DocState = 1) or ((DocState=3 and IsNull(QtyOutstanding,0)<>0)) or ((DocType = 9 and DocState=3 and IsNull(QtyOutstanding,0)<>0)))