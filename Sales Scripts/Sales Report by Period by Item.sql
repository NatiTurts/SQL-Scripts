				Declare @DateStart@ date = '20181001' 
                                Declare @DateEnd@ date = '20181031' 
                                Declare @PlanningPeriod@ int = 1
                                Declare @StockCode@ varchar(MAX) = '9129' 
                                CREATE TABLE #Temp 
                                ([StockCode]  varchar(MAX), 
                                [StockDescription]  varchar(MAX), 
                                [WIP]  float, 
                                [Committed] float, 
                                [QuantityOnHand] float, 
                                [TotalMovement] float, 
                                [GRV_Qty] float, 
                                [RTS_Qty] float, 
                                [Total(GRV - RTS)] float, 
                                [CRN_Qty] float, 
                                [INV_Qty] float, 
                                [Total(INV - CRN)] float, 
                                [ConsumptionMonths] float, 
                                [AveConsumption] float, 
                                [PlanningPeriod] float, 
                                [Stock Required(Planned Period)] float, 
                                [ToOrder(Recommended)] float, 
                                [TxDate] date) 
                                INSERT INTO #Temp 
                                ([StockCode], 
                                [StockDescription], 
                                [WIP], 
                                [Committed], 
                                [QuantityOnHand], 
                                [TotalMovement], 
                                [GRV_Qty], 
                                [RTS_Qty], 
                                [Total(GRV - RTS)], 
                                [CRN_Qty], 
                                [INV_Qty], 
                                [Total(INV - CRN)], 
                                [ConsumptionMonths], 
                                [AveConsumption], 
                                [PlanningPeriod], 
                                [Stock Required(Planned Period)], 
                                [ToOrder(Recommended)], 
                                [TxDate]) 
                                Select 
                                StockCode COLLATE Latin1_General_CI_AS as [StockCode], 
                                StockDescription COLLATE Latin1_General_CI_AS as [StockDescription], 
                                WIP as [WIP], 
                                Committed as [Committed], 
                                QuantityonHand as [QuantityOnHand], 
                                sum(quantity) as [TotalMovement], 
                                sum(GRV_Qty) as [GRV_Qty], 
                                sum(RTS_Qty) as [RTS_Qty], 
                                sum([Total(GRV - RTS)]) as [Total(GRV - RTS)], 
                                sum(CRN_Qty) as [CRN_Qty], 
                                sum(INV_Qty) as [INV_Qty], 
                                sum([Total(INV - CRN)]) as [Total(INV - CRN)], 
                                ConsumptionMonths, 
                                Sum(AveConsumption) as [AveConsumption], 
                                'PlanningPeriod' = @PlanningPeriod@, 
                                Sum(AveConsumption) *[PlanningPeriod] as [Stock Required(PlannedPeriod)], 
                                case when Sum(AveConsumption)*[PlanningPeriod] + committed - (QuantityonHand + WIP) < 0 then 0 else Sum(AveConsumption) *[PlanningPeriod] + committed - (QuantityonHand + WIP) end as [ToOrder(Recommended)], 
                                min(TxDate)[TxDate] 
                                    from 
                                        (select ps.Id as [TypeofTransaction], 
                                           st.code COLLATE Latin1_General_CI_AS as [StockCode],
                                           st.Description_1 COLLATE Latin1_General_CI_AS as [StockDescription], 
                                           st.QtyOnPO as [WIP], 
                                           st.QtyOnSO as [Committed], 
                                           st.Qty_On_Hand as [QuantityonHand], 
                                           case when ps.debit = 0 then ps.Quantity  else ps.Quantity * -1 end as [Quantity], 
                                           case when Id in ('GRV', 'OGrv') then(ps.Quantity) else 0 end as [GRV_Qty], 
                                           case when Id in ('RTS') then((ps.Quantity) * -1)  else 0 end as [RTS_Qty], 
                                           case when Id in ('GRV', 'OGrv') then(ps.Quantity) 
                                           when Id in ('Rts') then((ps.Quantity) * -1)  else 0 end as [Total(GRV - RTS)], 
                                           case when Id in ('Inv', 'OInv', 'POSI') then(ps.Quantity) else 0 end as [INV_Qty], 
                                           case when Id in ('Crn', 'POSC') then((ps.Quantity) * -1)  else 0 end as [CRN_Qty], 
                                           case when Id in ('Crn', 'POSC') then((ps.Quantity) * -1) 
                                           when Id in ('Inv', 'OInv', 'POSI') then((ps.Quantity)) else 0 end as [Total(INV - CRN)], 
                                           datediff(month, @DateStart@, dateadd(day, 1, @DateEnd@)) -case when day(@DateStart@) = 1 then 0 else 1 end[ConsumptionMonths], 
                                           (case when Id in ('Inv', 'OInv', 'POSI') then(ps.Quantity) 
                                           when Id in ('Crn', 'POSC') then((ps.Quantity) * -1)  else 0 end) / (datediff(month, @DateStart@, dateadd(day, 1, @DateEnd@)) -case when day(@DateStart@)= 1 then 0 else 1 end) as [AveConsumption], 
                                           'PlanningPeriod' = @PlanningPeriod@, ps.txdate[TxDate] 
                                   from[ICC_NEW].[dbo].[postst] ps 
                                   left join[ICC_NEW].[dbo].[StkItem] st on ps.AccountLink = st.StockLink 
                                   where ps.txdate >= @DateStart@ and ps.txdate <= @DateEnd@ and id in ('Crn', 'INV', 'GRV', 'Rts', 'OInv', 'OGrv', 'POSI', 'POSC') 
                                   and st.ItemActive = 1 
                                   ) as [Sub] 
                                  group by
                                  StockCode, 
                                  StockDescription, 
                                  ConsumptionMonths, 
                                  [PlanningPeriod], 
                                  Wip, 
                                  Committed, 
                                  QuantityonHand 
                                  union all 
                                  Select 
                                  StockCode COLLATE Latin1_General_CI_AS as [StockCode], 
                                  StockDescription COLLATE Latin1_General_CI_AS as [StockDescription], 
                                  0 as [WIP], 
                                  0 as [Committed], 
                                  0 as [QuantityOnHand], 
                                  sum(quantity) as [TotalMovement], 
                                  sum(GRV_Qty) as [GRV_Qty], 
                                  sum(RTS_Qty) as [RTS_Qty], 
                                  sum([Total(GRV - RTS)]) as [Total(GRV - RTS)], 
                                  sum(CRN_Qty) as [CRN_Qty], 
                                  sum(INV_Qty) as [INV_Qty], 
                                  sum([Total(INV - CRN)]) as [Total(INV - CRN)], 
                                  ConsumptionMonths, 
                                  Sum(AveConsumption) as [AveConsumption], 
                                  'PlanningPeriod' = @PlanningPeriod@, 
                                  Sum(AveConsumption)*[PlanningPeriod] as [Stock Required(PlannedPeriod)], 
                                  case when Sum(AveConsumption)*[PlanningPeriod]+committed-(QuantityonHand+WIP) < 0 then 0 else Sum(AveConsumption)*[PlanningPeriod]+committed-(QuantityonHand+WIP) end as [ToOrder(Recommended)], 
                                  min(TxDate) 
                                     from 
                                          (select ps.Id as [TypeofTransaction], 
                                            st.code COLLATE Latin1_General_CI_AS as [StockCode], 
                                            st.Description_1 COLLATE Latin1_General_CI_AS as [StockDescription], 
                                            0 as [WIP], 
                                            0	as [Committed], 
                                            0 as [QuantityonHand], 
                                            case when ps.debit = 0 then ps.Quantity  else ps.Quantity* -1 end as [Quantity], 
                                            case when Id in ('GRV','OGrv') then(ps.Quantity) else 0 end as [GRV_Qty], 
                                            case when Id in ('RTS') then((ps.Quantity) *-1)  else 0 end as [RTS_Qty], 
                                            case when Id in ('GRV','OGrv') then(ps.Quantity) 
                                            when Id in ('Rts') then((ps.Quantity) *-1)  else 0 end as [Total(GRV - RTS)], 
                                            case when Id in ('Inv','OInv','POSI') then(ps.Quantity) else 0 end as [INV_Qty], 
                                            case when Id in ('Crn','POSC') then((ps.Quantity) *-1)  else 0 end as [CRN_Qty], 
                                            case when Id in ('Crn','POSC') then((ps.Quantity) *-1) 
                                            when Id in ('Inv','OInv','POSI') then((ps.Quantity)) else 0 end as [Total(INV - CRN)], 
                                            datediff(month, @DateStart@, dateadd(day,1, @DateEnd@))-case when day(@DateStart@)=1 then 0 else 1 end[ConsumptionMonths], 
                                            (case when Id in ('Inv','OInv','POSI') then(ps.Quantity) 
                                            when Id in ('Crn','POSC') then((ps.Quantity) *-1)  else 0 end)/(datediff(month, @DateStart@,dateadd(day,1, @DateEnd@))-case when day(@DateStart@)=1 then 0 else 1 end) as [AveConsumption], 
                                            'PlanningPeriod' = @PlanningPeriod@, TxDate 
                                from[The_Industrial_Clothing_Company].[dbo].[postst]    ps 
                                left join[The_Industrial_Clothing_Company].[dbo].[StkItem] st on ps.AccountLink = st.StockLink 
                                where   ps.txdate >= @DateStart@ and ps.txdate <= @DateEnd@ and id  in ('Crn','INV','GRV','Rts','OInv','OGrv','POSI','POSC') 
                                    and st.ItemActive = 1) as [Sub]  
				                 group by 
                                 StockCode,
                                 StockDescription, 
                                 ConsumptionMonths, 
                                 [PlanningPeriod], 
                                 Wip, 
                                 Committed, 
                                 QuantityonHand 
                                 order by 
                                 StockCode asc 
                                 SELECT distinct 
                                 StockCode COLLATE Latin1_General_CI_AS as [StockCode],  
                                 st.Description_1 COLLATE Latin1_General_CI_AS as [StockDescription],  
                                 sum(WIP) as WIP,  
                                 case when sum(Committed) <0 then 0 else sum(Committed) end as Committed,  
                                 sum(QuantityOnHand) as QuantityOnHand,                                                                  
                                 sum([Total(GRV - RTS)]) as [Total Stock Received(GRV - RTS)],                                
                                 sum([Total(INV - CRN)]) as [Total Sales(INV - CRN)]                                                                                                                                                                                   
                                 FROM #Temp  
                                 left join[ICC_NEW].[dbo].[StkItem] st on #Temp.StockCode COLLATE Latin1_General_CI_AS = st.Code COLLATE Latin1_General_CI_AS 
                                 Where StockCode like '%'+@StockCode@+'%' 
                                 Group By StockCode, st.Description_1, ConsumptionMonths, PlanningPeriod 
                                 drop table #Temp