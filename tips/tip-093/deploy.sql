-- to be deployed as a Streamlit App with: snowsql -c my_conn -f deploy.sql
use schema test.public;

create or replace stage tip_093_stage;

put file://.\faker-sis.py @tip_093_stage overwrite=true auto_compress=false;
put file://.\environment.yml @tip_093_stage overwrite=true auto_compress=false;

create or replace streamlit tip_093_app
    root_location = '@test.public.tip_093_stage'
    main_file = '/faker-sis.py'
    query_warehouse = 'COMPUTE_WH';
show streamlits;