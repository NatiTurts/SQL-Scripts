select distinct 
P.OrderNum
, P.Code
, P.ucIIitemstyle
, P.QtyOutstanding
, P.DueDate 
, P.DocumentStateDesc
from ICC_NEW.dbo._bvPurchaseOrdersFull P
where (P.OrderDate >= '2020-01-01') AND (P.OrderDate <= GETDATE()) and P.code not in ('') and P.DocumentStateDesc not in ('Archived') and P.QtyOutstanding>0