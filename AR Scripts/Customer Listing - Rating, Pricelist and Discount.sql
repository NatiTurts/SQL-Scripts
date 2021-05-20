Test

Select
  C.Account as Account_Code
, C.Name as Account_Name
, C.uiARStarrating as Loyalty_Rating
, C.PriceListName as Pricelist
, CASE when C.uiARStarrating = '5' Then '10'
	   when C.uiARStarrating = '4' Then '7.5'
	   when C.uiARStarrating = '3' Then '5'
	   when C.uiARStarrating = '2' Then '0'
	   when C.uiARStarrating = '1' Then '0'
	   when C.uiARStarrating = '0' Then '0'
	   End as Discount	   
from .dbo._bvARAccountsFull C
group by C.Account, C.Name, C.uiARStarrating, C.PriceListName
