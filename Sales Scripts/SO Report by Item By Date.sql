Declare @Date datetime = getdate()
Declare @Item varchar(max) = '157'

select h.ordernum[OrderNumber],h.orderdate[OrderDate],st.code[ItemCode], st.description_1[ItemDescription], l.fquantity[QtyOrdered], l.fqtyreserved[QtyReserved], l.fqtyprocessed[QtyProcessed],*
from invnum h
left join _btblinvoicelines l on h.autoindex = l.iinvoiceid
left join stkitem st on st.stocklink = l.istockcodeid
where h.orderdate = @Date and doctype in (4,6) and h.docstate in (1,3) and st.code like '%'+@Item+'%'
