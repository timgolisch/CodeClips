SELECT SQL_TEXT FROM V$SQLSTATS WHERE EXECUTIONS < 4 ORDER BY SQL_TEXT;

SELECT cpu_time, elapsed_time, avg_hard_parse_time, cluster_wait_time, application_wait_time, user_io_wait_time, fetches, executions, sql_text
FROM V$SQLSTATS;-- WHERE EXECUTIONS < 4 ORDER BY SQL_TEXT;
 
