Create table #Temp
(
	Account_Code varchar(max),
	Account_Name varchar(max),
	Loyalty_Rating int,
	Account_on_Hold int,
)

Insert Into #Temp

select
  C.Account as Account_Code
, C.Name as Account_Name
, C.uiARStarrating as Loyalty_Rating
, C.On_Hold as Account_on_Hold
from [Database].dbo._bvARAccountsFull C

select * from #Temp

If(OBJECT_ID('tempdb..#temp') Is Not Null)
Begin
    Drop Table #Temp
End