--V7 Report with Custom Classifications
SELECT P.ItemStyleCode
, ISNULL(P.[2017], 0) AS [2017]
, ISNULL(P.[2018], 0) AS [2018]
, ISNULL(P.[2019], 0) AS [2019]
, ISNULL(P.[2020], 0) AS [2020]
, Case when P.ItemStyleCode =	 'CAT-A3 NEW' 	then 'Marketing' 
when P.ItemStyleCode =	 'CAT-MAIN' 	then 'Marketing' 
when P.ItemStyleCode =	 'CAT-MINI' 	then 'Marketing' 
when P.ItemStyleCode =	 'CAT-NAMP' 	then 'Marketing' 
when P.ItemStyleCode =	 'CAT-SHOW' 	then 'Marketing' 
when P.ItemStyleCode =	 '6822' 	then 'Specials' 
when P.ItemStyleCode =	 '5451NAJ' 	then 'Specials' 
when P.ItemStyleCode =	 '5451ORJ' 	then 'Specials' 
when P.ItemStyleCode =	 '6173WHGR' 	then 'Specials' 
when P.ItemStyleCode =	 '6175GRWH' 	then 'Specials' 
when P.ItemStyleCode =	 '6198BGKH' 	then 'Specials' 
when P.ItemStyleCode =	 '6199BGKH' 	then 'Specials' 
when P.ItemStyleCode =	 '6200PUBG' 	then 'Specials' 
when P.ItemStyleCode =	 '6301RE' 	then 'Specials' 
when P.ItemStyleCode =	 '6417BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6483DE' 	then 'Specials' 
when P.ItemStyleCode =	 '6484DE' 	then 'Specials' 
when P.ItemStyleCode =	 '6485DE' 	then 'Specials' 
when P.ItemStyleCode =	 '6487BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6488BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6501BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6502BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6555NAD59' 	then 'Specials' 
when P.ItemStyleCode =	 '6637BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6652DE' 	then 'Specials' 
when P.ItemStyleCode =	 '6654BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6655BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6682BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6689CH' 	then 'Specials' 
when P.ItemStyleCode =	 '6709GRFNF' 	then 'Specials' 
when P.ItemStyleCode =	 '6714GRFNF' 	then 'Specials' 
when P.ItemStyleCode =	 '6715GRFNF' 	then 'Specials' 
when P.ItemStyleCode =	 '6716GRFNF' 	then 'Specials' 
when P.ItemStyleCode =	 '6729BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6760BLGR' 	then 'Specials' 
when P.ItemStyleCode =	 '6761BLGR' 	then 'Specials' 
when P.ItemStyleCode =	 '6762BLGR' 	then 'Specials' 
when P.ItemStyleCode =	 '6763BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6764BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6765BLRE' 	then 'Specials' 
when P.ItemStyleCode =	 '6822BL' 	then 'Specials' 
when P.ItemStyleCode =	 '6844WHAR' 	then 'Specials' 
when P.ItemStyleCode =	 '6845WHAR' 	then 'Specials' 
when P.ItemStyleCode =	 '6876NAST' 	then 'Specials' 
when P.ItemStyleCode =	 '6877NAST' 	then 'Specials' 
when P.ItemStyleCode =	 'Butt Rivets Alloy' 	then 'Trim' 
when P.ItemStyleCode =	 'Button 600R/17mm' 	then 'Trim' 
when P.ItemStyleCode =	 'Button SABS 600RB/17' 	then 'Trim' 
when P.ItemStyleCode =	 'Butt-ST890GD' 	then 'Trim' 
when P.ItemStyleCode =	 'TR003' 	then 'Trim' 
when P.ItemStyleCode =	 'TR004' 	then 'Trim' 
when P.ItemStyleCode =	 'TR007' 	then 'Trim' 
when P.ItemStyleCode =	 'TR008' 	then 'Trim' 
when P.ItemStyleCode =	 'TR009' 	then 'Trim' 
when P.ItemStyleCode =	 'TR01' 	then 'Trim' 
when P.ItemStyleCode =	 'TR011' 	then 'Trim' 
when P.ItemStyleCode =	 'TR012' 	then 'Trim' 
when P.ItemStyleCode =	 'TR016' 	then 'Trim' 
when P.ItemStyleCode =	 'TR019' 	then 'Trim' 
when P.ItemStyleCode =	 'TR068' 	then 'Trim' 
when P.ItemStyleCode =	 'TR073' 	then 'Trim' 
when P.ItemStyleCode =	 'TR074' 	then 'Trim' 
when P.ItemStyleCode =	 'TR075' 	then 'Trim' 
when P.ItemStyleCode =	 'TR076' 	then 'Trim' 
when P.ItemStyleCode =	 'TR077' 	then 'Trim' 
when P.ItemStyleCode =	 'TR078' 	then 'Trim' 
when P.ItemStyleCode =	 'TR079' 	then 'Trim' 
when P.ItemStyleCode =	 'TR083' 	then 'Trim' 
when P.ItemStyleCode =	 'TR08360' 	then 'Trim' 
when P.ItemStyleCode =	 'TR08362' 	then 'Trim' 
when P.ItemStyleCode =	 'TR086' 	then 'Trim' 
when P.ItemStyleCode =	 'TR089' 	then 'Trim' 
when P.ItemStyleCode =	 'TR091' 	then 'Trim' 
when P.ItemStyleCode =	 'TR094' 	then 'Trim' 
when P.ItemStyleCode =	 'ZP40O36' 	then 'Trim' 
when P.ItemStyleCode =	 'STSALT' 	then 'Trim'
when P.ItemStyleCode =   '6485DE'	then 	'Specials'
when P.ItemStyleCode =   '6483DE'	then 	'Specials'
when P.ItemStyleCode =   '7161NAKH'	then 	'Specials'
when P.ItemStyleCode =   '7365NAKH'	then 	'Specials'
when P.ItemStyleCode =   '6301RE'	then 	'Specials'
when P.ItemStyleCode =   '6655BLRE'	then 	'Specials'
when P.ItemStyleCode =    '6555NAD59'	then 	'Specials'
when P.ItemStyleCode =   '6709GRFNF'	then 	'Specials'
when P.ItemStyleCode =   	'6484DE'	then 	'Specials'
when P.ItemStyleCode =   	'6729BLRE'	then 	'Specials'
when P.ItemStyleCode =   	'6637BL'	then 	'Specials'
when P.ItemStyleCode =   	'5451NAJ'	then 	'Specials'
when P.ItemStyleCode =   	'7159NAKH'	then 	'Specials'
when P.ItemStyleCode =   	'7364NAKH'	then 	'Specials'
when P.ItemStyleCode =   	'5451ORJ'	then 	'Specials'
when P.ItemStyleCode =   	'6716GRFNF'	then 	'Specials'
when P.ItemStyleCode =   	'6654BLRE'	then 	'Specials'
when P.ItemStyleCode =   	'6652DE'	then 	'Specials'
when P.ItemStyleCode =   	'6877NAST'	then 	'Specials'
when P.ItemStyleCode =   	'6689CH'	then 	'Specials'
when P.ItemStyleCode =   	'7008NAD59'	then 	'Specials'
when P.ItemStyleCode =   	'6714GRFNF'	then 	'Specials'
when P.ItemStyleCode =   	'6715GRFNF'	then 	'Specials'
when P.ItemStyleCode =   	'7193BLJC'	then 	'Specials'
when P.ItemStyleCode =   	'7192GRBL'	then 	'Specials'
when P.ItemStyleCode =   	'7192GRJC'	then 	'Specials'
when P.ItemStyleCode =   	'6761BLGR'	then 	'Specials'
when P.ItemStyleCode =   	'4015NAPC'	then 	'Specials'
when P.ItemStyleCode =   	'6488BL'	then 	'Specials'
when P.ItemStyleCode =   	'7399'	then 	'Specials'
when P.ItemStyleCode =   	'6760BLGR'	then 	'Specials'
when P.ItemStyleCode =   	'6763BLRE'	then 	'Specials'
when P.ItemStyleCode =   	'LAPSP1'	then 	'Specials'
when P.ItemStyleCode =   	'6822BL'	then 	'Specials'
when P.ItemStyleCode =   	'5597BLRE'	then 	'Specials'
when P.ItemStyleCode =   	'4015NAJC'	then 	'Specials'
when P.ItemStyleCode =   	'5922YW'	then 	'Specials'
when P.ItemStyleCode =   	'6876NAST'	then 	'Specials'
when P.ItemStyleCode =   	'6417BLRE'	then 	'Specials'
when P.ItemStyleCode =   	'6764BLRE'	then 	'Specials'
when P.ItemStyleCode =   	'6775NAD59'	then 	'Specials'
else ulIIClassification end as Classification
, SUM(T .Qty_On_Hand) AS SOH
, SUM(T .QtyOnPO) AS WIP
, SUM(T .Qty_On_Hand) + SUM(T .QtyOnPO) AS [Potential Stock]
, ISNULL(NULLIF (Round(P.[2017] / (12), 2), 0), 0) AS [Ave Consumption 2017], ISNULL(NULLIF (Round(P.[2018] / (12), 2), 0), 0) AS [Ave Consumption 2018]
, ISNULL(NULLIF (Round(P.[2019] / (12), 2), 0), 0) AS [Ave Consumption 2019]
, ISNULL(NULLIF (Round(P.[2020] / (CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, - 1, GETDATE()) - 1, 0)) AS INT)), 2), 0), 0) AS [Ave Consumption 2020]
, [Ave mnt stock 2018 ave] = ISNULL(Round(NULLIF (SUM(T .Qty_On_Hand) / NULLIF ((P.[2018] / 12), 0), 0), 2), 0)
, [Pot ave mnt Stock 2018 Ave] = ISNULL(Round(NULLIF ((SUM(T .Qty_On_Hand) + SUM(T .QtyOnPO)) / NULLIF ((P.[2018] / 12), 0), 0), 2), 0)
, [Ave mnt stock 2019 ave] = ISNULL(Round(NULLIF (SUM(T .Qty_On_Hand) / NULLIF ((P.[2019] / 12), 0), 0), 2), 0)
, [Pot ave mnt Stock 2019 Ave] = ISNULL(Round(NULLIF ((SUM(T .Qty_On_Hand) + SUM(T .QtyOnPO)) / NULLIF ((P.[2019] / 12), 0), 0), 2), 0)
, [Ave mnt stock 2020 ave] = ISNULL(Round(NULLIF (SUM(T .Qty_On_Hand) / NULLIF ((P.[2020] / CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, - 1, GETDATE()) - 1, 0)) AS INT)), 0), 0), 2), 0)
, [Pot ave mnt Stock 2020 Ave] = ISNULL(Round(NULLIF ((SUM(T .Qty_On_Hand) + SUM(T .QtyOnPO)) / NULLIF ((P.[2020] / CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, - 1, GETDATE()) - 1, 0)) AS INT)), 0), 0), 2), 0)
, [Growth 2018] = ISNULL(Round(NULLIF (((P.[2018] / 12) - NULLIF ((P.[2017] / 12), 0)) / NULLIF ((P.[2017] / 12), 0), 0), 2), 0)
, [Growth 2019] = ISNULL(Round(NULLIF (((P.[2019] / 12) - NULLIF ((P.[2018] / 12), 0)) / NULLIF ((P.[2018] / 12), 0), 0), 2), 0)
, [Growth 2020] = ISNULL(Round(NULLIF (((P.[2020] / CAST(MONTH(DATEADD(MONTH, DATEDIFF(MONTH, - 1, GETDATE()) - 1, 0)) AS INT)) - NULLIF ((P.[2019] / 12), 0)) / NULLIF ((P.[2019] / 12), 0), 0), 2), 0)
, DATENAME(MONTH, DATEADD(MM,-1, GETDATE())) as Month



