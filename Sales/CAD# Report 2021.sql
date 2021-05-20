SELECT 
     S.ucIIparentgroup AS [CAD#]
	, SUM(S.Qty_On_Hand) as SOH
	, SUM(S.QtyOnPO) as WIP
    , SUM(P.ActualQuantityInvoiced) AS Quantity
    , SUM(P.Cost * P.ActualQuantityInvoiced) AS Cost
    , SUM(P.ActualValue) AS Sales
    , SUM(P.ActualValue) - SUM(P.Cost * P.ActualQuantityInvoiced) AS Profit
	, ISNULL(NULLIF((SUM(P.ActualValue) - SUM(P.Cost * P.ActualQuantityInvoiced)),0)/NULLIF(SUM(P.ActualValue),0),0) as GP
FROM  ICC_NEW.dbo._bvSTTransactionsFull AS P 
LEFT OUTER JOIN ICC_NEW.dbo._bvStockFull AS S ON S.StockLink = P.AccountLink 
WHERE (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) AND (P.TxDate >= '2019-12-01') AND (P.TxDate <= '2020-11-30')
Group by S.ucIIparentgroup
