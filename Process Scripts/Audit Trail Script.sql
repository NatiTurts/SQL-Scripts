use tempdb

	If OBJECT_ID('tempdb..#Staging') Is Not Null Drop Table #Staging
	If(OBJECT_ID('tempdb..#Final') Is Not Null) Begin Drop Table #Final
	end

	
		create table #Staging (OrderNumber varchar (max), AuditNumber varchar (max), Customer varchar (max), DateStamp datetime )
		create table #Final (FinalAudit varchar (max), Checks int)	

				insert into #Staging (OrderNumber, AuditNumber, Customer, DateStamp)
					select distinct
					P.Order_No as [OrderNumber]
					, P.cAuditNumber as [AuditNumber]
					, P.DrCrAccount as [Customer]
					, P.TxDate as [DateStamp]
					from ICC_NEW.dbo.PostGL P
					inner join ICC_NEW.dbo._bvCMCustomerFull C on C.CustomerID = P.DrCrAccount
					where (P.TxDate >= '2018-01-01') AND (P.TxDate <= '2021-06-30') and P.Order_No not in ('')

				
				insert into #Final (FinalAudit, Checks)
					Select
					T.AuditNumber
					, COUNT(T.AuditNumber) as Checks
					from #Staging T
					group by T.AuditNumber
					having COUNT(T.AuditNumber) >1
		

Select distinct
--GL.AutoIdx
 Gl.cReference2
 , GL.Reference
 , CC.Customer
, F.FinalAudit
, GL.DrCrAccount
, GL.TxDate
, GL.UserName
from #Final F
inner join ICC_NEW.dbo.PostGL GL on GL.cAuditNumber = F.FinalAudit
inner join ICC_NEW.dbo._bvCMCustomerFull CC on CC.CustomerID = GL.DrCrAccount
--where F.FinalAudit = '320616.0002'
order by F.FinalAudit

	use tempdb

	If OBJECT_ID('tempdb..#Staging') Is Not Null Drop Table #Staging
	If(OBJECT_ID('tempdb..#Final') Is Not Null) Begin Drop Table #Final
	end


