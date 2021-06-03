use tempdb

declare @StartDate date = '2021-01-01'
declare @EndDate date = '2021-3-31'


If OBJECT_ID('tempdb..#OrdersCurrent') Is Not Null Drop Table #OrdersCurrent
If OBJECT_ID('tempdb..#SalesEmployee') Is Not Null Drop Table #SalesEmployee
If OBJECT_ID('tempdb..#OrdersPrev') Is Not Null Drop Table #OrdersPrev
If OBJECT_ID('tempdb..#QuotesCurrent') Is Not Null Drop Table #QuotesCurrent
If(OBJECT_ID('tempdb..#QuotesPrev') Is Not Null) Begin Drop Table #QuotesPrev
end

create table #SalesEmployee (EmployeeName VARCHAR (max))	
create table #OrdersCurrent (InternalSales varchar (max), Orders int )
create table #QuotesCurrent (InternalSales varchar (max), Quotes int )
create table #OrdersPrev (InternalSales varchar (max), Orders int )
create table #QuotesPrev (InternalSales varchar (max), Quotes int )

	insert into #SalesEmployee (EmployeeName)

		select distinct
		S.ulIDSOrdSalesRep as [EmployeeName]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.ulIDSOrdSalesRep not in ('Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')

	insert into #OrdersCurrent (Orders, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Orders
			,S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.OrderNum not in ('Quote') --and S.ulIDSOrdSalesRep not in ('Shenaaz',	'Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= @StartDate) AND (S.OrderDate <= @EndDate)
		group by S.ulIDSOrdSalesRep
	

	insert into #QuotesCurrent (Quotes, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Quotes
			,S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.InvNumber like 'SOQ%' --and S.ulIDSOrdSalesRep not in ('Shenaaz',	'Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= @StartDate) AND (S.OrderDate <= @EndDate)
		group by S.ulIDSOrdSalesRep


	insert into #OrdersPrev (Orders, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Orders
			,S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.OrderNum not in ('Quote') --and S.ulIDSOrdSalesRep not in ('Shenaaz',	'Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= DATEADD(YEAR, -1, CAST(@StartDate as DATE))) AND (S.OrderDate <= DATEADD(YEAR, -1, CAST(@EndDate as DATE)))
		group by S.ulIDSOrdSalesRep
	

	insert into #QuotesPrev (Quotes, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Quotes
			,S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.InvNumber like 'SOQ%' --and S.ulIDSOrdSalesRep not in ('Shenaaz',	'Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= DATEADD(YEAR, -1, CAST(@StartDate as DATE))) AND (S.OrderDate <= DATEADD(YEAR, -1, CAST(@EndDate as DATE)))
		group by S.ulIDSOrdSalesRep


Select E.EmployeeName
, ISNULL(SUM(OC.Orders),0) as [Orders Current Year]
, ISNULL(SUM(QC.Quotes),0) as [Quotes Current Year]
, ISNULL(SUM(OP.Orders),0) as [Orders Previous Year]
, ISNULL(SUM(QP.Quotes),0) as [Quotes Previous Year]
from #SalesEmployee E
left join #OrdersCurrent OC on OC.InternalSales = E.EmployeeName
left join #QuotesCurrent QC on QC.InternalSales = E.EmployeeName
left join #OrdersPrev OP on OP.InternalSales = E.EmployeeName
Left Join #QuotesPrev QP on QP.InternalSales = E.EmployeeName
--where E.EmployeeName not in ('Alicia','Cynthia','Phindele Makhathini','Carol','Ephraim','Joyce')
group by E.EmployeeName

Use tempdb

If OBJECT_ID('tempdb..#OrdersCurrent') Is Not Null Drop Table #OrdersCurrent
If OBJECT_ID('tempdb..#SalesEmployee') Is Not Null Drop Table #SalesEmployee
If OBJECT_ID('tempdb..#OrdersPrev') Is Not Null Drop Table #OrdersPrev
If OBJECT_ID('tempdb..#QuotesCurrent') Is Not Null Drop Table #QuotesCurrent
If(OBJECT_ID('tempdb..#QuotesPrev') Is Not Null) Begin Drop Table #QuotesPrev
end