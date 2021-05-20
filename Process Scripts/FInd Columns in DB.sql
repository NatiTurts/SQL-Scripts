SELECT col.name  AS 'ColumnName'--, tab.name AS 'TableName' 
, vie.name as 'view'

FROM sys.columns col

--JOIN sys.tables  tab  ON col.object_id = tab.object_id
JOIN sys.views vie on col.object_id = vie.object_id

WHERE col.name LIKE '%ulIDSOrdSalesRep%'

