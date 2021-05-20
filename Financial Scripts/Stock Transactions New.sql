select  'NEW_DB'[Type]	
, (Acc.Master_Sub_Account + IsNull(' ('+Acc.Description+')', '')) 	COLLATE Latin1_General_CI_AS as AccDesc
, Acc.AccountTypeDescription  	COLLATE Latin1_General_CI_AS as GroupByField
, Acc.Account 	COLLATE Latin1_General_CI_AS as [GLAccount]
, datename(month, Stt.TxDate) + '-' + datename(year, Stt.TxDate) 	COLLATE Latin1_General_CI_AS as PeriodMonth
, Stt.TxDate as	[TxDate]
, STT.Debit AS	[Debit]
, STT.Credit AS	[Credit]
, Stt.Description	COLLATE Latin1_General_CI_AS as	[TransactionDescription]
, Stt.Reference	COLLATE Latin1_General_CI_AS as	[Reference]
, STT.Order_No	COLLATE Latin1_General_CI_AS as	[OrderNumber]
, STT.ExtOrderNum	COLLATE Latin1_General_CI_AS as	[ExternalOrderNumber]
, Stt.Tax_Amount as	[TaxAmount]
, STT.Project as	[Project]
, STT.DrCrAccount as	[DebitCreditAccount]
, STT.DTStamp as	[DateStamp]
, Stt.UserName COLLATE Latin1_General_CI_AS as	[UserName]
, STT.cReference2	COLLATE Latin1_General_CI_AS as	[Reference2]
, STT.ProjectCode	COLLATE Latin1_General_CI_AS as	[ProjectCode]
, STT.ProjectName	COLLATE Latin1_General_CI_AS as	[ProjectName]
, STT.TrCode	COLLATE Latin1_General_CI_AS as	[TransactionCode]
, STT.TaxCode	COLLATE Latin1_General_CI_AS as	[TaxCode]
, STT.Module	COLLATE Latin1_General_CI_AS as	[Module]
, STT.Account 	COLLATE Latin1_General_CI_AS as [CustomerAccount]
, Cl.Name	COLLATE Latin1_General_CI_AS as [CustomerName]
, STT.RepCode	COLLATE Latin1_General_CI_AS as [RepCode]
, STT.RepName	COLLATE Latin1_General_CI_AS as [RepName]
, (Stt.Credit- STT.Debit) as [DebitMinCredit]	
, DebitCredit = case when Acc.iAccountType = 1 then 'D' else 'C' end	COLLATE Latin1_General_CI_AS 
, st.Code COLLATE Latin1_General_CI_AS	as [StockCode]
, stt.Description  COLLATE Latin1_General_CI_AS as [StockDescription]
, st.ItemGroup COLLATE Latin1_General_CI_AS as [StockGroup]
, stt.Quantity  as [StockQty]
, stt.Cost as [StockCost]
, ((stt.Credit- stt.Debit)/stt.Quantity) as [Stock_UnitPrice]
, STT.Profit as [StockProfit]
, stt.ProfitPerc as [StockProfit%]
, st.ucIIitemstyle COLLATE Latin1_General_CI_AS as [StockItemStyle]
, st.ucIIitemsize COLLATE Latin1_General_CI_AS as [StockItemSize]
, st.ucIIitemfabric COLLATE Latin1_General_CI_AS as [StockItemFabric]
, st.ucIIitemcolour COLLATE Latin1_General_CI_AS as [StockItemColour], ar.id COLLATE Latin1_General_CI_AS as [id]
from [icc_new].[dbo].[_bvgltransactionsfull] ar 
inner join [icc_new].[dbo].[_evGLAccountsFull] acc on acc.accountlink  = ar.accountlink 
inner join [icc_new].[dbo].[_bvsttransactionsfull] stt on stt.cauditnumber COLLATE Latin1_General_CI_AS = ar.cauditnumber COLLATE Latin1_General_CI_AS
inner join [icc_new].[dbo].[stkitem] st on st.stocklink  = stt.accountlink 
inner join [icc_new].[dbo].[GrpTbl] gr on gr.stgroup COLLATE Latin1_General_CI_AS = st.itemgroup COLLATE Latin1_General_CI_AS and gr.SalesAccLink  = ar.AccountLink 
inner join [icc_new].[dbo].[Client] Cl on cl.account COLLATE Latin1_General_CI_AS = stt.account COLLATE Latin1_General_CI_AS
where ar.txdate >= '2018-01-01' and ar.txdate <= '2018-12-31' and ar.id in ('Inv','Crn','OInv','POSI','POSC')

Union All

