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
  higher/lower rates possibly due to users not going through the whole order workflow or maybe some plants are in season so they are more in demand than others.

```sql
select 
      product_guid
      , sum(add_to_cart) / count(distinct session_guid) as conversion_rate_by_product      
 from dbt_juanita_p.int_user_sessions_product_agg
 group by 1
 ```
 output: (5 rows)
 product_guid	                        conversion_rate_by_product
05df0866-1a66-41d8-9ed7-e2bbcddd6a3d	0.550000000000000
35550082-a52d-4301-8f06-05b30f6f3616	0.533333333333333
37e0062f-bd15-4c3e-b272-558a86d90598	0.548387096774194
4cda01b9-62e2-46c5-830f-b7f262a58fb1	0.39344262295082
55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	0.516129032258065


---------------
PART 2: Apply dbt macros to improve our dbt project.
==============

Create a macro to simplify part of a model(s). Think about what would improve the usability or modularity of your code by applying a macro. Large case statements, or blocks of SQL that are often repeated make great candidates. Document the macro(s) using a .yml file in the macros directory.

macro and documentation included

---------------
PART 3: Grant permissions to our dbt models in our postgres database so that other roles can have access to them.
==============

Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

After you create the role you still need to grant it usage access on your schema dbt_<firstname>_<lastinitial> (what you set in your profiles.yml in week 1) which can be done using an on-run-end hook

completed

---------------
PART 4:   Try one dbt packages out and apply some macros or tests.
==============

Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

* dbt-utils - dbt_utils.get_query_results_as_dict

* dbt_privacy - installed but didn't apply any of the macros

---------------
PART 5: After improving our project with all the things that we have learned about dbt, we want to show off our work!
==============

Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.

