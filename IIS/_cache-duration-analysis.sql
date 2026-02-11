--1. To get a list of tables:
--select * from oracledbname.s_lookup order by lookup_name;

--2. Use the list of tables to generate this script
--ex: select 'select ''' + lookup_name + ''' as lookupname, count(*) as ct from ' + lookup_name + ' union' 
--    from oracledbname.s_lookup order by lookup_name;

--3. format it like this, and run, to find counts for each table as a list
SELECT * FROM (
  select 'TABLE1' as lookup_name, count(*) as ct from TABLE1 union 
  select 'TABLE2' as lookup_name, count(*) as ct from TABLE2 union 
  select 'TABLE3' as lookup_name, count(*) as ct from TABLE3
) a order by ct desc;