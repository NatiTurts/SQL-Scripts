SELECT cr.CompanyRuleCode
 , e.EmployeeCode
 from Employee.EmployeeRule ER 
 LEFT JOIN (SELECT EPP.EmployeeRuleID 
 from Employee.EmployeePayPeriod EPP 
 JOIN Company.PayPeriodGen PPG 
 on EPP.PayPeriodGenID = PPG.PayPeriodGenID 
 Where PPG.PeriodStatus = 'L') PER 
 on ER.EmployeeRuleID = PER.EmployeeRuleID 
 JOIN Company.CompanyRule cr
 ON cr.CompanyRuleID = er.CompanyRuleID 
 JOIN Employee.Employee e
 ON e.EmployeeID = er.EmployeeID
 where PER.EmployeeRuleID IS NULL