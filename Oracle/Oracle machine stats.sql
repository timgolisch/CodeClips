--ram, cpu
select STAT_NAME,to_char(VALUE) as VALUE ,COMMENTS from v$osstat where stat_name IN ('NUM_CPUS','NUM_CPU_CORES','NUM_CPU_SOCKETS')
union
select STAT_NAME,VALUE/1024/1024/1024 || ' GB' ,COMMENTS from v$osstat where stat_name IN ('PHYSICAL_MEMORY_BYTES');

--oracle version
SELECT * FROM v$version;

select parameter name, value
from v$option
order by 2 desc, 1;

--features in-use
select
  name            c1,
  detected_usages c2,
  first_usage_date c3,
  currently_used  c4
from
  dba_feature_usage_statistics
where
  first_usage_date is not null; 

-----Note: The sys. schema has tons of system tables, which are good info about a database
select * from sys.user_tables;
select * from sys.user_views;
select * from sys.user_procedures order by object_name, procedure_name;
select index_name, table_name, tablespace_name, leaf_blocks, num_rows, degree, last_analyzed from sys.user_indexes order by num_rows desc;

select * from V$STATISTICS_LEVEL;
select * from V$ACTIVE_SESSION_HISTORY;
select * from V$SYS_TIME_MODEL;
select * from V$SESSION_WAIT;
select * from V$SESSION_WAIT_HISTORY;
select * from V$EVENT_HISTOGRAM;
select * from V$SYSSTAT;

--find raw queries that could run quicker if they used bind variables
SELECT SQL_TEXT FROM V$SQLSTATS WHERE EXECUTIONS < 4 ORDER BY SQL_TEXT;
--find slow queries (greater than 2 sec)
SELECT cpu_time, elapsed_time, avg_hard_parse_time, cluster_wait_time, application_wait_time, user_io_wait_time, fetches, executions, sql_text
FROM V$SQLSTATS WHERE elapsed_time>2000 ORDER BY elapsed_time desc;

 
select * from sys.monitor;
select * from sys.v$monitor;