select  'OLD_DB'[Type]	
, (Acc.Master_Sub_Account + IsNull(' ('+Acc.Description+')', '')) 	COLLATE Latin1_General_CI_AS as AccDesc
, Acc.AccountTypeDescription  	COLLATE Latin1_General_CI_AS as GroupByField
, Acc.Account 	COLLATE Latin1_General_CI_AS as [GLAccount]
, datename(month, Stt.TxDate) + '-' + datename(year, Stt.TxDate) 	COLLATE Latin1_General_CI_AS as PeriodMonth
, Stt.TxDate as	[TxDate]
, STT.Debit AS	[Debit]
, STT.Credit AS	[Credit]
, Stt.Description	COLLATE Latin1_General_CI_AS as	[TransactionDescription]
, Stt.Reference	COLLATE Latin1_General_CI_AS as	[Reference]
, STT.Order_No	COLLATE Latin1_General_CI_AS as	[OrderNumber]
, STT.ExtOrderNum	COLLATE Latin1_General_CI_AS as	[ExternalOrderNumber]
, Stt.Tax_Amount as	[TaxAmount]
, STT.Project as	[Project]
, STT.DrCrAccount as	[DebitCreditAccount]
, STT.DTStamp as	[DateStamp]
, Stt.UserName COLLATE Latin1_General_CI_AS as	[UserName]
, STT.cReference2	COLLATE Latin1_General_CI_AS as	[Reference2]
, STT.ProjectCode	COLLATE Latin1_General_CI_AS as	[ProjectCode]
, STT.ProjectName	COLLATE Latin1_General_CI_AS as	[ProjectName]
, STT.TrCode	COLLATE Latin1_General_CI_AS as	[TransactionCode]
, STT.TaxCode	COLLATE Latin1_General_CI_AS as	[TaxCode]
, STT.Module	COLLATE Latin1_General_CI_AS as	[Module]
, STT.Account 	COLLATE Latin1_General_CI_AS as [CustomerAccount]
, Cl.Name	COLLATE Latin1_General_CI_AS as [CustomerName]
, STT.RepCode	COLLATE Latin1_General_CI_AS as [RepCode]
, STT.RepName	COLLATE Latin1_General_CI_AS as [RepName]
, (Stt.Credit- STT.Debit) as [DebitMinCredit]	
, DebitCredit = case when Acc.iAccountType = 1 then 'D' else 'C' end	COLLATE Latin1_General_CI_AS 
, st.Code COLLATE Latin1_General_CI_AS	as [StockCode]
, stt.Description  COLLATE Latin1_General_CI_AS as [StockDescription]
, st.ItemGroup COLLATE Latin1_General_CI_AS as [StockGroup]
, stt.Quantity  as [StockQty]
, stt.Cost as [StockCost]
, ((stt.Credit- stt.Debit)/stt.Quantity) as [Stock_UnitPrice]
, STT.Profit as [StockProfit]
, stt.ProfitPerc as [StockProfit%]
, st.ucIIitemstyle COLLATE Latin1_General_CI_AS as [StockItemStyle]
, st.ucIIitemsize COLLATE Latin1_General_CI_AS as [StockItemSize]
, st.ucIIitemfabric COLLATE Latin1_General_CI_AS as [StockItemFabric]
, st.ucIIitemcolour COLLATE Latin1_General_CI_AS as [StockItemColour], ar.id COLLATE Latin1_General_CI_AS as [id]
from [The_Industrial_Clothing_Company].[dbo].[_bvgltransactionsfull] ar
inner join [The_Industrial_Clothing_Company].[dbo].[_evGLAccountsFull] acc on acc.accountlink  = ar.accountlink  
inner join [The_Industrial_Clothing_Company].[dbo].[_bvsttransactionsfull] stt on stt.cauditnumber COLLATE Latin1_General_CI_AS = ar.cauditnumber COLLATE Latin1_General_CI_AS
inner join [The_Industrial_Clothing_Company].[dbo].[stkitem] st on st.stocklink  = stt.accountlink 
inner join [The_Industrial_Clothing_Company].[dbo].[GrpTbl] gr on gr.stgroup COLLATE Latin1_General_CI_AS = st.itemgroup COLLATE Latin1_General_CI_AS and gr.SalesAccLink = ar.AccountLink 
inner join [The_Industrial_Clothing_Company].[dbo].[Client] Cl on cl.account COLLATE Latin1_General_CI_AS = stt.account COLLATE Latin1_General_CI_AS
where ar.txdate >= '2018-01-01' and ar.txdate <= '2018-12-31'  and ar.id in ('Inv','Crn','OInv','POSI','POSC')
