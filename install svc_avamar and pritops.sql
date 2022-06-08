USE [master]
GO

/****** Object:  Login [MEMIC1\svc_avamar]    Script Date: 2/11/2019 2:46:17 PM ******/
CREATE LOGIN [MEMIC1\svc_avamar] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [MEMIC1\svc_avamar]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [pritops]    Script Date: 2/11/2019 2:48:55 PM ******/
CREATE LOGIN [pritops] WITH PASSWORD=N'', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

ALTER LOGIN [pritops] ENABLE
GO



USE [msdb]
GO
create user [pritops] for login [pritops]
go

ALTER ROLE [db_datareader] ADD MEMBER [pritops]
GO


