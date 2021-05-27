--Backup
--First remove default documents

--Step 1: update tables with amended Audit Numbers and check on GUI--
update PostAP set cAuditNumber = 	'254779.0001'	Where AccountLink = 837	and	cReference2 = 'GRV42053'	and	Reference = 'SX20180418'
update PostAR set cAuditNumber = 	'254779.0001_1'	Where AccountLink = 672	and	cReference2 = 'GRV42053'	and	Reference = '18/397037'
update PostST set cAuditNumber = 	'258496.0001'	Where DrCrAccount = 672	and	cReference2 = 'GRV43537'	and	Reference = '18/401413'
update PostGL set cAuditNumber = 	'258496.0001_1'	Where DrCrAccount = 690	and	cReference2 = 'GRV43537'	and	Reference = 'SL18161'


--Step 2: Run below script--
select isnull('ALTER INDEX ' + I.name + ' ON ' + T.name + ' REBUILD;','')
as rebuild_index from sys.indexes I inner join sys.tables T 
 on I.object_id = T.object_id where I.name <> ''


--Step 3: It will give you output that looks like this: Place output into SQL query and run (Create Stored Proc or Job)--
ALTER INDEX idx_MastOffs_iChangeSetID ON MastOffs REBUILD;
ALTER INDEX idx_MastOffs_MastOffs_Checksum ON MastOffs REBUILD;
ALTER INDEX PK__etblSystemUpdate ON _etblSystemUpdate REBUILD;
ALTER INDEX idx_etblSystemUpdate_iBranchID ON _etblSystemUpdate REBUILD;
ALTER INDEX idx_etblSystemUpdate_dModifiedDate ON _etblSystemUpdate REBUILD;
--Take all of the output and run it as a query – this will rebuild all indexes on the db.  It should take around 2 hours or so. --

--Step 4: Run below script
dbcc checkdb