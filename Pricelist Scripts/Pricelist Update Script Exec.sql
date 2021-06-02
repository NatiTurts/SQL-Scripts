exec usp_UpdatePriceList	[PricelistID] , [StockID]] , [ExclPrice]

select * from [_etblPriceListPrices] where iStockID in ('38831') and iPriceListNameID = '11'