use tempdb

declare @StartDate date = '2021-01-01'
declare @EndDate date = '2021-01-31'

If OBJECT_ID('tempdb..#OrdersCurrent') Is Not Null Drop Table #OrdersCurrent
If OBJECT_ID('tempdb..#OrdersPrev') Is Not Null Drop Table #OrdersPrev
If OBJECT_ID('tempdb..#QuotesCurrent') Is Not Null Drop Table #QuotesCurrent
If(OBJECT_ID('tempdb..#QuotesPrev') Is Not Null) Begin Drop Table #QuotesPrev
end
	
create table #OrdersCurrent (InternalSales varchar (max), Orders int )
create table #QuotesCurrent (InternalSales varchar (max), Quotes int )
create table #OrdersPrev (InternalSales varchar (max), Orders int )
create table #QuotesPrev (InternalSales varchar (max), Quotes int )


	insert into #OrdersCurrent (Orders, InternalSales)

		select distinct
			Count(distinct S.OrderNum) as OrderNum
		, S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.OrderNum not in ('Quote')
		and (S.OrderDate >= @StartDate) AND (S.OrderDate <= @EndDate)
		group by S.ulIDSOrdSalesRep
	

	insert into #QuotesCurrent (Quotes, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Quotes
		, S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.InvNumber like 'SOQ%'
		and (S.OrderDate >= @StartDate) AND (S.OrderDate <= @EndDate)
		group by S.ulIDSOrdSalesRep


	insert into #OrdersPrev (Orders, InternalSales)

		select distinct
			Count(distinct S.OrderNum) as OrderNum
		, S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.OrderNum not in ('Quote')
		and (S.OrderDate >= DATEADD(YEAR, -1, CAST(@StartDate as DATE))) AND (S.OrderDate <= DATEADD(YEAR, -1, CAST(@EndDate as DATE)))
		group by S.ulIDSOrdSalesRep
	

	insert into #QuotesPrev (Quotes, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Quotes
		, S.ulIDSOrdSalesRep as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.InvNumber like 'SOQ%'
		and (S.OrderDate >= DATEADD(YEAR, -1, CAST(@StartDate as DATE))) AND (S.OrderDate <= DATEADD(YEAR, -1, CAST(@EndDate as DATE)))
		group by S.ulIDSOrdSalesRep


Select OC.InternalSales
, SUM(OC.Orders) as [Orders Current Year]
, SUM(QC.Quotes) as [Quotes Current Year]
, SUM(OP.Orders) as [Orders Previous Year]
, SUM(QP.Quotes) as [Quotes Previous Year]
from #OrdersCurrent OC
left join #QuotesCurrent QC on QC.InternalSales = OC.InternalSales
left join #OrdersPrev OP on OP.InternalSales = OC.InternalSales
Left Join #QuotesPrev QP on QP.InternalSales = OC.InternalSales
where OC.InternalSales not in ('Alicia','Shenaaz','Phindele Makhathini','Carol')
group by OC.InternalSales

Use tempdb

If OBJECT_ID('tempdb..#OrdersCurrent') Is Not Null Drop Table #OrdersCurrent
If OBJECT_ID('tempdb..#OrdersPrev') Is Not Null Drop Table #OrdersPrev
If OBJECT_ID('tempdb..#QuotesCurrent') Is Not Null Drop Table #QuotesCurrent
If(OBJECT_ID('tempdb..#QuotesPrev') Is Not Null) Begin Drop Table #QuotesPrev
end