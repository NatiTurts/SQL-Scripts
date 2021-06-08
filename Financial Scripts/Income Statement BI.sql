select

 X.AutoIdx		
, (F.Master_Sub_Account + IsNull(' ('+F.Description+')', '')) 	COLLATE Latin1_General_CI_AS				as AccDesc
, F.AccountTypeDescription  	COLLATE Latin1_General_CI_AS												as GroupByField
, F.AccountLink																								as	[AccountLink]
, F.Account 	COLLATE Latin1_General_CI_AS																as [GLAccount]
, AccountType_Old = [Database].[dbo]._efnLedgerAccountTypeDescription(F.iAccountType)	COLLATE Latin1_General_CI_AS 
, datename(month, P.dPeriodDate) COLLATE Latin1_General_CI_AS												as PeriodMonth
, Case when datename(month, P.dPeriodDate) = 'December' then '1'
	   when datename(month, P.dPeriodDate) = 'January' then '2'
	   when datename(month, P.dPeriodDate) = 'February' then '3'
	   when datename(month, P.dPeriodDate) = 'March' then '4'
	   when datename(month, P.dPeriodDate) = 'April' then '5'
	   when datename(month, P.dPeriodDate) = 'May' then '6'
	   when datename(month, P.dPeriodDate) = 'June' then '7'
	   when datename(month, P.dPeriodDate) = 'July' then '8'
	   when datename(month, P.dPeriodDate) = 'August' then '9'
	   when datename(month, P.dPeriodDate) = 'September' then '10'
	   when datename(month, P.dPeriodDate) = 'October' then '11'
	   when datename(month, P.dPeriodDate) = 'November' then '12'
	   end as [MonthNo]
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
, DebitCredit = case when[Database].[dbo]._efnGLAccTypesDebits(F.iAccountType) = 1 then 'D' else 'C' end	COLLATE Latin1_General_CI_AS 

from  
[Database].[dbo].[_evGLAccountsFull]  	F
left outer join [Database].[dbo].[_bvGLTransactionsFull] X on F.AccountLink = X.AccountLink  
left outer join [Database].[dbo].[_etblPeriod] P on P.idPeriod = X.Period  
left join [Database].[dbo].[Project] Pr on Pr.ProjectLink = X.Project

 
where  F.AccountTypeDescription in ('Other Income','Revenue')
and ( ((X.txdate >= '2018-12-01')  and (X.Txdate <= '2019-11-30'))) and x.autoIdx  not in  (94214,
94229,
94218,
94225,
94228,
94227,
94237,
94224,
94226,
94259,
94253,
94266,
94238,
94247,
94249,
94250,
94262,
94257,
94222,
94261,
94258,
94235,
94233,
94256,
94273,
94260)
