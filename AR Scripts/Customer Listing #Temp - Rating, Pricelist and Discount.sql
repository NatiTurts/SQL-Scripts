Create table #Temp
(
	Account_Code varchar(max),
	Account_Name varchar(max),
	Loyalty_Rating int,
	Discount nvarchar(max),
	Pricelist varchar(max),
)

Insert Into #Temp

select
  A.Account as Account_Code
, A.Name as Account_Name
, C.uiARStarrating as Loyalty_Rating
, CASE when C.uiARStarrating = '5' Then '10'
	   when C.uiARStarrating = '4' Then '7.5'
	   when C.uiARStarrating = '3' Then '5'
	   when C.uiARStarrating = '2' Then '0'
	   when C.uiARStarrating = '1' Then '0'
	   when C.uiARStarrating = '0' Then '0'
	   End as Discount
, CASE when C.iARPriceListNameID = '3' Then 'ACC-F.C'
	   when C.iARPriceListNameID = '4' Then 'COUNTER-B.C'
	   when C.iARPriceListNameID = '5' Then 'COUNTER-F.C'
	   when C.iARPriceListNameID = '6' Then 'ACC-B.C'
	   when C.iARPriceListNameID = '8' Then 'FACTORYPRICE'
	   when C.iARPriceListNameID = '9' Then 'FOREIGN'
	   when C.iARPriceListNameID = '10' Then 'COOPS'
	   End as Pricelist
from ICC_NEW.dbo._bvARAccountsFull C
inner join ICC_NEW.dbo._bvCCCustomer A on A.Account = C.Account
group by A.Account, A.Name, C.uiARStarrating, C.iARPriceListNameID

select *
from #Temp
	   

If(OBJECT_ID('tempdb..#temp') Is Not Null)
Begin
    Drop Table #Temp
End




