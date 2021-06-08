select distinct
P.OrderNum
, P.OrderDate
, P.Account
, case when H.PO_Number = P.OrderNum then 'Uploaded' else 'No Uploaded' end as [Upload Check]
, P.DocumentStateDesc
from [Database].dbo._bvPurchaseOrdersFull P
Left join [Database].dbo.ProductionTracker_Header H on H.PO_Number = P.OrderNum
where P.OrderNum not like '%*%' and P.Account = 'PAR002' and P.OrderDate >= '2019-01-01'
order by P.OrderDate
