select
*
from
	(
		select
		N.cName as PricelistName
		, P.iStockID as StockID
		, P.fExclPrice as ExclPrice
		from [Database].dbo._etblPriceListPrices P
		left join [Database].dbo._etblPriceListName N on N.IDPriceListName = P.iPriceListNameID
	)
	Piv
PIVOT(
    sum(PIV.ExclPrice)
		FOR PricelistName 
		IN(
			[0 Star], 
			[1 Star],
			[2 Star],
			[3 Star],
			[4 Star],
			[5 Star],
			[Takealot]
			)
) as Pricelist