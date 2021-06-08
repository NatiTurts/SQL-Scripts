select
  S.OrderNum               as     [Order Number]
, S.cAccountName           as     [Vendor Name]
, S.DocumentStateDesc      as     [Sage Status]
, Value = (SUM(S.fQtyReserved*S.fUnitPriceExcl))
, S.OrderDate              as     [Order Date]
, case when S.AccountTerms = '0' then 'Current'
          when S.AccountTerms = '1' then '30 Days' 
          when S.AccountTerms = '2' then '60 Days'
          when S.AccountTerms = '3' then '90 Days'
          when S.AccountTerms = '4' then '120 Days'
          when S.AccountTerms = '5' then '150 Days'
          when S.AccountTerms = '6' then '180 Days'
  end as [Terms]
, case when S.On_Hold = '0' then 'Not on Hold'
             else 'On Hold'             
  end as [On Hold]
from [Database].dbo._bvSalesOrdersFull S
where S.DocumentStateDesc in ('Unprocessed', 'Partially Processed') and S.fQtyReserved>0
and S.ubIDSOrdEmbroideryorder = '0'
group by S.OrderNum, S.cAccountName, S.DocumentStateDesc, S.OrderDate, S.On_Hold, S.AccountTerms
