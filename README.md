# db-repo-approach
Organization of the repository
```

scripts/                                                         #all DB scripts go here
├─ DB1/
│  ├─ schema/                                                    #all scripts for the schema are added here
│  │  ├─ tables/                                                 #scripts for tables
│  │  │  ├─ table_name/                                          #scripts for table named: "table_name"
│  │  │  │  ├─ V1.x.y_20220509110901__table_name.create.sql        #see nameing convention for the scripts - create - initial create of the table
│  │  │  │  ├─ V2.x.y_20220510131802__table_name.alter.sql         # alter any change to the "table_name"
│  │  │  │  ├─ V2.0.1_20220511142108__table_name.drop.sql          # in some release "table_name" was dropped it is to keep info that such object existed
│  │  ├─ views/                                                  #views that are create in the "schema"
│  │  │  ├─ R__view_name.sql                                     #view name created in repetable script. If there is a change than script is executed
│  │  ├─ data/                                                   #folder that contains data that msut be versioned. Data may be as insert into or selects that takes data from one object to another
│  │  │  ├─ V2.0.1_202205120506__Adding_data_to_table_name.sql   #This script should be executed once and adds data to the "table_name"
│  │  ├─ metadata/                                               #metadata for process. e.g. configuration tables that are used. It could be used to provide row level permissions for use rgroups
│  │  │  ├─ R__Metadata_for_table.sql                            #metadata always added when some change in the file is done
│  │  │  ├─ A__run_always_metadata_updates.sql                   #A - this script is executed always. even when there are no chagnes to the file
│  │  │  ├─ R__Metadata_for_next_table.sql
├─ DB2/                                                          #another DB called DB2 with its structure
│  ├─ schema/
│  │  ├─ schema.config
├─ .gitignore
├─ README.md
```

# The naming convention to the files:
1. Versioned files - files that are exuected only once on the environemnt. It could be alter statments or table creation
   - VX.Y.Z_YYYYMMDDHH24MISS__table_name.operation.sql 
   - **VX.Y.Z** - V from versioned. X.Y.Z is the version of the release e.g. when script is part of the release 1.0.0 - it should look like V1.0.0
   - **YYYYMMDD** - format of YYYY - 4 digit year, MM - 2 digit month, DD - 2 digit day. e.g. second of March, 2021 - 20210302
   - **HH24MISS** - time representaion in 24h with minutes and seconds - e.g. 9:38:25 am -> 093825, 7:12:26 pm is 191226
   - **__** - delimiter between Version and the object name
   - **table_name** - name of the object for the versioned file
   - **operation** - operation that is being done on the object. create, alter, drop - it is just to show the status of the object. object that was dropped should not be removed from repo.
2. R - repetable file - object in the file can be recreated without harm to the data. e.g. Views, procedures, tasks. It is good to have such files to see whole history of the changes in the single file. e.g. R__view_name.sql, R__Metadata_for_table.sql
   -    **R** - informs about repetable file
   -    **__** - delimiter between type of the file - repetable and the object or description of the file
   -    **view_name** or **Metadata_for_table_name**- object namne or description of the file
3. A - always - files that should be executed always it doesn't matter if there was change to file or not. It could be used for refresh of the accesses after deployment. A__run_always_metadata_updates.sql
   - **A** - means run always
   - **__** - delimiter between type of the file - repetable and the object or description of the file
   - **run_always_metadata_updates.sql** - description of the file 


# Prerequisits
- Snowflake account - snowflake.com
  - create schema
  - create objects
  - access to snowflake_sample_data.tpch_sf1

# Snoflake objects apprach described here with some specific to the project:
1. There are 3 envs:
   1. development
   2. pre-prod
   3. prod
2. Environemnts are in single DB
   1. development is one schema
   2. pre-prod is second schema
   3. prod is third schema
3. Notifications are for environemnt and are on single instance of the snowflake. so there are 3 notifications:
   1. dev
   2. pre-prod
   3. prod
4. Data Flow Approach:
   source_file (file_format and Stage) -> pipe -> Stage Table -> Stream -> Task -> Fact Table -> View
   snowflakedb -> 
   - snowflakedb is snowflake_sample_data.tpch_sf1 database
   - source_file will be added as part of the next tasks