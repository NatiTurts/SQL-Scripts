select * from Vendor
where Account = 'PAR002'

update Vendor
set bForCurAcc = 0
where Account = 'PAR002'

update Vendor
set iCurrencyID = 0
where Account = 'PAR002'


--After allocations, run below scripts.


update Vendor
set bForCurAcc = 1
where Account = 'PAR002'

update Vendor
set iCurrencyID = 1
where Account = 'PAR002'