--==========================================================
-- Create DBA Database
--==========================================================
-- First, get the default paths for the data and log files  

declare @@default_data_path nvarchar(255)

select @@default_data_path = convert(nvarchar(255), SERVERPROPERTY('InstanceDefaultDataPath')) + 'DBA.mdf'

--print @@default_data_path



declare @@default_log_path nvarchar(255)

select @@default_log_path = convert(nvarchar(255), SERVERPROPERTY('InstanceDefaultLogPath')) + 'DBA_log.ldf'

--print @@default_log_path

declare @create_database nvarchar(max)

= 'CREATE DATABASE [DBA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N''DBA'', FILENAME = '''+@@default_data_path+''' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N''DBA_log'', FILENAME = '''+@@default_log_path+''' , SIZE = 8192KB , FILEGROWTH = 65536KB )
'

--print @create_database

if not exists (select name from sys.sysdatabases where name = 'DBA') 
begin
exec sp_executesql @create_database
end

--( NAME = N'DBA', FILENAME = @@default_data_path+'DBA.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
-- LOG ON 
--( NAME = N'DBA_log', FILENAME = @@default_log_path+'DBA_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DBA] SET COMPATIBILITY_LEVEL = 130
GO
ALTER DATABASE [DBA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBA] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBA] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [DBA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBA] SET  READ_WRITE 
GO
ALTER DATABASE [DBA] SET RECOVERY FULL 
GO
ALTER DATABASE [DBA] SET  MULTI_USER 
GO
ALTER DATABASE [DBA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBA] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DBA]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [DBA]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DBA] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

ALTER DATABASE [DBA] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBA] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBA] SET RECOVERY FULL 
GO
ALTER DATABASE [DBA] SET  MULTI_USER 
GO
ALTER DATABASE [DBA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBA] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DBA', N'ON'
GO
ALTER DATABASE [DBA] SET QUERY_STORE = OFF
GO
USE [DBA]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

USE [DBA]
GO
/****** Object:  User [MEMIC1\svc_appd]    Script Date: 7/2/2021 11:54:04 AM ******/
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'MEMIC1\svc_appd')
CREATE USER [MEMIC1\svc_appd] FOR LOGIN [MEMIC1\svc_appd] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_datareader] ADD MEMBER [MEMIC1\svc_appd]
GO
/****** Object:  UserDefinedFunction [dbo].[GetJobIdFromProgramName]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[GetJobIdFromProgramName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[GetJobIdFromProgramName] (

	@program_name nvarchar(128)

)

RETURNS uniqueidentifier

AS

BEGIN

DECLARE @start_of_job_id int

SET @start_of_job_id = CHARINDEX(''(Job 0x'', @program_name) + 7

RETURN CASE WHEN @start_of_job_id > 0 THEN CAST(

		SUBSTRING(@program_name, @start_of_job_id + 06, 2) + SUBSTRING(@program_name, @start_of_job_id + 04, 2) +

		SUBSTRING(@program_name, @start_of_job_id + 02, 2) + SUBSTRING(@program_name, @start_of_job_id + 00, 2) + ''-'' +

		SUBSTRING(@program_name, @start_of_job_id + 10, 2) + SUBSTRING(@program_name, @start_of_job_id + 08, 2) + ''-'' +

		SUBSTRING(@program_name, @start_of_job_id + 14, 2) + SUBSTRING(@program_name, @start_of_job_id + 12, 2) + ''-'' +

		SUBSTRING(@program_name, @start_of_job_id + 16, 4) + ''-'' +

		SUBSTRING(@program_name, @start_of_job_id + 20,12) AS uniqueidentifier)

	ELSE NULL

	END

END --FUNCTION' 
END
GO
/****** Object:  Table [dbo].[SQL_monitoring]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[SQL_monitoring]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[SQL_monitoring](
	[record_id] [int] NULL,
	[timestamp] [bigint] NULL,
	[Event Time] [datetime] NULL,
	[SQL Server Process CPU Utilization] [int] NULL,
	[System Idle Process] [int] NULL,
	[Other Process CPU Utilization] [int] NULL,
	[record] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  View [dbo].[vw_get_CPU_by_minute]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[vw_get_CPU_by_minute]'))
EXEC dbo.sp_executesql @statement = N'/****** Script for SelectTopNRows command from SSMS  ******/
create view [dbo].[vw_get_CPU_by_minute]
as
(

SELECT --TOP (1000) 

[record_id]
      ,[timestamp]
	  --,CONVERT(NVARCHAR(10), [timestamp], 101) 
   --    + '' '' + CONVERT(NVARCHAR(8), [timestamp], 108)

, FORMAT( [Event Time] , ''MM/dd/yyyy HH:mm'') as hh_mm
	  
      ,[Event Time]
      ,[SQL Server Process CPU Utilization]
      ,[System Idle Process]
      ,[Other Process CPU Utilization]
      ,[record]
  FROM [DBA].[dbo].[SQL_monitoring]
)
 -- order by [Event Time] desc' 
GO
/****** Object:  Table [dbo].[All_SQL_Queries]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[All_SQL_Queries]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[All_SQL_Queries](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[event_name] [nvarchar](max) NULL,
	[Actual_Time] [datetime2](7) NULL,
	[session_server_principal_name] [varchar](max) NULL,
	[session_id] [int] NULL,
	[objectname] [varchar](max) NULL,
	[SQL_Statement] [varchar](max) NULL,
	[wait_type_duration_ms] [bigint] NULL,
	[wait_type_cpu_time_ms] [bigint] NULL,
	[client] [varchar](max) NULL,
 CONSTRAINT [PK_CommandLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[capture_blocking_data]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[capture_blocking_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[capture_blocking_data](
	[targetdata] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[capture_waits_data]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[capture_waits_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[capture_waits_data](
	[targetdata] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CommandLog]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[CommandLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[CommandLog](
	[ID] [int] NOT NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[SchemaName] [nvarchar](128) NULL,
	[ObjectName] [nvarchar](128) NULL,
	[ObjectType] [char](2) NULL,
	[IndexName] [nvarchar](128) NULL,
	[IndexType] [tinyint] NULL,
	[StatisticsName] [nvarchar](128) NULL,
	[PartitionNumber] [int] NULL,
	[ExtendedInfo] [xml] NULL,
	[Command] [nvarchar](max) NOT NULL,
	[CommandType] [nvarchar](60) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[ErrorNumber] [int] NULL,
	[ErrorMessage] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[hourly_waits_data]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[hourly_waits_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[hourly_waits_data](
	[event_name] [nvarchar](max) NULL,
	[Actual_Time] [datetime2](7) NULL,
	[session_server_principal_name] [varchar](max) NULL,
	[session_id] [int] NULL,
	[objectname] [varchar](max) NULL,
	[SQL_Statement] [varchar](max) NULL,
	[wait_type_duration_ms] [bigint] NULL,
	[wait_type_cpu_time_ms] [bigint] NULL,
	[client] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[import_daily_blocking_data]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[import_daily_blocking_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[import_daily_blocking_data](
	[TimeStamp (UTC)] [datetime2](7) NULL,
	[Database Name] [sysname] NOT NULL,
	[Username] [sysname] NOT NULL,
	[Transaction ID] [bigint] NULL,
	[Lock Mode] [sysname] NOT NULL,
	[Duration (ms)] [bigint] NULL,
	[Blocked Query] [sysname] NOT NULL,
	[Wait Resource] [sysname] NOT NULL,
	[Blocking Query] [sysname] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[import_daily_waits_data]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[import_daily_waits_data]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[import_daily_waits_data](
	[event_name] [nvarchar](max) NULL,
	[Actual_Time] [datetime2](7) NULL,
	[session_server_principal_name] [varchar](max) NULL,
	[session_id] [int] NULL,
	[objectname] [varchar](max) NULL,
	[SQL_Statement] [varchar](max) NULL,
	[wait_type_duration_ms] [bigint] NULL,
	[wait_type_cpu_time_ms] [bigint] NULL,
	[client] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[logSpaceStats]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[logSpaceStats]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[logSpaceStats](
	[id] [int] NOT NULL,
	[logDate] [datetime] NULL,
	[databaseName] [nvarchar](128) NOT NULL,
	[logSize] [decimal](18, 5) NULL,
	[logUsed] [decimal](18, 5) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Long_Running_Queries]    Script Date: 7/2/2021 11:54:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[Long_Running_Queries]') AND type in (N'U'))
BEGIN
CREATE TABLE [DBA].[dbo].[Long_Running_Queries](
	[Collection Date] [datetime] NOT NULL,
	[Execution Count] [bigint] NOT NULL,
	[Query Text] [nvarchar](max) NULL,
	[Complied Query DB Name] [nvarchar](128) NULL,
	[Ad Hoc Query DB Name] [nvarchar](128) NULL,
	[creation_time] [datetime] NOT NULL,
	[last_execution_time] [datetime] NOT NULL,
	[Total CPU Time] [bigint] NOT NULL,
	[Avg CPU Time (ms)] [bigint] NULL,
	[Total Physical Reads] [bigint] NOT NULL,
	[Avg Physical Reads] [bigint] NULL,
	[Total Logical Reads] [bigint] NOT NULL,
	[Avg Logical Reads] [bigint] NULL,
	[Total Logical Writes] [bigint] NOT NULL,
	[Avg Logical Writes] [bigint] NULL,
	[Total Duration] [bigint] NOT NULL,
	[Avg Duration (ms)] [bigint] NULL,
	[Plan] [xml] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Table [dbo].[get_xp_logininfo]    Script Date: 12/21/2021 11:28:35 AM ******/


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[get_xp_logininfo]') AND type in (N'U'))
Begin

CREATE TABLE [DBA].[dbo].[get_xp_logininfo](
	[account name] [sysname] NOT NULL,
	[type] [char](8) NULL,
	[privilege] [char](9) NULL,
	[mapped login name] [sysname] NOT NULL,
	[permission path] [sysname] NULL
) ON [PRIMARY]
end
GO
/****** Object:  Table [dbo].[Long_SQL_Blocks]    Script Date: 7/2/2021 11:54:04 AM ******/

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[Long_SQL_Blocks]') AND type in (N'U'))
Begin
CREATE TABLE [DBA].[dbo].[Long_SQL_Blocks](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TimeStamp (UTC)] [datetime2](7) NULL,
	[Database Name] [sysname] NULL,
	[Username] [sysname] NULL,
	[Transaction ID] [bigint] NULL,
	[Lock Mode] [sysname] NULL,
	[Duration (ms)] [bigint] NULL,
	[Blocked Query] [sysname] NULL,
	[Wait Resource] [sysname] NULL,
	[Blocking Query] [sysname] NULL,
 CONSTRAINT [PK_BlocksID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
end
GO
/****** Object:  Index [ix_All_SQL_Queries]    Script Date: 7/2/2021 11:54:04 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[All_SQL_Queries]') AND name = N'ix_All_SQL_Queries')
CREATE NONCLUSTERED INDEX [ix_All_SQL_Queries] ON [DBA].[dbo].[All_SQL_Queries]
(
	[Actual_Time] ASC,
	[wait_type_duration_ms] ASC
)
INCLUDE([event_name],[session_server_principal_name],[session_id],[objectname],[SQL_Statement],[wait_type_cpu_time_ms],[client]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_hourly_waits_data]    Script Date: 7/2/2021 11:54:05 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[hourly_waits_data]') AND name = N'ix_hourly_waits_data')
CREATE NONCLUSTERED INDEX [ix_hourly_waits_data] ON [DBA].[dbo].[hourly_waits_data]
(
	[Actual_Time] ASC
)
INCLUDE([event_name],[session_server_principal_name],[session_id],[objectname],[SQL_Statement],[wait_type_duration_ms],[wait_type_cpu_time_ms],[client]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_import_daily_waits_data]    Script Date: 7/2/2021 11:54:05 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[import_daily_waits_data]') AND name = N'ix_import_daily_waits_data')
CREATE NONCLUSTERED INDEX [ix_import_daily_waits_data] ON [DBA].[dbo].[import_daily_waits_data]
(
	[Actual_Time] ASC	
)
INCLUDE([event_name],[session_server_principal_name],[session_id],[objectname],[SQL_Statement],[wait_type_duration_ms],[wait_type_cpu_time_ms],[client]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ix_Long_SQL_Blocks]    Script Date: 7/2/2021 11:54:05 AM ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[Long_SQL_Blocks]') AND name = N'ix_Long_SQL_Blocks')
CREATE NONCLUSTERED INDEX [ix_Long_SQL_Blocks] ON [DBA].[dbo].[Long_SQL_Blocks]
(
	[TimeStamp (UTC)] ASC
)
INCLUDE([Database Name],[Username],[Transaction ID],[Lock Mode],[Duration (ms)],[Blocked Query],[Wait Resource],[Blocking Query]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[Cleanup_TableByID]    Script Date: 7/2/2021 11:54:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DBA].[dbo].[Cleanup_TableByID]') AND type in (N'P', N'PC'))
BEGIN
use [DBA]
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Cleanup_TableByID] AS' 
END
GO


ALTER PROCEDURE [dbo].[Cleanup_TableByID]
    @DbName nvarchar(128),
    @SchemaName nvarchar(128) = 'dbo',
    @TableName nvarchar(128),
    @DateColumnName nvarchar(128),
    @IDColumnName nvarchar(128),
    @RetainDays int = 180,
    @ChunkSize int = 5000,
    @LoopWaitTime time = '00:00:00.5',
    @Debug bit = 0
AS
/*************************************************************************************************
AUTHOR: Andy Mallon
CREATED: 20171012
    This procedure cleans up data in the specified database & table.
    This procedure requires that the table have an ID column, AND some sort of date/time column.
    The ID is used for efficiency when doing deletes, and the date/time column is needed to
    determine when data ages out. 
        **The date/time column should be the date inserted**
          The code assumes that both the ID & date/time columns are ever-increasing.
    This includes two controls to help minimize blocking and prevent the transaction log from
    growing during a large data cleanup. These two params can be adjusted to fine-tune the cleanup
       @ChunkSize controls how the max size of each delete operation.
       @LoopWaitTime introduces a wait between each delete to throttle activity between log backups
    KNOWN LIMITATION: If you reseed the identity column back to 0, you're going to delete all
        your data. All of it. Don't do that.
PARAMETERS
* @DbName         - Name of the database containing the table
* @SchemaName     - Name of the schema containing the table
* @TableName      - Table to be cleaned up
* @DateColumnName - Name of the date/time column to be used to determine cleanup
* @IDColumnName   - Name of the IDENTITY column, to be used for Chunking of deletes
* @RetainDays     - Number of days to retain data before cleaning up
* @ChunkSize      - Number of rows to delete in each batch
* @LoopWaitTime   - Time to wait after each delete. 
* @Debug          - Print DELETE statements instead of actually deleting.
**************************************************************************************************
MODIFICATIONS:
    YYYYMMDD - 
**************************************************************************************************
     This code is licensed as part of Andy Mallon's DBA Database.
    https://github.com/amtwo/dba-database/blob/master/LICENSE
   -- 
*************************************************************************************************/
SET NOCOUNT ON;

DECLARE @MaxID bigint;
DECLARE @ChunkID bigint;
DECLARE @Sql nvarchar(max);

--Shuffle this into datetime datatype to make WAITFOR DELAY happy. Still use time on the param for better validation
DECLARE @LoopWaitDateTime datetime = @LoopWaitTime;
--Plop the quoted DB.Schema.Table into one variable so I don't screw it up later.
DECLARE @SqlObjectName nvarchar(386) = QUOTENAME(@DbName) + N'.' + QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName);

--
-- Get the range of ID values we want to delete
--
SELECT @sql = N'SELECT @ChunkID = MIN(' + QUOTENAME(@IDColumnName) + N'), @MaxID = MAX(' + QUOTENAME(@IDColumnName) + N') FROM ' + @SqlObjectName + N' WHERE ' + QUOTENAME(@DateColumnName) + ' < DATEADD(DAY,-1*@RetainDays,GETDATE());';

IF @Debug = 1
BEGIN
    PRINT @sql;
END;
-- Even in Debug mode, we run this to get min/max values. We're not changing data yet.
EXEC sp_executesql @stmt = @sql, @params = N'@RetainDays int, @ChunkID bigint OUT, @MaxID bigint OUT', @RetainDays = @RetainDays, @ChunkID = @ChunkID OUT, @MaxID = @MaxID OUT;

--
--Now loop through those values and delete 
--
WHILE @ChunkID < @MaxID
    BEGIN 
        SELECT @ChunkID = @ChunkID + @ChunkSize;
        
        SELECT @sql = N'DELETE TOP (@ChunkSize) x FROM ' + @SqlObjectName + N' AS x WHERE x.' + QUOTENAME(@IDColumnName) + N' < @ChunkID AND x.' + QUOTENAME(@IDColumnName) + N' < @MaxID;'
        --if we're not in debug mode, then run the delete
        IF @Debug = 0
            BEGIN
                EXEC sp_executesql @stmt = @sql, @params = N'@ChunkSize int, @ChunkID bigint, @MaxID bigint', @ChunkSize = @ChunkSize, @ChunkID = @ChunkID, @MaxID = @MaxID;
                WAITFOR DELAY @LoopWaitDateTime;
            END;
        --if we're in debug mode, just print the DELETE statement
        ELSE
            BEGIN
                PRINT @sql;
            END;
    END;
GO



Print 'DBA Database Built'
