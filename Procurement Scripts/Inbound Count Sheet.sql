/****** Script for SelectTopNRows command from SSMS  ******/

 Declare @ColName varchar(10)
 Set @ColName = 'Count'

SELECT 	    T1.Item_Code,
			T1.Item_Description,
			T1.Open_Qty,
			
			Case
			When T1.Count1_Status = 'Pending Approval' THEN T1.Count1
			When T1.Count2_Status = 'Pending Approval' THEN T1.Count2
			When T1.Count3_Status = 'Pending Approval' THEN T1.Count3
		    End as 'Count' 	,
			Case
			When T1.Count1_Status = 'Pending Approval' THEN (T1.Open_Qty - T1.Count1 )
			When T1.Count2_Status = 'Pending Approval' THEN (T1.Open_Qty -T1.Count2)
			When T1.Count3_Status = 'Pending Approval' THEN (T1.Open_Qty -T1.Count3)
		    End as 'Count Variance' 		 
  FROM [ICC_APP].[dbo].[Inbound_Header] T0
  inner join [ICC_APP].[dbo].Inbound_Lines T1
  on T0.ID = T1.Link
  Where T0.Status = 'O' and T1.Link = 36
