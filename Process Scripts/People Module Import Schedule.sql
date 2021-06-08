--Step 1 - Select * from [Database].dbo._rtblBusDesig (Needed)
--Step 2 - Select * from [Database].dbo._rtblBusDept (Needed)
--Step 3 - select * from [Database].dbo._rtblPeople (Needed)
--Step 4 - Select * from [Database].dbo._rtblPeopleLinks (Needed)
Select * from [Database].dbo._smstblPeopleList
Select * from [Database].dbo._smsViewPeople
select * from [Database].dbo.Client where DCLink = '7422'
--stored Proc to identify customer code udf and place account id in link table in refrence with people ID


