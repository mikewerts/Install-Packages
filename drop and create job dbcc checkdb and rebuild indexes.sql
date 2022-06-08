USE [msdb]
GO

/****** Object:  Job [CHECK DB and Rebuild Indexes]    Script Date: 3/20/2020 3:53:44 PM ******/
--EXEC msdb.dbo.sp_delete_job @job_name=N'CHECK DB and Rebuild Indexes' --@job_id=N'f8d050f1-df95-42fe-839c-17b8d8ec5217', @delete_unused_schedule=1
--GO

/* disable the old CHECK DB and Rebuild Indexes job */

EXEC dbo.sp_update_job  
    @job_name = N'CHECK DB and Rebuild Indexes',  
    @enabled = 0;  
GO 



/****** Object:  Job [CHECK DB and Rebuild Indexes]    Script Date: 3/20/2020 3:53:44 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 3/20/2020 3:53:45 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CHECK DB Rebuild Indexes Update Statistics',  
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'MEMIC1\EMJW', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [OLCC Check DB]    Script Date: 3/20/2020 3:53:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'OLCC Check DB', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=3, 
		@on_fail_action=4, 
		@on_fail_step_id=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE dbo.DatabaseIntegrityCheck @Databases = ''ALL_DATABASES'', @CheckCommands = ''CHECKDB'', @PhysicalOnly = ''Y''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [e-mail on CHECK DB fail]    Script Date: 3/20/2020 3:53:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'e-mail on CHECK DB fail', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=3, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @mailbody as nvarchar(1000) 
declare @subjserver as nvarchar(1000)
set @mailbody = ''OLCC CheckDB failed for '' + @@SERVERNAME
set @subjserver = ''OLCC CheckDB failed for '' + @@servername
EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = ''mike werts'',  
    @recipients = ''mwerts@memic.com'',   
    @body = @mailbody, 
    @subject = @subjserver;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Rebuild Reindex All Databases]    Script Date: 3/20/2020 3:53:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Rebuild Reindex All Databases', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=5, 
		@on_fail_action=4, 
		@on_fail_step_id=4, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXECUTE dbo.IndexOptimize
@Databases = ''ALL_DATABASES'',
@FragmentationLow = NULL,
@FragmentationMedium = ''INDEX_REORGANIZE,INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE'',
@FragmentationHigh = ''INDEX_REBUILD_ONLINE,INDEX_REBUILD_OFFLINE'',
@FragmentationLevel1 = 5,
@FragmentationLevel2 = 30', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [e-mail on INDEX rebuild fail]    Script Date: 3/20/2020 3:53:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'e-mail on INDEX rebuild fail', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=4, 
		@on_success_step_id=5, 
		@on_fail_action=4, 
		@on_fail_step_id=5, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @mailbody as nvarchar(1000) 
declare @subjserver as nvarchar(1000)
set @mailbody = ''The index rebuild failed for '' + @@SERVERNAME
set @subjserver = ''The index rebuild failed for '' + @@servername
EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = ''mike werts'',  
    @recipients = ''mwerts@memic.com'',   
    @body = @mailbody, 
    @subject = @subjserver;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Update Statistics]    Script Date: 3/20/2020 3:53:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Update Statistics', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=6, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'	EXECUTE dbo.IndexOptimize
	@Databases = ''USER_DATABASES'',
	@FragmentationLow = NULL,
	@FragmentationMedium = NULL,
	@FragmentationHigh = NULL,
	@UpdateStatistics = ''ALL'',
	@OnlyModifiedStatistics = ''Y'',
	@StatisticsSample = 25  ', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [e-mail on UPDATE STATISTICS fail]    Script Date: 3/20/2020 3:53:45 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'e-mail on UPDATE STATISTICS fail', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=2, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @mailbody as nvarchar(1000) 
declare @subjserver as nvarchar(1000)
set @mailbody = ''UPDATE STAISTICS failed for '' + @@SERVERNAME
set @subjserver = ''UPDATE STAISTICS failed for '' + @@servername
EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = ''mike werts'',  
    @recipients = ''mwerts@memic.com'',   
    @body = @mailbody, 
    @subject = @subjserver;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily Backup Index Reorganize', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20180421, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959 --, 
		--@schedule_uid=N'c58b9e51-1c78-4a15-bd9c-21ac500c85d3'

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


