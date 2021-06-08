Select
  M.Model_Number					as	[Model Number]
, S.ucIIitemstyle					as	[Parent Code]
, M.Description						as	[Parent Description]
, M.Category						as	[Category]
, M.Classification					as	[Classification]
, M.Planning_Status					as	[Planning]
, SUM(M.Year1)						as	[2017]
, SUM(M.Year2)						as	[2018]
, SUM(M.Year3)						as	[2019]
, AVG(M.Year3_vs_Year2_Growth)		as	[Growth]
, SUM(M.SOH)						as	[SOH]
, SUM(M.WIP)						as	[WIP]
, AVG(M.Average_Cost)				as	[Average Cost]
, SUM(M.Average_Consumption)		as	[Average Consumption]
, SUM(M.SOH)*AVG(M.Average_Cost)		as	[SOH Valuation]
from [Database].dbo.StockModelling_Lines M
inner join [Database].dbo.StkItem S on S.code = M.ItemStyleCode
WHERE M.Model_Number IN (SELECT max(M.Model_Number) From [Database].dbo.StockModelling_Lines M)
group by M.Model_Number, S.ucIIitemstyle, M.Description, M.Category, M.Classification, M.Planning_Status