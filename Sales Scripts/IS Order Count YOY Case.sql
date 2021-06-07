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
		case 	when S.ulIDSOrdSalesRep = 	'Dhashni Moodley'	then	'Dhashni Moodley'
				when S.ulIDSOrdSalesRep = 	'Dylan Broodryk'	then	'Dylan Broodryk'
				when S.ulIDSOrdSalesRep = 	'Cynthia'	then	'Cynthia Mwanza'
				when S.ulIDSOrdSalesRep = 	'Alicia Sirkison'	then	'Alicia Sirkison'
				when S.ulIDSOrdSalesRep = 	'Joyce Chauke'	then	'Joyce Chauke'
				when S.ulIDSOrdSalesRep = 	'Joyce'	then	'Joyce Chauke'
				when S.ulIDSOrdSalesRep = 	'Latishia Alberts'	then	'Latishia Alberts'
				when S.ulIDSOrdSalesRep = 	'Phindele Makhathini'	then	'Phindile Makhathini'
				when S.ulIDSOrdSalesRep = 	'Carlos Hlanganiso'	then	'Carlos Hlanganiso'
				when S.ulIDSOrdSalesRep = 	'Prudence Zwane'	then	'Prudence Zwane'
				when S.ulIDSOrdSalesRep = 	'Gugulethu Gqeba'	then	'Gugulethu Gqeba'
				when S.ulIDSOrdSalesRep = 	'Siyabonga'	then	'Siyabonga'
				when S.ulIDSOrdSalesRep = 	'Ephraim'	then	'Ephraim Mbuyisa'
				when S.ulIDSOrdSalesRep = 	'Engela Venter'	then	'Engela Venter'
				when S.ulIDSOrdSalesRep = 	'Cynthia Mwanza'	then	'Cynthia Mwanza'
				when S.ulIDSOrdSalesRep = 	'Khatazile Mathebula'	then	'Khatazile Mathebula'
				when S.ulIDSOrdSalesRep = 	'Caleen Parker'	then	'Caleen Parker'
				when S.ulIDSOrdSalesRep = 	'Samekeliso Ntini'	then	'Samekeliso Ntini'
				when S.ulIDSOrdSalesRep = 	'Melusi Khumalo'	then	'Melusi Khumalo'
				when S.ulIDSOrdSalesRep = 	'Rene Moriarty'	then	'Rene Moriarty'
				when S.ulIDSOrdSalesRep = 	'Kgomotso Sibeko'	then	'Kgomotso Sibeko'
				when S.ulIDSOrdSalesRep = 	'Angelina Nojwaqa'	then	'Angelina Nojwaqa'
				when S.ulIDSOrdSalesRep = 	'Cynthia Maphumolo'	then	'Cynthia Maphumolo'
				when S.ulIDSOrdSalesRep = 	'Shenaaz'	then	'Shenaaz'
				when S.ulIDSOrdSalesRep = 	'Jabu Mnisi'	then	'Jabu Mnisi'
				when S.ulIDSOrdSalesRep = 	'Sindiswa Mashigo'	then	'Sindiswa Mashigo'
				when S.ulIDSOrdSalesRep = 	'Patricia Mothibeli'	then	'Patricia Mothibeli'
				when S.ulIDSOrdSalesRep = 	'Shawn Oosthuizen'	then	'Shawn Oosthuizen'
				when S.ulIDSOrdSalesRep = 	'Cedric'	then	'Cedric'
				when S.ulIDSOrdSalesRep = 	'Shirley Ngobeni'	then	'Shirley Ngobeni'
				when S.ulIDSOrdSalesRep = 	'Shenaaz Hortense'	then	'Shenaaz Hortense'
				when S.ulIDSOrdSalesRep = 	'Carol Tshuma'	then	'Carol Tshuma'
				when S.ulIDSOrdSalesRep = 	'Alicia'	then	'Alicia Sirkison'
				when S.ulIDSOrdSalesRep = 	'Ephraim Mbuyisa'	then	'Ephraim Mbuyisa'
				when S.ulIDSOrdSalesRep = 	'Phindile Makhathini'	then	'Phindile Makhathini'
				when S.ulIDSOrdSalesRep = 	'Carol'	then	'Carol Tshuma'
				when S.ulIDSOrdSalesRep = 	'Denise Dexter'	then	'Denise Dexter'
			end as [EmployeeName]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.ulIDSOrdSalesRep not in ('Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')

	insert into #OrdersCurrent (Orders, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Orders
			,case 	when S.ulIDSOrdSalesRep = 	'Dhashni Moodley'	then	'Dhashni Moodley'
					when S.ulIDSOrdSalesRep = 	'Dylan Broodryk'	then	'Dylan Broodryk'
					when S.ulIDSOrdSalesRep = 	'Cynthia'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Alicia Sirkison'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Joyce Chauke'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Joyce'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Latishia Alberts'	then	'Latishia Alberts'
					when S.ulIDSOrdSalesRep = 	'Phindele Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carlos Hlanganiso'	then	'Carlos Hlanganiso'
					when S.ulIDSOrdSalesRep = 	'Prudence Zwane'	then	'Prudence Zwane'
					when S.ulIDSOrdSalesRep = 	'Gugulethu Gqeba'	then	'Gugulethu Gqeba'
					when S.ulIDSOrdSalesRep = 	'Siyabonga'	then	'Siyabonga'
					when S.ulIDSOrdSalesRep = 	'Ephraim'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Engela Venter'	then	'Engela Venter'
					when S.ulIDSOrdSalesRep = 	'Cynthia Mwanza'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Khatazile Mathebula'	then	'Khatazile Mathebula'
					when S.ulIDSOrdSalesRep = 	'Caleen Parker'	then	'Caleen Parker'
					when S.ulIDSOrdSalesRep = 	'Samekeliso Ntini'	then	'Samekeliso Ntini'
					when S.ulIDSOrdSalesRep = 	'Melusi Khumalo'	then	'Melusi Khumalo'
					when S.ulIDSOrdSalesRep = 	'Rene Moriarty'	then	'Rene Moriarty'
					when S.ulIDSOrdSalesRep = 	'Kgomotso Sibeko'	then	'Kgomotso Sibeko'
					when S.ulIDSOrdSalesRep = 	'Angelina Nojwaqa'	then	'Angelina Nojwaqa'
					when S.ulIDSOrdSalesRep = 	'Cynthia Maphumolo'	then	'Cynthia Maphumolo'
					when S.ulIDSOrdSalesRep = 	'Shenaaz'	then	'Shenaaz'
					when S.ulIDSOrdSalesRep = 	'Jabu Mnisi'	then	'Jabu Mnisi'
					when S.ulIDSOrdSalesRep = 	'Sindiswa Mashigo'	then	'Sindiswa Mashigo'
					when S.ulIDSOrdSalesRep = 	'Patricia Mothibeli'	then	'Patricia Mothibeli'
					when S.ulIDSOrdSalesRep = 	'Shawn Oosthuizen'	then	'Shawn Oosthuizen'
					when S.ulIDSOrdSalesRep = 	'Cedric'	then	'Cedric'
					when S.ulIDSOrdSalesRep = 	'Shirley Ngobeni'	then	'Shirley Ngobeni'
					when S.ulIDSOrdSalesRep = 	'Shenaaz Hortense'	then	'Shenaaz Hortense'
					when S.ulIDSOrdSalesRep = 	'Carol Tshuma'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Alicia'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Ephraim Mbuyisa'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Phindile Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carol'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Denise Dexter'	then	'Denise Dexter'
				end as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.OrderNum not in ('Quote') and S.ulIDSOrdSalesRep not in ('Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= @StartDate) AND (S.OrderDate <= @EndDate)
		group by S.ulIDSOrdSalesRep
	

	insert into #QuotesCurrent (Quotes, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Quotes
			,case 	when S.ulIDSOrdSalesRep = 	'Dhashni Moodley'	then	'Dhashni Moodley'
					when S.ulIDSOrdSalesRep = 	'Dylan Broodryk'	then	'Dylan Broodryk'
					when S.ulIDSOrdSalesRep = 	'Cynthia'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Alicia Sirkison'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Joyce Chauke'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Joyce'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Latishia Alberts'	then	'Latishia Alberts'
					when S.ulIDSOrdSalesRep = 	'Phindele Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carlos Hlanganiso'	then	'Carlos Hlanganiso'
					when S.ulIDSOrdSalesRep = 	'Prudence Zwane'	then	'Prudence Zwane'
					when S.ulIDSOrdSalesRep = 	'Gugulethu Gqeba'	then	'Gugulethu Gqeba'
					when S.ulIDSOrdSalesRep = 	'Siyabonga'	then	'Siyabonga'
					when S.ulIDSOrdSalesRep = 	'Ephraim'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Engela Venter'	then	'Engela Venter'
					when S.ulIDSOrdSalesRep = 	'Cynthia Mwanza'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Khatazile Mathebula'	then	'Khatazile Mathebula'
					when S.ulIDSOrdSalesRep = 	'Caleen Parker'	then	'Caleen Parker'
					when S.ulIDSOrdSalesRep = 	'Samekeliso Ntini'	then	'Samekeliso Ntini'
					when S.ulIDSOrdSalesRep = 	'Melusi Khumalo'	then	'Melusi Khumalo'
					when S.ulIDSOrdSalesRep = 	'Rene Moriarty'	then	'Rene Moriarty'
					when S.ulIDSOrdSalesRep = 	'Kgomotso Sibeko'	then	'Kgomotso Sibeko'
					when S.ulIDSOrdSalesRep = 	'Angelina Nojwaqa'	then	'Angelina Nojwaqa'
					when S.ulIDSOrdSalesRep = 	'Cynthia Maphumolo'	then	'Cynthia Maphumolo'
					when S.ulIDSOrdSalesRep = 	'Shenaaz'	then	'Shenaaz'
					when S.ulIDSOrdSalesRep = 	'Jabu Mnisi'	then	'Jabu Mnisi'
					when S.ulIDSOrdSalesRep = 	'Sindiswa Mashigo'	then	'Sindiswa Mashigo'
					when S.ulIDSOrdSalesRep = 	'Patricia Mothibeli'	then	'Patricia Mothibeli'
					when S.ulIDSOrdSalesRep = 	'Shawn Oosthuizen'	then	'Shawn Oosthuizen'
					when S.ulIDSOrdSalesRep = 	'Cedric'	then	'Cedric'
					when S.ulIDSOrdSalesRep = 	'Shirley Ngobeni'	then	'Shirley Ngobeni'
					when S.ulIDSOrdSalesRep = 	'Shenaaz Hortense'	then	'Shenaaz Hortense'
					when S.ulIDSOrdSalesRep = 	'Carol Tshuma'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Alicia'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Ephraim Mbuyisa'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Phindile Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carol'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Denise Dexter'	then	'Denise Dexter'
				end as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.InvNumber like 'SOQ%' and S.ulIDSOrdSalesRep not in ('Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= @StartDate) AND (S.OrderDate <= @EndDate)
		group by S.ulIDSOrdSalesRep


	insert into #OrdersPrev (Orders, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Orders
			,case 	when S.ulIDSOrdSalesRep = 	'Dhashni Moodley'	then	'Dhashni Moodley'
					when S.ulIDSOrdSalesRep = 	'Dylan Broodryk'	then	'Dylan Broodryk'
					when S.ulIDSOrdSalesRep = 	'Cynthia'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Alicia Sirkison'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Joyce Chauke'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Joyce'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Latishia Alberts'	then	'Latishia Alberts'
					when S.ulIDSOrdSalesRep = 	'Phindele Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carlos Hlanganiso'	then	'Carlos Hlanganiso'
					when S.ulIDSOrdSalesRep = 	'Prudence Zwane'	then	'Prudence Zwane'
					when S.ulIDSOrdSalesRep = 	'Gugulethu Gqeba'	then	'Gugulethu Gqeba'
					when S.ulIDSOrdSalesRep = 	'Siyabonga'	then	'Siyabonga'
					when S.ulIDSOrdSalesRep = 	'Ephraim'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Engela Venter'	then	'Engela Venter'
					when S.ulIDSOrdSalesRep = 	'Cynthia Mwanza'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Khatazile Mathebula'	then	'Khatazile Mathebula'
					when S.ulIDSOrdSalesRep = 	'Caleen Parker'	then	'Caleen Parker'
					when S.ulIDSOrdSalesRep = 	'Samekeliso Ntini'	then	'Samekeliso Ntini'
					when S.ulIDSOrdSalesRep = 	'Melusi Khumalo'	then	'Melusi Khumalo'
					when S.ulIDSOrdSalesRep = 	'Rene Moriarty'	then	'Rene Moriarty'
					when S.ulIDSOrdSalesRep = 	'Kgomotso Sibeko'	then	'Kgomotso Sibeko'
					when S.ulIDSOrdSalesRep = 	'Angelina Nojwaqa'	then	'Angelina Nojwaqa'
					when S.ulIDSOrdSalesRep = 	'Cynthia Maphumolo'	then	'Cynthia Maphumolo'
					when S.ulIDSOrdSalesRep = 	'Shenaaz'	then	'Shenaaz'
					when S.ulIDSOrdSalesRep = 	'Jabu Mnisi'	then	'Jabu Mnisi'
					when S.ulIDSOrdSalesRep = 	'Sindiswa Mashigo'	then	'Sindiswa Mashigo'
					when S.ulIDSOrdSalesRep = 	'Patricia Mothibeli'	then	'Patricia Mothibeli'
					when S.ulIDSOrdSalesRep = 	'Shawn Oosthuizen'	then	'Shawn Oosthuizen'
					when S.ulIDSOrdSalesRep = 	'Cedric'	then	'Cedric'
					when S.ulIDSOrdSalesRep = 	'Shirley Ngobeni'	then	'Shirley Ngobeni'
					when S.ulIDSOrdSalesRep = 	'Shenaaz Hortense'	then	'Shenaaz Hortense'
					when S.ulIDSOrdSalesRep = 	'Carol Tshuma'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Alicia'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Ephraim Mbuyisa'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Phindile Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carol'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Denise Dexter'	then	'Denise Dexter'
				end as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.OrderNum not in ('Quote') and S.ulIDSOrdSalesRep not in ('Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= DATEADD(YEAR, -1, CAST(@StartDate as DATE))) AND (S.OrderDate <= DATEADD(YEAR, -1, CAST(@EndDate as DATE)))
		group by S.ulIDSOrdSalesRep
	

	insert into #QuotesPrev (Quotes, InternalSales)

		select distinct
			Count(Distinct S.InvNumber) as Quotes
			,case 	when S.ulIDSOrdSalesRep = 	'Dhashni Moodley'	then	'Dhashni Moodley'
					when S.ulIDSOrdSalesRep = 	'Dylan Broodryk'	then	'Dylan Broodryk'
					when S.ulIDSOrdSalesRep = 	'Cynthia'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Alicia Sirkison'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Joyce Chauke'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Joyce'	then	'Joyce Chauke'
					when S.ulIDSOrdSalesRep = 	'Latishia Alberts'	then	'Latishia Alberts'
					when S.ulIDSOrdSalesRep = 	'Phindele Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carlos Hlanganiso'	then	'Carlos Hlanganiso'
					when S.ulIDSOrdSalesRep = 	'Prudence Zwane'	then	'Prudence Zwane'
					when S.ulIDSOrdSalesRep = 	'Gugulethu Gqeba'	then	'Gugulethu Gqeba'
					when S.ulIDSOrdSalesRep = 	'Siyabonga'	then	'Siyabonga'
					when S.ulIDSOrdSalesRep = 	'Ephraim'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Engela Venter'	then	'Engela Venter'
					when S.ulIDSOrdSalesRep = 	'Cynthia Mwanza'	then	'Cynthia Mwanza'
					when S.ulIDSOrdSalesRep = 	'Khatazile Mathebula'	then	'Khatazile Mathebula'
					when S.ulIDSOrdSalesRep = 	'Caleen Parker'	then	'Caleen Parker'
					when S.ulIDSOrdSalesRep = 	'Samekeliso Ntini'	then	'Samekeliso Ntini'
					when S.ulIDSOrdSalesRep = 	'Melusi Khumalo'	then	'Melusi Khumalo'
					when S.ulIDSOrdSalesRep = 	'Rene Moriarty'	then	'Rene Moriarty'
					when S.ulIDSOrdSalesRep = 	'Kgomotso Sibeko'	then	'Kgomotso Sibeko'
					when S.ulIDSOrdSalesRep = 	'Angelina Nojwaqa'	then	'Angelina Nojwaqa'
					when S.ulIDSOrdSalesRep = 	'Cynthia Maphumolo'	then	'Cynthia Maphumolo'
					when S.ulIDSOrdSalesRep = 	'Shenaaz'	then	'Shenaaz'
					when S.ulIDSOrdSalesRep = 	'Jabu Mnisi'	then	'Jabu Mnisi'
					when S.ulIDSOrdSalesRep = 	'Sindiswa Mashigo'	then	'Sindiswa Mashigo'
					when S.ulIDSOrdSalesRep = 	'Patricia Mothibeli'	then	'Patricia Mothibeli'
					when S.ulIDSOrdSalesRep = 	'Shawn Oosthuizen'	then	'Shawn Oosthuizen'
					when S.ulIDSOrdSalesRep = 	'Cedric'	then	'Cedric'
					when S.ulIDSOrdSalesRep = 	'Shirley Ngobeni'	then	'Shirley Ngobeni'
					when S.ulIDSOrdSalesRep = 	'Shenaaz Hortense'	then	'Shenaaz Hortense'
					when S.ulIDSOrdSalesRep = 	'Carol Tshuma'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Alicia'	then	'Alicia Sirkison'
					when S.ulIDSOrdSalesRep = 	'Ephraim Mbuyisa'	then	'Ephraim Mbuyisa'
					when S.ulIDSOrdSalesRep = 	'Phindile Makhathini'	then	'Phindile Makhathini'
					when S.ulIDSOrdSalesRep = 	'Carol'	then	'Carol Tshuma'
					when S.ulIDSOrdSalesRep = 	'Denise Dexter'	then	'Denise Dexter'
				end as [Internal Rep]
		from ICC_NEW.dbo._bvSalesOrdersFull S
		where S.ulIDSOrdSalesRep not in ('') and S.InvNumber like 'SOQ%' and S.ulIDSOrdSalesRep not in ('Dhashni Moodley','Carlos Hlanganiso','Prudence Zwane','Siyabonga','Khatazile Mathebula','Caleen Parker','Samekeliso Ntini','Kgomotso Sibeko','Cynthia Maphumolo','Jabu Mnisi','Shawn Oosthuizen','Cedric','Shirley Ngobeni','Denise Dexter')
		and (S.OrderDate >= DATEADD(YEAR, -1, CAST(@StartDate as DATE))) AND (S.OrderDate <= DATEADD(YEAR, -1, CAST(@EndDate as DATE)))
		group by S.ulIDSOrdSalesRep


Select E.EmployeeName
, SUM(OC.Orders) as [Orders Current Year]
, SUM(QC.Quotes) as [Quotes Current Year]
, SUM(OP.Orders) as [Orders Previous Year]
, SUM(QP.Quotes) as [Quotes Previous Year]
from #SalesEmployee E
left join #OrdersCurrent OC on OC.InternalSales = E.EmployeeName
left join #QuotesCurrent QC on QC.InternalSales = E.EmployeeName
left join #OrdersPrev OP on OP.InternalSales = E.EmployeeName
Left Join #QuotesPrev QP on QP.InternalSales = E.EmployeeName
--where OC.InternalSales not in ('Alicia','Shenaaz','Phindele Makhathini','Carol')
group by E.EmployeeName

Use tempdb

If OBJECT_ID('tempdb..#OrdersCurrent') Is Not Null Drop Table #OrdersCurrent
If OBJECT_ID('tempdb..#SalesEmployee') Is Not Null Drop Table #SalesEmployee
If OBJECT_ID('tempdb..#OrdersPrev') Is Not Null Drop Table #OrdersPrev
If OBJECT_ID('tempdb..#QuotesCurrent') Is Not Null Drop Table #QuotesCurrent
If(OBJECT_ID('tempdb..#QuotesPrev') Is Not Null) Begin Drop Table #QuotesPrev
end