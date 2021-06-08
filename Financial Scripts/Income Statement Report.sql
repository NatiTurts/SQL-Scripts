Declare @DateStart@ date 	= '2018-01-01'
 Declare @DateEnd@ date 	= '2018-08-31'

select 'Old'[DB],

  t.AutoIdx		
, (F.Master_Sub_Account + IsNull(' ('+F.Description+')', '')) 	COLLATE Latin1_General_CI_AS				as AccDesc
, F.AccountTypeDescription  	COLLATE Latin1_General_CI_AS												as GroupByField
, F.AccountLink																								as	[AccountLink]
, F.Account 	COLLATE Latin1_General_CI_AS																as [GLAccount]
, datename(month, P.dPeriodDate) + '-' + datename(year, P.dPeriodDate) 	COLLATE Latin1_General_CI_AS		as PeriodMonth
, T.TxDate																									as	[TxDate]
, T.Debit																									AS	[DEBITTOTALPERREFERENCE]
, T.Credit																									AS	[CREDITTOTALPERREFERENCE]
, T.fForeignDebit																							as	[ForeignDebit]	
, T.fForeignCredit																							as	[ForeignCredit]
, T.Description	COLLATE Latin1_General_CI_AS																as	[GLTransactionDescription]
, T.Reference	COLLATE Latin1_General_CI_AS																as	[GLReference]
, T.Order_No	COLLATE Latin1_General_CI_AS																as	[GLOrderNumber]
, T.ExtOrderNum	COLLATE Latin1_General_CI_AS																as	[GLExternalOrderNumber]
, T.Tax_Amount																								as	[TaxAmount]
, T.fForeignTax																								as [ForeignTax]
, T.Project																									as	[Project]
, T.Period																									as	[PeriodGL]
, T.DrCrAccount																								as	[DebitCreditAccount]
, T.DTStamp																									as	[DateStamp]
, T.UserName	COLLATE Latin1_General_CI_AS																as	[UserName]
, T.cReference2	COLLATE Latin1_General_CI_AS																as	[Reference2]
, T.ProjectCode	COLLATE Latin1_General_CI_AS																as	[ProjectCode]
, T.ProjectName	COLLATE Latin1_General_CI_AS																as	[ProjectName]
, T.ActiveProject																							as	[ProjectActive]
, T.ProjectDescription	COLLATE Latin1_General_CI_AS														as	[ProjectDescription]
, T.JobCode	COLLATE Latin1_General_CI_AS																	as	[JobCode]
, T.TrCode	COLLATE Latin1_General_CI_AS																	as	[TransactionCode]
, T.TaxCode	COLLATE Latin1_General_CI_AS																	as	[TaxCode]
, T.Module	COLLATE Latin1_General_CI_AS																	as	[Module]
, T.Account 	COLLATE Latin1_General_CI_AS																as [CustomerAccount]
, T.AccountDesc	COLLATE Latin1_General_CI_AS																as [GLAccountDescription]
, T.ContraAccount	COLLATE Latin1_General_CI_AS															as [ContraAccount]
, T.ContraAccountDesc	COLLATE Latin1_General_CI_AS														as [ContraAccountDescription]
, T.CurrencyCode	COLLATE Latin1_General_CI_AS															as [CurrencyCode]
, T.CurrencyDescription	COLLATE Latin1_General_CI_AS														as [CurrencyDescription]
, T.CurrencySymbol	COLLATE Latin1_General_CI_AS															as [CurrencySymbol]
, T.RepCode	COLLATE Latin1_General_CI_AS																	as [RepCode]
, T.RepName	COLLATE Latin1_General_CI_AS																	as [RepName]
, T.GLTaxAccount	COLLATE Latin1_General_CI_AS															as [GLTaxAccount]
, T.TxBranchCode	COLLATE Latin1_General_CI_AS															as	[BranchCode]	
, (T.Credit- T.Debit)																						as [DebitMinCredit]	
, T.TxBranchDescription	COLLATE Latin1_General_CI_AS														as [BranchDescription]
, DebitCredit = case when F.iAccountType = 1 then 'D' else 'C' end	COLLATE Latin1_General_CI_AS 

from  
[Database].[dbo].[_evGLAccountsFull]  	F
left outer join [Database].[dbo].[_bvGLTransactionsFull] T on F.AccountLink = T.AccountLink  
left outer join [Database].[dbo].[_etblPeriod] P on P.idPeriod = T.Period  
left join [Database].[dbo].[Project] Pr on Pr.ProjectLink = T.Project

 
where  F.AccountTypeDescription in ('Other Income','Revenue')
and ( ((T.txdate >= @DateStart@)  and (T.Txdate <= '2018-05-31'))) 