FROM        (SELECT     S.ucIIitemstyle COLLATE Latin1_General_CI_AS AS [ItemStyleCode], Sum(P.ActualQuantityInvoiced) AS Qty, CAST(YEAR(p.txdate) AS VARCHAR(4)) AS [Year]
                   FROM        icc_new.dbo._bvSTTransactionsFull P LEFT JOIN
                                     icc_new.dbo._bvStockFull S ON S.StockLink = P.AccountLink
                   WHERE     (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2019-01-01') AND (P.TxDate <= '2019-12-31')
                   GROUP BY s.ucIIitemstyle, CAST(YEAR(p.txdate) AS VARCHAR(4))
                   UNION ALL
                   SELECT     S.ucIIitemstyle COLLATE Latin1_General_CI_AS AS [ItemStyleCode], Sum(P.ActualQuantityInvoiced) AS Qty, CAST(YEAR(p.txdate) AS VARCHAR(4)) AS [Year]
                   FROM        icc_new.dbo._bvSTTransactionsFull P LEFT JOIN
                                     icc_new.dbo._bvStockFull S ON S.StockLink = P.AccountLink
                   WHERE     (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2018-06-01') AND (P.TxDate <= '2018-12-31')
                   GROUP BY s.ucIIitemstyle, CAST(YEAR(p.txdate) AS VARCHAR(4))
                   UNION ALL
                   SELECT     S.ucIIitemstyle COLLATE Latin1_General_CI_AS AS [ItemStyleCode], Sum(P.ActualQuantityInvoiced) AS Qty, CAST(YEAR(p.txdate) AS VARCHAR(4)) AS [Year]
                   FROM        The_Industrial_Clothing_Company.dbo._bvSTTransactionsFull P LEFT JOIN
                                     The_Industrial_Clothing_Company.dbo._bvStockFull S ON S.StockLink = P.AccountLink
                   WHERE     (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2018-01-01') AND (P.TxDate <= '2018-05-31')
                   GROUP BY s.ucIIitemstyle, CAST(YEAR(p.txdate) AS VARCHAR(4))
                   UNION ALL
                   SELECT     S.ucIIitemstyle COLLATE Latin1_General_CI_AS AS [ItemStyleCode], Sum(P.ActualQuantityInvoiced) AS Qty, CAST(YEAR(p.txdate) AS VARCHAR(4)) AS [Year]
                   FROM        The_Industrial_Clothing_Company.dbo._bvSTTransactionsFull P LEFT JOIN
                                     The_Industrial_Clothing_Company.dbo._bvStockFull S ON S.StockLink = P.AccountLink
                   WHERE     (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2017-01-01') AND (P.TxDate <= '2017-12-31')
                   GROUP BY s.ucIIitemstyle, CAST(YEAR(p.txdate) AS VARCHAR(4))
                   UNION ALL
                   SELECT     S.ucIIitemstyle COLLATE Latin1_General_CI_AS AS [ItemStyleCode], Sum(P.ActualQuantityInvoiced) AS Qty, CAST(YEAR(p.txdate) AS VARCHAR(4)) AS [Year]
                   FROM        ICC_NEW.dbo._bvSTTransactionsFull P LEFT JOIN
                                     ICC_NEW.dbo._bvStockFull S ON S.StockLink = P.AccountLink
                   WHERE     (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2020-01-01') AND (P.TxDate <= '2020-12-31')
                   GROUP BY s.ucIIitemstyle, CAST(YEAR(p.txdate) AS VARCHAR(4))) T PIVOT (sum(T .Qty) FOR [Year] IN ([2017], [2018], [2019], [2020])) AS P LEFT JOIN
                  ICC_NEW.dbo.StkItem T ON T .ucIIitemstyle = P.ItemStyleCode
GROUP BY P.ItemStyleCode, P.[2017], P.[2018], P.[2019], P.[2020], T .ulIIClassification;