/*
 *  Create Database Change Log table
 *  Usage: run this against any Database to detect and track any DDL changes within that database
 */


IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'Log')
EXEC sys.sp_executesql N'CREATE SCHEMA [Log] AUTHORIZATION [dbo]'

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [Log].[DatabaseChangeLog](
	[ChangeLogID] [int] IDENTITY(1,1) NOT NULL,
	[ChangeDate] [datetime] NOT NULL CONSTRAINT [DF_EventsLog_EventDate]  DEFAULT (getdate()),
	[LoginID] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DatabaseName] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EventType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ObjectName] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ObjectType] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SQLCommand] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_DatabaseChangeLog] PRIMARY KEY CLUSTERED 
(
	[ChangeLogID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
go

/*
 *  Create Database Change Log Trigger
 */

CREATE TRIGGER trigObjectChanges ON DATABASE 
	FOR create_procedure, alter_procedure, drop_procedure,
		create_table, alter_table, drop_table,
		create_function, alter_function, drop_function,
		create_view, alter_view, drop_view,
		create_index, alter_index, drop_index
AS 
	SET NOCOUNT ON

	DECLARE @Data xml
	SET @Data = EVENTDATA()

	INSERT INTO Log.DatabaseChangeLog
	(
		LoginID
	,	DatabaseName
	,	EventType
	,	ObjectName
	,	ObjectType
	,	SqlCommand
	)
	VALUES
	(
		@Data.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(256)')
	,	@Data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(256)')
	,	@Data.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)')
	,	@Data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(256)')
	,	@Data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(25)') 
	,	@Data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(max)')
	)
go
