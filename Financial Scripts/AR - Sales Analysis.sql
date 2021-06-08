Declare @StartDate@ date = GETDATE()
Declare @EndDate@ date = GETDATE()

Select 
  min(GroupByField) as GroupByField, Quantity = Sum(Quantity)
, Sales = Sum(LineSales), Cost = Sum(LineCost)
, Profit = Sum(LineSales - LineCost)
, GP = Sum(LineSales - LineCost)/NULLIF(Sum(LineSales),0)
 from ((select GroupByField = C.Name,LineSales = case when P.Debit > 0 then (P.Debit - P.Tax_Amount)  else (P.Credit - P.Tax_Amount) * (-1) end,
LineTax = case when P.Debit > 0 then P.Tax_Amount else P.Tax_Amount *(-1) end,
LineSalesForeign = case when P.fForeignDebit > 0 then (P.fForeignDebit - P.fForeignTax)  else (P.fForeignCredit - P.fForeignTax) * (-1) end,
LineTaxForeign = case when P.fForeignDebit > 0 then P.fForeignTax else P.fForeignTax *(-1) end,
Quantity = case when P.Debit > 0 then 1 else -1 end, UnitCost = 0, LineCost = 0
from [Database].dbo._bvARTransactionsFull P 
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.AccountLink 
LEFT JOIN [Database].dbo.TrCodes TR on TR.IdTrCodes = P.TrCodeID
where (P.Id = 'ARTx') and (TR.bSalesFilter = 1) and (P.TxDate>=@StartDate@) and (P.TxDate<=@EndDate@)

)
UNION ALL
(select GroupByField = C.Name,LineSales = ActualValue,
LineTax = case when P.Credit > 0 then P.Tax_Amount else P.Tax_Amount *(-1) end,
LineSalesForeign = case when P.fForeignCredit > 0 then P.fForeignCredit else P.fForeignDebit * (-1) end,
LineTaxForeign = case when P.fForeignCredit > 0 then P.fForeignTax else P.fForeignTax *(-1) end,
Quantity = P.ActualQuantityInvoiced,  UnitCost = P.Cost, LineCost = (P.Cost * P.ActualQuantityInvoiced)
from .dbo._bvSTTransactionsFull P 
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN [Database].dbo._bvStockFull S on S.StockLink = P.AccountLink 
LEFT JOIN [Database].dbo._btblBINLocation B on B.idBinLocation = S.iBinLocationID 
LEFT JOIN [Database].dbo._bvARAuditLinkedAccRep PAR on PAR.cAuditNumber = P.cAuditNumber 
LEFT JOIN [Database].dbo.TrCodes TR on TR.IdTrCodes = P.TrCodeID
where (P.Id in ('Inv','Crn','OInv','POSI','POSC')) and (S.ItemActive=1) and (TR.bSalesFilter = 1) and (P.TxDate>=@StartDate@) and (P.TxDate<=@EndDate@)

)
UNION ALL
(select GroupByField = C.Name,LineSales = case when P.Credit > 0 then P.Credit else P.Debit *(-1) end,
LineTax = case when P.Credit > 0 then P.Tax_Amount else P.Tax_Amount *(-1) end,
LineSalesForeign = case when P.fForeignCredit > 0 then P.fForeignCredit else P.fForeignDebit * (-1) end,
LineTaxForeign = case when P.fForeignCredit > 0 then P.fForeignTax else P.fForeignTax *(-1) end,
Quantity = case when P.Credit > 0 then (select fQtyProcessed from ICC_NEW.dbo._btblInvoiceLines where idInvoiceLines=iInvLineID) else (select fQtyProcessed from ICC_NEW.dbo._btblInvoiceLines where idInvoiceLines=iInvLineID) * -1 end, UnitCost = 0, LineCost = 0
from [Database].dbo._bvGLTransactionsFull P 
LEFT JOIN [Database].dbo.Accounts A on A.Accountlink = P.AccountLink 
LEFT JOIN [Database].dbo._bvARAccountsFull C on C.DCLink = P.DrCrAccount 
LEFT JOIN [Database].dbo._bvARAuditLinkedAccRep PAR on PAR.cAuditNumber = P.cAuditNumber 
LEFT JOIN [Database].dbo.TrCodes TR on TR.IdTrCodes = P.TrCodeID
where (P.bIsSTGLDocLine = 1) and (P.Id in ('Inv','Crn','OInv','POSI','POSC')) and (TR.bSalesFilter = 1) and (P.TxDate>=@StartDate@) and (P.TxDate<=@EndDate@)

)
) S
Group By GroupByField
