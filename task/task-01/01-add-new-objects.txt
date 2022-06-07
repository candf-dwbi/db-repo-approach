Use Case:
1. we are preparing release 3.1 to be deployed to production
2. in this release we need to add:
a. new view with logic for data transformation from "SNOWFLAKE_SAMPLE_DATA"."TPCH_SF1"."CUSTOMER" - view name in DB sbould be called:
V_SNF_CUSTOMER
b. task that will be executed on V_SNF_CUSTOMER and will pass data to T_D_CUSTOMER table


TO DO:
1. Objects to create:
    a. view
    b. task
    c. table

What this will show:
1. Naming convention usage adding repetable and versioned scripts with timestamp and release number
2. Project folder structure and place of the data
3. comparing changes between parent branch and child branch
4. git commit, pull request

Steps:
0. create own branch from develop - you can call it: feature/added-customer-v3.1-<your name>
1. Create view - create repetable script that will store information about view and will be tracked
    you can copy logic from task/task-01/task-01-view-customer.sql
   commit changes to repository
   add comment in commit: adding view customer
2. create task - task should be versioned script as it is adding data to table that may be changed over time.
    you can copy logis from task/task-01/task-01-task-customer.sql
   commit changes to repository
   add comment in commit: adding table customer    
3. create table - tables is versioned script
    you can copy logic from task/task-01/task-01-table-customer.sql
   commit changes to repository
   add comment in commit: adding table customer
4. compare changes between develop and your branch
    git diff develop feature/added-customer-v3.1-<your-name> --name-status
5. Order of execution:
    1. view
    2. table
    3. task