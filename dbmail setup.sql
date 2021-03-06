USE [msdb]
GO
EXEC master.dbo.sp_MSsetalertinfo @failsafeoperator=N'Admin', 
		@notificationmethod=3, 
		@pagersendsubjectonly=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, 
		@databasemail_profile=N''
GO


USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @sqlserver_restart=1, 
		@monitor_autostart=1, 
		@errorlogging_level=7
GO

USE [msdb]
GO

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, 
		@databasemail_profile=N'Administrator', 
		@use_databasemail=1
GO

/* now set log retention */

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1
GO

USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @jobhistory_max_rows=10000, 
		@jobhistory_max_rows_per_job=1000, 
		@email_save_in_sent_folder=1
GO
