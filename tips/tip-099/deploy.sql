-- to be deployed as a Streamlit App with: snowsql -c my_conn -f deploy.sql
use schema test.public;

create or replace stage tip_099_stage;

put file://.\faker-sis.py @tip_099_stage overwrite=true auto_compress=false;
put file://.\environment.yml @tip_099_stage overwrite=true auto_compress=false;

create or replace streamlit tip_099_app
    root_location = '@test.public.tip_099_stage'
    main_file = '/faker-sis.py'
    query_warehouse = 'COMPUTE_WH';
show streamlits;