select distinct po.AccountID,po.Account[SupplierCode], po.Name[SupplierName],
Case when isnull(po.code,'') = '' then 'GL' else 'ST' end[LineType],po.cDescription[LineDescription],
po.OrderNum,CONVERT(date,po.DueDate) as 'Expected Date',po.Qty_On_Hand, po.QtyOnSO,st.ReservedQty,po.QtyOutstanding[PO Qty], 
po.Description[Doc_Description]
from [ICC_NEW].[dbo]._bvPurchaseOrdersFull po left join[ICC_NEW].[dbo].[StkItem] st on  po.StockLink = st.StockLink 
where po.LineItem like '%3333blpc%' and ((po.DocState = 1) or ((po.DocState=3 and IsNull(po.QtyOutstanding,0)<>0)) 
or ((po.DocType = 9 and po.DocState=3 and IsNull(po.QtyOutstanding,0)<>0)))
Order by po.AccountID ASC, CONVERT(date,po.DueDate) ASC,po.cDescription ASC