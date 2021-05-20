Use ICC_NEW

Select
P.[Internal Sales]
, SUM(P.January)    as January
, SUM(P.February)   as February
, SUM(P.March)      as March
, SUM(P.April)      as April
, SUM(P.May)        as May
, SUM(P.June)       as June
, SUM(P.July)       as July
, SUM(P.August)     as August
, SUM(P.September)  as September
, SUM(P.October)    as October
, SUM(P.November)   as November
, SUM(P.December)   as December

from
(
    select distinct
    O.InvNumber as Orders
    , Case  when O.ulIDSOrdSalesRep =   'Alicia'                then	'Alicia Sirkison'
            when O.ulIDSOrdSalesRep = 	'Angelina Nojwaqa'  	then	'Angelina Nojwaqa'
            when O.ulIDSOrdSalesRep = 	'Carol'	                then	'Carol Tshuma'
            when O.ulIDSOrdSalesRep = 	'Cynthia'	            then	'Cynthia Mwanza'
            when O.ulIDSOrdSalesRep = 	'Dylan Broodryk'	    then	'Dylan Broodryk'
            when O.ulIDSOrdSalesRep = 	'Ephraim'	            then	'Ephraim Mbuyisa'
            when O.ulIDSOrdSalesRep = 	'Joyce'	                then	'Joyce Chauke'
            when O.ulIDSOrdSalesRep = 	'Latishia Alberts'	    then	'Latishia Alberts'
            when O.ulIDSOrdSalesRep = 	'Melusi Khumalo'	    then	'Melusi Khumalo'
            when O.ulIDSOrdSalesRep = 	'Patricia Mothibeli'	then	'Patricia Mothibeli'
            when O.ulIDSOrdSalesRep = 	'Phindele Makhathini'	then	'Phindile Makhathini'
            when O.ulIDSOrdSalesRep = 	'Shenaaz'	            then	'Shenaaz Hortense'
            when O.ulIDSOrdSalesRep = 	'Sindiswa Mashigo'  	then	'Sindiswa Mashigo'
        else O.ulIDSOrdSalesRep end as [Internal Sales]
    , Datename(month,T.txdate) COLLATE Latin1_General_CI_AS as Month
    , CAST(YEAR(T.txdate) AS VARCHAR(4))[Year]
    , CAST(MONTH(T.txdate) AS VARCHAR(4))[MonthNo]
    from ICC_NEW.dbo._bvSTTransactionsFull T
    left join ICC_NEW.dbo._bvSalesOrdersFull O on O.OrderNum = T.Order_No
    where (T.TxDate>='2020-01-01') and (T.TxDate<='2020-12-31') and T.Id in ('Inv','OInv','POSI')
    and O.InvNumber not in ('', 'NULL') and O.InvNumber not like ('%TPS%') and O.ulIDSOrdSalesRep not in ('NULL')
) S

PIVOT(
    Count(S.Orders)
		FOR [Month] 
		    IN(
                [January], 
                [February], 
                [March],
                [April],
                [May],
                [June],
                [July],
                [August],
                [September],
                [October],
                [November],
                [December])
) as P

group by P.[Internal Sales]