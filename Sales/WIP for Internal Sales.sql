SELECT  
    OrderNum
  , CASE WHEN ulIDSOrdSalesRep = 'Alicia' THEN 'Alicia Sirkison'
		 WHEN ulIDSOrdSalesRep = 'Angelina Nojwaqa' THEN 'Angelina Nojwaqa'
		 WHEN ulIDSOrdSalesRep = 'Carol' THEN 'Carol Tshuma' 
		 WHEN ulIDSOrdSalesRep = 'Cynthia' THEN 'Cynthia Mwanza'
         WHEN ulIDSOrdSalesRep = 'Dylan Broodryk' THEN 'Dylan Broodryk' 
		 WHEN ulIDSOrdSalesRep = 'Ephraim' THEN 'Ephraim Mbuyisa' 
		 WHEN ulIDSOrdSalesRep = 'Joyce' THEN 'Joyce Chauke' 
		 WHEN ulIDSOrdSalesRep = 'Latishia Alberts' THEN 'Latishia Alberts' 
		 WHEN ulIDSOrdSalesRep = 'Melusi Khumalo' THEN 'Melusi Khumalo' 
		 WHEN ulIDSOrdSalesRep = 'Patricia Mothibeli' THEN 'Patricia Mothibeli' 
		 WHEN ulIDSOrdSalesRep = 'Phindele Makhathini' THEN 'Phindile Makhathini' 
		 WHEN ulIDSOrdSalesRep = 'Shenaaz' THEN 'Shenaaz Hortense' 
		 WHEN ulIDSOrdSalesRep = 'Sindiswa Mashigo' THEN 'Sindiswa Mashigo' 
	ELSE ulIDSOrdSalesRep END AS InternalRep
	, Datename(month,InvDate) as Month
    , CAST(YEAR(InvDate) AS VARCHAR(4))[Year]
    , CASE  WHEN datename(month, InvDate) = 'December' THEN '1' 
            WHEN datename(month, InvDate) = 'January' THEN '2' 
            WHEN datename(month, InvDate) = 'February' THEN '3' 
            WHEN datename(month, InvDate) = 'March' THEN '4' 
            WHEN datename(month, InvDate) = 'April' THEN '5' 
            WHEN datename(month, InvDate) = 'May' THEN '6' 
            WHEN datename(month, InvDate) = 'June' THEN '7' 
            WHEN datename(month, InvDate) = 'July' THEN '8' 
            WHEN datename(month, InvDate) = 'August' THEN '9' 
            WHEN datename(month, InvDate) = 'September' THEN '10' 
            WHEN datename(month, InvDate) = 'October' THEN '11' 
            WHEN datename(month, InvDate) = 'November' THEN '12' 
                END AS MonthNo
FROM     ICC_NEW.dbo.InvNum
WHERE  (InvDate >= '2019-12-01') AND (InvDate <= '2020-11-30') AND (OrderNum NOT IN ('Quote')) AND (ulIDSOrdSalesRep not IN ('NULL', ''))
 order by OrderNum