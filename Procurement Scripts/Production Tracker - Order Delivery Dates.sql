select S.Code as Code
, S.Description_1 as Description
, S.Qty_On_Hand as SOH
, sum(P.QtyOutstanding) as WIP
, H.PO_Number as PO_Num
, H.Production_DeliveryDate as Delivery_date
, H.Production_Stage as Stage
, H.Sage_DocStatus as Status
from [Database].dbo.StkItem S
inner join [Database].dbo._bvPurchaseOrdersFull P on P.Code = S.Code
inner join [Database].dbo.ProductionTracker_Header H on H.PO_Number = P.OrderNum
where p.DocumentStateDesc not in ('Template') and H.Production_Stage not in ('&nbsp;')
group by S.Code, s.Description_1, S.Qty_On_Hand, H.PO_Number, H.Production_DeliveryDate, H.Production_Stage, H.Sage_DocStatus
