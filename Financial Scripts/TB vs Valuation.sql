trial balance 
Dr-Cr

valuation
Value (SOH*Weighted Average)

= If(dr-cr) -sum(valuation) > = 500
= If(dr-cr) -sum(valuation) < = 500
 then email

use tempdb

	If(OBJECT_ID('tempdb..#InvStaging') Is Not Null)
	Begin
		Drop Table #InvStaging
	End	

	
		create table #InvStaging (ItemCode nvarchar (max),ItemGroup nvarchar (max), Valuation float)
		--create table #Final (FinalAudit varchar (max), Checks int)	

			Insert into #InvStaging (ItemCode, ItemGroup, Valuation)
				select
				S.Code
				, S.ItemGroup
				, [Weighted Value] =  Round((S.Qty_On_Hand*S.AveUCst),2)
				from ICC_TEST.dbo.StkItem S

select
INS.ItemGroup
, SUM(INS.Valuation) as Valuation
from #InvStaging INS
group by INS.ItemGroup

	If(OBJECT_ID('tempdb..#InvStaging') Is Not Null)
	Begin
		Drop Table #InvStaging
	End	




