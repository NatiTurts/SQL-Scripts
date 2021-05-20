select 
CLI.Account COLLATE Latin1_General_CI_AS as [Account], CLI.Name COLLATE Latin1_General_CI_AS as [CustomerName], 
SLP.Code COLLATE Latin1_General_CI_AS as [RepCode], SLP.Name COLLATE Latin1_General_CI_AS as [RepName] , PST.ActualSalesValue, PST.ActualQuantity,
   PST.Profit ,  PST.ProfitPerc, DateName( month ,[PAR].[TxDate]) as 'Month' ,YEAR([PAR].[TxDate]) as 'Year' from
(((((([The_Industrial_Clothing_Company].[dbo].[_bvARTransactionsFull] PAR
LEFT JOIN [The_Industrial_Clothing_Company].[dbo].[_bvSTTransactionsFull] PST
  ON PAR.[cAuditNumber] = PST.[cAuditNumber])
LEFT JOIN [The_Industrial_Clothing_Company].[dbo].[Client] CLI
  ON PAR.[AccountLink] = CLI.[DCLink])
LEFT JOIN [The_Industrial_Clothing_Company].[dbo].[SalesRep] SLP
  ON PAR.[RepID] = SLP.[idSalesRep])
LEFT JOIN [The_Industrial_Clothing_Company].[dbo].[Areas] ARS
  ON CLI.[iAreasID] = ARS.[idAreas])
LEFT JOIN [The_Industrial_Clothing_Company].[dbo].[CliClass] CLC
  ON CLI.[iClassID] = CLC.[IdCliClass])
LEFT JOIN [The_Industrial_Clothing_Company].[dbo].[StkItem] STK
ON STK.[StockLink] = PST.[AccountLink] 
LEFT JOIN [The_Industrial_Clothing_Company].[dbo]. [TrCodes] TRC
  ON PAR.[TrCodeID] = TRC.[idTrCodes])
WHERE (CASE WHEN [PST].[AutoIdx] is NULL THEN [PAR].[TxDate] ELSE [PST].[TxDate] END) >= '2018-01-01' AND (CASE WHEN [PST].[AutoIdx] is NULL THEN [PAR].[TxDate] ELSE [PST].[TxDate] END) <= '2018-05-31'

UNION ALL

select 
CLI.Account COLLATE Latin1_General_CI_AS as [Account], CLI.Name COLLATE Latin1_General_CI_AS as [CustomerName], 
SLP.Code COLLATE Latin1_General_CI_AS as [RepCode], SLP.Name COLLATE Latin1_General_CI_AS as [RepName] , PST.ActualSalesValue, PST.ActualQuantity,
   PST.Profit ,  PST.ProfitPerc,DateName( month ,[PAR].[TxDate]) as 'Month' ,YEAR([PAR].[TxDate]) as 'Year' from
(((((([ICC_NEW].[dbo].[_bvARTransactionsFull] PAR
LEFT JOIN [ICC_NEW].[dbo].[_bvSTTransactionsFull] PST
  ON PAR.[cAuditNumber] = PST.[cAuditNumber])
LEFT JOIN [ICC_NEW].[dbo].[Client] CLI
  ON PAR.[AccountLink] = CLI.[DCLink])
LEFT JOIN [ICC_NEW].[dbo].[SalesRep] SLP
  ON PAR.[RepID] = SLP.[idSalesRep])
LEFT JOIN [ICC_NEW].[dbo].[Areas] ARS
  ON CLI.[iAreasID] = ARS.[idAreas])
LEFT JOIN [ICC_NEW].[dbo].[CliClass] CLC
  ON CLI.[iClassID] = CLC.[IdCliClass])
LEFT JOIN [ICC_NEW].[dbo].[StkItem] STK
ON STK.[StockLink] = PST.[AccountLink] 
LEFT JOIN [ICC_NEW].[dbo]. [TrCodes] TRC
  ON PAR.[TrCodeID] = TRC.[idTrCodes])
WHERE (CASE WHEN [PST].[AutoIdx] is NULL THEN [PAR].[TxDate] ELSE [PST].[TxDate] END) >= '2018-06-01' AND (CASE WHEN [PST].[AutoIdx] is NULL THEN [PAR].[TxDate] ELSE [PST].[TxDate] END) <= '2018-12-31'
