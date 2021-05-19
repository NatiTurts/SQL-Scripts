use tempdb

	If(OBJECT_ID('tempdb..#Staging') Is Not Null)
	Begin
		Drop Table #Staging,#Final
	End	

	
		create table #Test (OrderNumber varchar (max), AuditNumber varchar (max), Customer varchar (max), DateStamp datetime )
		create table #Final (FinalAudit varchar (max), Checks int)	

				insert into #Test (OrderNumber, AuditNumber, Customer, DateStamp)
					select distinct
					P.Order_No as [OrderNumber]
					, P.cAuditNumber as [AuditNumber]
					, C.Customer as [Customer]
					, P.TxDate as [DateStamp]
					from Sage.dbo.PostGL P
					inner join Sage.dbo._bvCMCustomerFull C on C.CustomerID = P.DrCrAccount
					where (P.TxDate >= '2018-01-01') AND (P.TxDate <= '2021-06-30') and P.Order_No not in ('')

				
				insert into #Final (FinalAudit, Checks)
					Select
					T.AuditNumber
					, COUNT(T.AuditNumber) as Checks
					from #Test T
					group by T.AuditNumber
					having COUNT(T.AuditNumber) >1
		

Select distinct
F.FinalAudit
, CC.Customer
, GL.TxDate
, GL.UserName
from #Final F
inner join Sage.dbo.PostGL GL on GL.cAuditNumber = F.FinalAudit
inner join Sage.dbo._bvCMCustomerFull CC on CC.CustomerID = GL.DrCrAccount
order by F.FinalAudit

	use tempdb

	If(OBJECT_ID('tempdb..#Staging') Is Not Null)
	Begin
		Drop Table #Staging,#Final
	End	


