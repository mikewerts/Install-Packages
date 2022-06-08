


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

USE [msdb]
GO
ALTER ROLE [db_datareader] ADD MEMBER [pritops]
GO


