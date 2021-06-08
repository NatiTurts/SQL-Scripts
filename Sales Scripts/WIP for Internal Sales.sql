SELECT  
    OrderNum
  , ulIDSOrdSalesRep  AS InternalRep
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
FROM     [Database].dbo.InvNum
WHERE  (InvDate >= '2019-12-01') AND (InvDate <= '2020-11-30') AND (OrderNum NOT IN ('Quote')) AND (ulIDSOrdSalesRep not IN ('NULL', ''))
 order by OrderNum