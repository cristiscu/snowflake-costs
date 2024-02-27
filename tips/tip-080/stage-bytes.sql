-- see https://community.snowflake.com/s/article/How-to-list-how-much-storage-is-consumed-by-the-internal-stages
declare
  res RESULTSET;
  rpt VARIANT;
  name VARCHAR;
  err varchar := '';
  total_size NUMBER;
  res_query VARCHAR DEFAULT 'select KEY STAGE_NAME,VALUE TOTAL_BYTES from table(flatten(parse_json(?))) order by 2 DESC';
  c1 cursor for select concat_ws('.', stage_catalog, stage_schema, stage_name) name 
    from snowflake.account_usage.stages 
    where stage_type = 'Internal Named' and deleted is NULL;
begin
  rpt := object_construct();
  for record in c1 do
      begin
          name := record.name;
          res := (execute immediate 'ls @' || name);
          let c2 cursor for res;
          total_size := 0;
          for inner_record in c2 do
              begin
                  total_size := total_size + inner_record."size";
              EXCEPTION 
                  WHEN OTHER THEN
                      err := concat_ws('\n', err , SQLERRM );
              end;
           end for;
           rpt := object_insert( rpt, name, total_size );
      EXCEPTION 
          WHEN OTHER THEN
              err := concat_ws('\n', err , SQLERRM );
      end;
  end for;
  res := (execute immediate :res_query using (rpt));
  return table(res);
end;