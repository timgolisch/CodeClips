SELECT
	NULL AS [Text],
	ISNULL(smsp.definition, ssmsp.definition) AS [Definition]
FROM
	sys.all_objects AS sp
	LEFT OUTER JOIN sys.sql_modules AS smsp ON smsp.object_id = sp.object_id
	LEFT OUTER JOIN sys.system_sql_modules AS ssmsp ON ssmsp.object_id = sp.object_id
WHERE
	--(sp.type = @_msparam_0 OR sp.type = @_msparam_1 OR sp.type=@_msparam_2)
	--and
	sp.name=N'ExampleCreate' and SCHEMA_NAME(sp.schema_id)=N'dbo'

