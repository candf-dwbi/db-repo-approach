create view v_snf_customer as
select * 
  from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER"
 where c_mktsegment in ('AUTOMOBILE', 'MACHINERY', 'FURNITURE')
;