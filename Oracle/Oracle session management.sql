
select * from v$session order by osuser;

--https://www.thegeekdiary.com/how-to-cancel-a-sql-query-in-oracle-database-18c/
select sid, serial# from v$session where sid = userenv('SID');

alter system cancel sql '420,34651';
ALTER SYSTEM KILL SESSION '774,49720';

select * from v$session where sid = userenv('SID') or machine='T-GOLISCH-L';

---long running queries
SELECT *
FROM V$SESSION_LONGOPS
WHERE OPNAME NOT LIKE '%aggregate%' AND TOTALWORK != 0 AND SOFAR <> TOTALWORK;

SELECT * FROM V$FLASH_RECOVERY_AREA_USAGE;

SELECT * FROM V$ASM_DISKGROUP;
SELECT * FROM V$ASM_ALIAS;
SELECT * FROM v$asm_file;
SELECT * FROM V$ASM_FILEGROUP;

select * from dba_indexes
where table_owner='SWIC'
ORDER BY TABLE_NAME, INDEX_NAME;

select TABLE_NAME, INDEX_NAME, LAST_ANALYZED, DEGREE, COMPRESSION
from dba_indexes
where table_owner='SWIC' AND TABLE_NAME LIKE '%PRODUCT%'
ORDER BY TABLE_NAME, INDEX_NAME;

--indexes to consider for compression
select OWNER, TABLE_NAME, INDEX_NAME, COMPRESSION, NUM_ROWS, DISTINCT_KEYS, AVG_LEAF_BLOCKS_PER_KEY, AVG_DATA_BLOCKS_PER_KEY
from dba_indexes i, user_segments us
where table_owner='SWIC' AND uniqueness='NONUNIQUE' AND INDEX_TYPE='NORMAL' AND NUM_ROWS>1000000
  and i.index_name=us.segment_name
ORDER BY AVG_LEAF_BLOCKS_PER_KEY DESC;--, NUM_ROWS DESC, DISTINCT_KEYS ASC;

SELECT * FROM user_segments WHERE SEGMENT_TYPE='INDEX' ORDER BY SEGMENT_NAME;
