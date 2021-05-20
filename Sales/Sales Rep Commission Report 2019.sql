Declare @DateStart@ Date = '2018-09-01'
Declare @DateEnd@ Date = '2018-09-30'
select SRCode as RepSort,* into #RepHashTemp from [ICC_NEW].[dbo]._bvRepTransactionsFull where (ARTxDate>=@DateStart@) and (ARTxDate<@DateEnd@) order by RepSort, ARTxReference Select  RepSort, ARTxReference, SRidSalesRep,SRCode,SRName,SRMethod,SREntity,SRRep_On_Hold,ARTxDate,ARTxID,ARTxCustomerID,ARTxCodeID,ARTxDebit,ARTxCredit,ARTxTaxAmount,ARTxDescription ,ARTxOrderNo,ARTxAuditNo,
 ARTxAllocRecID,ARTxCode,ProjectCode,ActiveProject,Customer,CustomerName,CustomerGroup,  CustomerGroupDesc,CustomerArea,CustomerAreaDescr,TmpAllocAmt,TmpStockAllocAmtExc,TmpStockCost
 ,ARTxProfit=Sum(LineTxProfit),ARTxTurnover=Sum(LineTxTurnover)
 ,ARTxPaid=Sum(TmpAllocAmt), 
AllocAmtTurnover=case TmpStockAllocAmtExc when 0 then 
  case ARTxDebit when 0 then case ARTxCredit when 0 then 0 
  else Round((TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end) ))),2) end 
  else Round((TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxDebit-ARTxTaxAmount)= 0 then 1 else (ARTxDebit-ARTxTaxAmount) end) ))),2) end 
  else TmpStockAllocAmtExc end, 
AllocAmtProfit= case TmpStockAllocAmtExc-TmpStockCost when 0 then 
  case ARTxDebit when 0 then case ARTxCredit when 0 then 0 
  else Round(TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end)  ))- 
       ((Sum(LineTxCost*LineTxQty))/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end)* 
        (TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxCredit-ARTxTaxAmount)= 0 then 1 else (ARTxCredit-ARTxTaxAmount) end)  )))),2) end 
  else Round(TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) ))- 
       ((Sum(LineTxCost*LineTxQty))/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) * 
        (TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) )))),2) end 
  else TmpStockAllocAmtExc-TmpStockCost end,
AllocAmtExcl= case TmpStockAllocAmtExc when 0 then 
  case ARTxDebit when 0 then case ARTxCredit when 0 then 0 
  else Round(TmpAllocAmt/ARTxCredit*(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end),2) end 
  else Round(TmpAllocAmt/ARTxDebit*(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) ,2) end 
  else TmpStockAllocAmtExc end, 
RepCommOnAllocTO= case Sum(LineTxTurnover) when 0 then 0 
  else case TmpStockAllocAmtExc when 0
  then case ARTxDebit when 0 then case ARTxCredit when 0 then 0 
  else Round((TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end) )))/ 
        (case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end) * (Sum(LineTxTurnover)),2) end 
  else Round((TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) )))/ 
       (case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) * (Sum(LineTxTurnover)),2) end 
  else TmpStockAllocAmtExc end end,
RepCommOnAllocPR= case Sum(LineTxProfit) when 0 then 0 
  else case TmpStockAllocAmtExc when 0 
  then case ARTxDebit when 0 then case ARTxCredit when 0 then 0 
  else Round(((TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end) )))- 
        ((Sum(LineTxCost*LineTxQty))/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end) * 
        (TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxCredit-ARTxTaxAmount)=0 then 1 else (ARTxCredit-ARTxTaxAmount) end) )))))/ 
        (ARTxCredit-ARTxTaxAmount - (Sum(LineTxCost*LineTxQty))) * (Sum(LineTxProfit)),2) end 
  else Round(((TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) )))- 
        ((Sum(LineTxCost*LineTxQty))/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) * 
        (TmpAllocAmt/(1+(ARTxTaxAmount/(case when (ARTxDebit-ARTxTaxAmount)=0 then 1 else (ARTxDebit-ARTxTaxAmount) end) )))))/ 
        (ARTxDebit-ARTxTaxAmount - (Sum(LineTxCost*LineTxQty))) * (Sum(LineTxProfit)),2) end 
  else  TmpStockAllocAmtExc - TmpStockCost  end end 
  From #RepHashTemp Group By  RepSort, ARTxReference, SRidSalesRep,SRCode,SRName,SRMethod,SREntity,SRRep_On_Hold,ARTxDate,ARTxID,ARTxCustomerID,ARTxCodeID,ARTxDebit,ARTxCredit,ARTxTaxAmount,ARTxDescription ,ARTxOrderNo,ARTxAuditNo,
 ARTxAllocRecID,ARTxCode,ProjectCode,ActiveProject,Customer,CustomerName,CustomerGroup,  CustomerGroupDesc,CustomerArea,CustomerAreaDescr,TmpAllocAmt,TmpStockAllocAmtExc,TmpStockCost
 order by RepSort, ARTxReference

 Drop Table #RepHashTemp