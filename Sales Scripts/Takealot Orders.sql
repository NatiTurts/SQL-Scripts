SELECT 
  C.Account
, P.Reference AS [Invoice Number]
, P.Order_No AS [Order Number]
, P.ExtOrderNum as [External Order Number]
, S.Code AS ItemCode
, S.Description_1 AS ItemDescription
, C.PriceListName AS Pricelist
, P.Id as [Transaction Type]
, P.TxDate AS Date
, SUM(P.ActualQuantityInvoiced) AS Quantity
, PL.fExclPrice as [Excl]
, PL.fInclPrice as [Incl]
, SUM(P.ActualValue) AS LineSales
, Case when (PL.fInclPrice * P.ActualQuantityInvoiced) = P.ActualValue then 'True' else 'False' end as [Check]
FROM [Database].dbo._bvSTTransactionsFull AS P
LEFT JOIN [Database].dbo._bvARAccountsFull AS C ON C.DCLink = P.DrCrAccount
LEFT JOIN [Database].dbo._bvCMCustomerFull AS D ON D.Customer = C.Account
LEFT JOIN [Database].dbo._bvStockFull AS S ON S.StockLink = P.AccountLink
Inner join [Database].dbo._evPriceListPrices PL on PL.iStockID = P.AccountLink
WHERE (P.Id IN ('Inv', 'Crn', 'OInv', 'POSI', 'POSC')) and PL.iPriceListNameID = '11'
AND (P.TxDate >= @StartDate) AND (P.TxDate <= @EndDate) and P.Account = 'TAK006'
group by
 C.Account
, P.Reference
, P.Order_No
, P.ExtOrderNum
, S.Code
, S.Description_1
, C.PriceListName
, P.TxDate
, PL.fExclPrice
, PL.fInclPrice
, P.ActualQuantityInvoiced
, P.ActualValue
, P.Id