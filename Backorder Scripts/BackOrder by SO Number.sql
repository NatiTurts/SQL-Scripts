select so.code[StockCode], so.description_1[StockDescription], so.OrderNum, DueDate, st.Qty_On_Hand,st.ReservedQty,st.QtyOnPO  as 'WIP',
so.QtyOutstanding,(st.Qty_On_Hand -st.ReservedQty)  as 'Available Stock',so.Fquantitylinetotexcl[LineTotalExcl], 
Case when On_Hold = 0 then 'No' else 'Yes' End[On_Hold] 
from[].[dbo]._bvSalesOrdersFull so inner join [].[dbo].[StkItem] st 
on st.StockLink = so.StockLink
where OrderNum = '328122' and DueDate < GETDATE() and (DocFlag in (0, 1)) and((DocState = 1) 
 or((DocState = 3 and IsNull(QtyOutstanding, 0) <> 0)) 
 or((DocType = 9 and DocState = 3 and IsNull(QtyOutstanding, 0) <> 0))) 
Order by AccountID ASC, DueDate ASC
