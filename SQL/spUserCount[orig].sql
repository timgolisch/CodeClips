USE [mwc294_0038]
GO

/****** Object:  StoredProcedure [dbo].[spUserCount]    Script Date: 10/06/2011 16:53:46 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

ALTER PROCEDURE [dbo].[spUserCount]
(
	@Database varchar(255)
)
AS
	create table #myTemp (
		  spid		smallint,
		  ecid		smallint,
		  status		nchar(30),
		  loginame	nchar(128),
		  hostname	nchar(128),
		  blk		char(5),
		  dbname	nchar(128),
		  cmd		nchar(16))

	INSERT INTO #myTemp execute sp_who 

	Select loginame, hostname
	From #myTemp
	Where dbname = @Database
	GROUP BY loginame, hostname
GO

