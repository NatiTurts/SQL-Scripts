alter procedure usp_UpdatePriceList(
@PriceListId int,
@StockId int,
@ExclAmount float,
@InclAmount float
)as



declare @Id int
set @Id = (select top 1 IDPriceListPrices from _evPriceListPrices where iStockID = @StockId and iPriceListNameID = @PriceListId)

if(@Id is null)
begin
--insert new record
insert into [_etblPriceListPrices]
(iPriceListNameID,iStockID,iWarehouseID,bUseMarkup,iMarkupOnCost,fMarkupRate,fExclPrice,fInclPrice,
dPLPricesTimeStamp,_etblPriceListPrices_iBranchID)
select @PriceListId,@StockId,0,0,0,0,@ExclAmount,round(@InclAmount,2),GETDATE(), NULL
--from WhseMst 
--where iWarehouseID not in('')
end
else
begin
update _evPriceListPrices set fExclPrice = @ExclAmount, fInclPrice = round(@InclAmount,2) where IDPriceListPrices = @Id
end