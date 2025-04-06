USE [master]
GO

RESTORE DATABASE [AdventureWorks2022] 
FROM DISK = N'/var/opt/mssql/backup/AdventureWorks2022.bak' 
WITH 
  MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/AdventureWorks2022.mdf',
  MOVE 'AdventureWorks2022_log' TO '/var/opt/mssql/data/AdventureWorks2022_log.ldf',
  RECOVERY, REPLACE, STATS = 5;
GO

ALTER DATABASE [AdventureWorks2022] SET RECOVERY SIMPLE;
GO