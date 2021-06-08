Declare @DateStart@ date = '2019-01-09'
Declare @DateEnd@ date = '2019-12-12'

select st.Code AS [Item Code]
, st.Description_1 AS [Item Description]
, [Item Style Code]
, [Parent Description]
, [Classification]
, Case when pst.Quantity = pst.QtyOut then pst.Quantity*(-1) else pst.Quantity*(1) end as Adjustemnt
, pst.Cost as [Unit Cost]
, pst.Debit
, pst.Credit
, TxDate as [Adjustment Date]
from [Database].dbo._bvSTTransactionsFull pst 
INNER JOIN [Database].dbo._bvStockAndWhseItems ST ON pst.AccountLink = st.StockLink and (pst.WarehouseCode=St.WhseCode or isnull(pst.WarehouseCode,'')='') 
LEFT OUTER JOIN [Database].dbo.TRCODES tt ON pst.TrCodeID = tt.idTrCodes
where (ST.ItemActive=1) and (TxDate>=@DateStart@) and (TxDate<=@DateEnd@) and (pst.TrCode in ('ADJ'))

order by st.Code
