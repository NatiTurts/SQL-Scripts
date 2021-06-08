SELECT Database.dbo._efnStartPeriod()


IF OBJECT_ID('tempdb..#tmpTrialBal') IS NOT NULL  DROP TABLE #tmpTrialBal
if OBJECT_ID('tempdb..#Period') IS NOT NULL DROP TABLE #Period
SELECT FromPeriod=25, ToPeriod=36, StartPeriod=dbo._efnStartPeriod() INTO #Period 
select Master_Sub_Account as AccDesc,AccountLink,Master_Sub_Account,AccountLevel,Account,SubAccOfLink,Dept,Brch,Jr,[Description],cExtDescription,CaseAcc,ActiveAccount,cAccountTypeDescription as Account_Type,a.AccountTypeDescriptionOld AS Account_Type_Old,dc.AccumDebits as Debits, case when dc.AccumDebits > 0 then 0 else dc.AccumCredits end as Credits,dc.pyAccumDebits as PrevYearDebits, case when dc.pyAccumDebits > 0 then 0 else dc.pyAccumCredits end as PrevYearCredits,Master_Sub_Account  as SortByField,Master_Sub_Account  as GroupByField,case when bIsBalanceSheet=0 then 1 else 2 end as FinancialType
INTO #tmpTrialBal FROM _evGLAccountsFull a
 JOIN _etblGLAccountTypes on iAccountType = idGLAccountType
 JOIN #Period p on 1=1
 CROSS APPLY dbo._efnGLAccountAccumActual(a.AccountLink,
                                         case when bIsBalanceSheet=0 then dbo._efnPeriodYearStart(FromPeriod) else StartPeriod end, ToPeriod, -1, 0,
                                         case when bIsBalanceSheet=0 then 0 else StartPeriod end) aa
 CROSS APPLY dbo._efnGLAccountAccumActual(a.AccountLink,
                                         case when bIsBalanceSheet=0 then dbo._efnPeriodYearStart(FromPeriod-12) else StartPeriod end, ToPeriod-12, -1, 0,
                                         case when bIsBalanceSheet=0 then 0 else StartPeriod end) pyaa
 CROSS APPLY (SELECT case when bIsDebit=1 and aa.AccumActual >= 0 then aa.AccumActual
                         when bIsDebit=0 and aa.AccumActual < 0 then abs(aa.AccumActual)
                         else 0 end as AccumDebits,
                    case when bIsDebit=0 and aa.AccumActual >= 0 then aa.AccumActual
                         when bIsDebit=1 and aa.AccumActual <  0 then abs(aa.AccumActual)
                         else 0 end as AccumCredits,
                    case when bIsDebit=1 and pyaa.AccumActual >= 0 then pyaa.AccumActual
                         when bIsDebit=0 and pyaa.AccumActual < 0 then abs(pyaa.AccumActual)
                         else 0 end as pyAccumDebits,
                    case when bIsDebit=0 and pyaa.AccumActual >= 0 then pyaa.AccumActual
                         when bIsDebit=1 and pyaa.AccumActual < 0 then abs(pyaa.AccumActual)
                         else 0 end as pyAccumCredits) dc

where ((Master_Sub_Account>='5500/BA02') and (Master_Sub_Account<='5500/ZZ01')) and (((Round(aa.AccumActual,2) <> 0) or (Round(pyaa.AccumActual,2) <> 0)))


IF OBJECT_ID('tempdb..#GLNetProfitTotals') IS NOT NULL DROP TABLE #GLNetProfitTotals
CREATE TABLE #GLNetProfitTotals
(AccountLink        int,
Account             varchar(91),
Master_Sub_Account  varchar(91),
[Description]       varchar(255),
GroupByField        varchar(255),
Account_Type        varchar(50),
BSAccountType       varchar(50),
Actual              float,
ActualForeign       float,
Bud                 float,
Previous            float,
PreviousForeign     float)
DECLARE @Description varchar(91),
        @AccountType varchar(50)
SET  @Description = 'Net Profit'
SET @AccountType = (SELECT cAccountTypeDescription FROM _etblGLAccountTypes WHERE idGLAccountType = 11)
INSERT INTO #GLNetProfitTotals
SELECT -1,
        @Description,
        @Description,
        @Description,
        @Description,
        @AccountType,
        'Equity',
        SUM(case when bIsDebit = 0 then aa.AccumActual
                 when bIsDebit = 1 then -aa.AccumActual
                 end),
        SUM(case when bIsDebit = 0 then aa.AccumActualForeign
                 when bIsDebit = 1 then -aa.AccumActualForeign
                 end),
                 0,
        SUM(case when bIsDebit = 0 then case when ToPeriod-12 >= StartPeriod then pyaa.AccumActual else prev.AccumActual end
                 when bIsDebit = 1 then case when ToPeriod-12 >= StartPeriod then -pyaa.AccumActual else -prev.AccumActual end
                 end),
        SUM(case when bIsDebit = 0 then case when ToPeriod-12 >= StartPeriod then pyaa.AccumActualForeign else prev.AccumActualForeign end
                 when bIsDebit = 1 then case when ToPeriod-12 >= StartPeriod then -pyaa.AccumActualForeign else -prev.AccumActualForeign end
                 end)
