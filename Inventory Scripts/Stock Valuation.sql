select
S.Code as [Item Code]
, S.Description_1 as [Item Description]
, S.Qty_On_Hand as [SOH]
, S.AveUCst as [Average Cost]
, S.fItemLastGRVCost as [Last GRV Cost]
, [Weighted Value] =  Round((S.Qty_On_Hand*S.AveUCst),2)
, [Latest GRV Average] = Round((S.Qty_On_Hand*S.fItemLastGRVCost),2)
from [Database].dbo.StkItem S
order by S.Code