union all 

select 'New',

 X.AutoIdx		
, (F.Master_Sub_Account + IsNull(' ('+F.Description+')', '')) 	COLLATE Latin1_General_CI_AS				as AccDesc
, F.AccountTypeDescription  	COLLATE Latin1_General_CI_AS												as GroupByField
, F.AccountLink																								as	[AccountLink]
, F.Account 	COLLATE Latin1_General_CI_AS																as [GLAccount]
, datename(month, P.dPeriodDate) + '-' + datename(year, P.dPeriodDate) 	COLLATE Latin1_General_CI_AS		as PeriodMonth
, X.TxDate																									as	[TxDate]
, X.Debit																									AS	[DEBITTOTALPERREFERENCE]
, X.Credit																									AS	[CREDITTOTALPERREFERENCE]
, X.fForeignDebit																							as	[ForeignDebit]	
, X.fForeignCredit																							as	[ForeignCredit]
, X.Description	COLLATE Latin1_General_CI_AS																as	[GLTransactionDescription]
, X.Reference	COLLATE Latin1_General_CI_AS																as	[GLReference]
, X.Order_No	COLLATE Latin1_General_CI_AS																as	[GLOrderNumber]
, X.ExtOrderNum	COLLATE Latin1_General_CI_AS																as	[GLExternalOrderNumber]
, X.Tax_Amount																								as	[TaxAmount]
, X.fForeignTax																								as	[ForeignTax]
, X.Project																									as	[Project]
, X.Period																									as	[PeriodGL]
, X.DrCrAccount																								as	[DebitCreditAccount]
, X.DTStamp																									as	[DateStamp]
, X.UserName	COLLATE Latin1_General_CI_AS																as	[UserName]
, X.cReference2	COLLATE Latin1_General_CI_AS																as	[Reference2]
, X.ProjectCode	COLLATE Latin1_General_CI_AS																as	[ProjectCode]
, X.ProjectName	COLLATE Latin1_General_CI_AS																as	[ProjectName]
, X.ActiveProject																							as	[ProjectActive]
, X.ProjectDescription	COLLATE Latin1_General_CI_AS														as	[ProjectDescription]
, X.JobCode	COLLATE Latin1_General_CI_AS																	as	[JobCode]
, X.TrCode	COLLATE Latin1_General_CI_AS																	as	[TransactionCode]
, X.TaxCode	COLLATE Latin1_General_CI_AS																	as	[TaxCode]
, X.Module	COLLATE Latin1_General_CI_AS																	as	[Module]
, X.Account 	COLLATE Latin1_General_CI_AS																as [CustomerAccount]
, X.AccountDesc	COLLATE Latin1_General_CI_AS																as [GLAccountDescription]
, X.ContraAccount	COLLATE Latin1_General_CI_AS															as [ContraAccount]
, X.ContraAccountDesc	COLLATE Latin1_General_CI_AS														as [ContraAccountDescription]
, X.CurrencyCode	COLLATE Latin1_General_CI_AS															as [CurrencyCode]
, X.CurrencyDescription	COLLATE Latin1_General_CI_AS														as [CurrencyDescription]
, X.CurrencySymbol	COLLATE Latin1_General_CI_AS															as [CurrencySymbol]
, X.RepCode	COLLATE Latin1_General_CI_AS																	as [RepCode]
, X.RepName	COLLATE Latin1_General_CI_AS																	as [RepName]
, X.GLTaxAccount	COLLATE Latin1_General_CI_AS															as [GLTaxAccount]
, X.TxBranchCode	COLLATE Latin1_General_CI_AS															as	[BranchCode]	
, (X.Credit- X.Debit)																						as [DebitMinCredit]	
, X.TxBranchDescription	COLLATE Latin1_General_CI_AS														as [BranchDescription]
, DebitCredit = case when F.iAccountType = 1 then 'D' else 'C' end	COLLATE Latin1_General_CI_AS 

from  
[Database].[dbo].[_evGLAccountsFull]  	F
left outer join [Database].[dbo].[_bvGLTransactionsFull] X on F.AccountLink = X.AccountLink  
left outer join [Database].[dbo].[_etblPeriod] P on P.idPeriod = X.Period  
left join [Database].[dbo].[Project] Pr on Pr.ProjectLink = X.Project

 
where  F.AccountTypeDescription in ('Other Income','Revenue')
and ( ((X.txdate >= @DateStart@)  and (X.Txdate <= @DateEnd@))) and x.Description <> 'OPENING BALANCE'