FROM _evGLAccountsFull a
JOIN #Period p on 1=1
JOIN _etblGLAccountTypes AT on idGLAccountType = iAccountType
CROSS APPLY dbo._efnGLAccountAccumActual(a.AccountLink,  dbo._efnPeriodYearStart(ToPeriod), ToPeriod, -1, 0, 0) aa
CROSS APPLY dbo._efnGLAccountAccumActual(a.AccountLink,  dbo._efnPeriodYearStart(ToPeriod-12), ToPeriod-12, -1, 0, 0) pyaa -- p=previous period-12
CROSS APPLY dbo._efnGLAccPrevAccumActual(a.AccountLink, case when bIsBalanceSheet=0 then case when StartPeriod>12 then StartPeriod-12 else -ToPeriod end else -ToPeriod end, case when StartPeriod>12 then ToPeriod-12 else -1 end, -1, 0) prev
WHERE  (bIsBalanceSheet = 0)  and (Master_Sub_Account>='5500/BA02') and (Master_Sub_Account<='5500/ZZ01')
UNION ALL
SELECT -2,
        @Description + ' (Accumulated)',
        @Description + ' (Accumulated)',
        @Description + ' (Accumulated)',
        @Description + ' (Accumulated)',
        @AccountType,
        'Equity',
        SUM(case when bIsDebit = 0 then aaa.AccumActual
                 when bIsDebit = 1 then -aaa.AccumActual
                 end),
        SUM(case when bIsDebit = 0 then aaa.AccumActualForeign
                 when bIsDebit = 1 then -aaa.AccumActualForeign
                end),
                 0,
        SUM(case when bIsDebit = 0 then apyaa.AccumActual
                 when bIsDebit = 1 then -apyaa.AccumActual
                 end),
        SUM(case when bIsDebit = 0 then apyaa.AccumActualForeign
                 when bIsDebit = 1 then -apyaa.AccumActualForeign
                 end)
FROM _evGLAccountsFull a
JOIN #Period p on 1=1
JOIN _etblGLAccountTypes AT on idGLAccountType = iAccountType
CROSS APPLY dbo._efnGLAccountAccumActual(a.AccountLink, StartPeriod,  dbo._efnPeriodYearEnd(ToPeriod-12), -1, 0, 0) aaa -- p=previous period-12
CROSS APPLY dbo._efnGLAccountAccumActual(a.AccountLink, case when ToPeriod-24 < 1 then ToPeriod else StartPeriod end,  dbo._efnPeriodYearEnd(ToPeriod-24), -1, 0, 0) apyaa -- p=previous period-24

WHERE (ToPeriod >= StartPeriod+12)  and (Master_Sub_Account>='5500/BA02') and (Master_Sub_Account<='5500/ZZ01')
and bIsBalanceSheet = 0
UPDATE #GLNetProfitTotals
SET Account = REPLACE(Account, 'Profit', 'Loss'),
    Master_Sub_Account = REPLACE(Account, 'Profit', 'Loss'),
    Description = REPLACE(Account, 'Profit', 'Loss'),
    GroupByField = REPLACE(Account, 'Profit', 'Loss')
WHERE Actual < 0
INSERT INTO #tmpTrialBal(AccDesc, AccountLink, Account, Master_Sub_Account, [Description], GroupByField, SortByField, Account_Type, Jr, ActiveAccount, FinancialType,
                         Debits, Credits, PrevYearDebits, PrevYearCredits)
SELECT  Master_Sub_Account as AccDesc, AccountLink, Account, Master_Sub_Account, [Description], GroupByField, '', '', 1, 1, 2,
        case when Actual >= 0 then 0 else abs(Actual) end, case when Actual >= 0 then abs(Actual) else 0 end,
        case when Previous >= 0 then 0 else abs(Previous) end, case when Previous >= 0 then abs(Previous) else 0 end
FROM #GLNetProfitTotals
WHERE AccountLink in (-2) and ((Round(Actual, 2) <> 0) or (Round(Previous, 2) <> 0))
DROP TABLE #GLNetProfitTotals
SELECT * FROM #tmpTrialBal ORDER BY SortByField, Master_Sub_Account 
IF OBJECT_ID('tempdb..#tmpTrialBal') IS NOT NULL  DROP TABLE #tmpTrialBal
