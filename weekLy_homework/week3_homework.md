Project Details
---------------
PART 1: Create new models to answer the first two questions (answer questions in README file)
==============

What is our overall conversion rate?
  NOTE: conversion rate is defined as 
      the # of unique sessions with a purchase event / total number of unique sessions. 
'''sql
select 
     count(distinct case when check_outs = 1 then session_guid end)::float/count(distinct session_guid)::float 
from dbt_juanita_p.int_session_events_agg 
'''
output: 0.6245674740484429

What is our conversion rate by product?

  NOTE: Conversion rate (product) is defined as 
      the # of unique sessions with a purchase event of that product
          / total number of unique sessions that viewed that product

A question to think about: 
  Why might certain products be converting at higher/lower rates than others? Note: we don't actually have data to properly dig into this, but we can make some hypotheses. 

---------------
PART 2: Apply dbt macros to improve our dbt project.
==============

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

Note: One potential macro in our data set is aggregating event types per session. 
      Start here as your first macro and add other macros if you want to go further.

---------------
PART 3: Grant permissions to our dbt models in our postgres database so that other roles can have access to them.
==============

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

After you create the role you still need to grant it usage access on your schema dbt_<firstname>_<lastinitial> (what you set in your profiles.yml in week 1) which can be done using an on-run-end hook

You can use the grant macro example from this week and make any necessary changes for postgres syntax

To check if your grants worked as expected, query the information schema (inputing the table name you want to check): 
```
SELECT grantee, privilege_type
FROM information_schema.role_table_grants
WHERE table_name='mytable'
```

---------------
PART 4:   Try one dbt packages out and apply some macros or tests.
==============

Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

* dbt-utils

* dbt_privacy

---------------
PART 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!
==============

Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.

