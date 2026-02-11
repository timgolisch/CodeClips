--analyze current indexes, focus on the biggest
select * from sys.user_indexes order by num_rows desc;

--note: tables with small # distinct_keys will benefit more from indexing and clustering
select index_name, table_name, tablespace_name, leaf_blocks, num_rows, 
    distinct_keys, clustering_factor, degree, last_analyzed 
from sys.user_indexes order by num_rows desc;

--find some big tables
select * from sys.user_tables order by num_rows desc;
select table_name, tablespace_name, num_rows, avg_row_len, degree, sample_size, last_analyzed from sys.user_tables order by num_rows desc;
--select * from SYS.USER_TAB_SIZES;

--alter index ... rebuild
/*
  CREATE or replace INDEX SWIC.IEBI_CB_I ON SWIC.I_EBT_BENEFITS_ISSUED (CREATED_BY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  STORAGE(INITIAL 1342177280 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE SWIC9I_INDEX 
  PARALLEL 4 ;
*/
/*
commit;
rollback;
*/