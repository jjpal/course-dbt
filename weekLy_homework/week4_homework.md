Project Details
==============

Part 1. dbt Snapshots

---------------

Some questions that the business might be asking could be:

* How often are items going out of stock? And how quickly are they back in stock?
* What does an order's lifecycle typically look like?
* How is our pricing changing over time?

- [x] 1] Create a snapshot model using the orders source in the /snapshots/ directory of our dbt project that monitors the status column. 
- Created the greenery_orders.sql model

- [x] 2] Run the snapshot model to create it in our database (dbt snapshot)
- [x] 3] Run delivery_updates.sql or delivery-updates.sh.
- [x] 4] Run dbt snapshot again and see how the data has changed for those two orders.

order_id	|	user_id	|	promo_id	|	address_id	|	created_at	|	order_cost	|	shipping_cost	|	order_total	|	tracking_id	|	shipping_service	|	estimated_delivery_at	|	delivered_at	|	status	|	dbt_scd_id	|	dbt_updated_at	|	dbt_valid_from	|	dbt_valid_to	|
|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---	|
914b8929-e04a-40f8-86ee-357f2be3a2a2	|	6aff561d-fbd9-4130-8242-8b9073cc3a03	|		|	b3db1ec9-17b7-4b15-8f04-b2077048f428	|	2021-02-11 20:54:54	|	50	|	6.23	|	56.23	|		|		|		|		|	preparing	|	0e46e92c7aad05b2b34de0f104fee281	|	2022-06-28 14:37:29	|	2022-06-28 14:37:29	|	2022-06-28 14:50:37	|
914b8929-e04a-40f8-86ee-357f2be3a2a2	|	6aff561d-fbd9-4130-8242-8b9073cc3a03	|		|	b3db1ec9-17b7-4b15-8f04-b2077048f428	|	2021-02-11 20:54:54	|	50	|	6.23	|	56.23	|	a807fe66-d8b1-4d38-b409-558fed8bd75f	|	ups	|	2021-02-19 10:15:26	|		|	shipped	|	27f21daceaf12aad947494db2ab90e39	|	2022-06-28 14:50:37	|	2022-06-28 14:50:37	|		|
																																	
order_id	|	user_id	|	promo_id	|	address_id	|	created_at	|	order_cost	|	shipping_cost	|	order_total	|	tracking_id	|	shipping_service	|	estimated_delivery_at	|	delivered_at	|	status	|	dbt_scd_id	|	dbt_updated_at	|	dbt_valid_from	|	dbt_valid_to	|
|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---		|---	|
05202733-0e17-4726-97c2-0520c024ab85	|	5951d1d2-614e-4557-a2de-8298a1e4b179	|		|	3a286955-76c1-4b50-b5fc-61e4e4e3be4d	|	2021-02-11 05:29:28	|	441	|	9.71	|	450.71	|		|		|		|		|	preparing	|	501340d60612ba0012ceb36ef7278c79	|	2022-06-28 14:37:29	|	2022-06-28 14:37:29	|	2022-06-28 22:42:18	|
05202733-0e17-4726-97c2-0520c024ab85	|	5951d1d2-614e-4557-a2de-8298a1e4b179	|		|	3a286955-76c1-4b50-b5fc-61e4e4e3be4d	|	2021-02-11 05:29:28	|	441	|	9.71	|	450.71	|	8404ed05-0128-4aeb-8ed5-6e44908875c4	|	ups	|	2021-02-19 10:15:26	|		|	shipped	|	18540c777b639c1fbe5a478894a9de5b	|	2022-06-28 22:42:18	|	2022-06-28 22:42:18	|		|


---------------

Part 2. Modeling challenge

---------------

How are our users moving through the product funnel?
      Product funnel is defined with 3 levels for our dataset:
      Sessions with any event of type page_view / add_to_cart / checkout
      Sessions with any event of type add_to_cart / checkout
      Sessions with any event of type checkout
- [x] Create any additional dbt models needed to help answer these questions from our product team.

- Created a new model - the fact_events model 
   to get the total diistinct counts for page_view/add_to_cart/checkout session events within a CTE. 
   then I got the percentages for view_cart_flow, cart_checkout_flow, and page_view_checkout_flow 

```sql
with event_session_counts as(
  select
      count(distinct (session_guid)) as total_sessions 
      , count(distinct ( case when page_view > 0 then session_guid end )) as page_views 
      , count(distinct ( case when add_to_cart > 0 then session_guid end )) as add_to_carts
      , count(distinct ( case when checkout > 0 then session_guid end )) as checkouts
  from dbt_juanita_p.fact_events
)

select
  total_sessions 
  , round((page_views::numeric / page_views:: numeric),2) || '%' as page_view_flow
  , round((add_to_carts::numeric / page_views:: numeric),2) || '%' as view_cart_conversion  
  , round((checkouts::numeric / add_to_carts:: numeric),2) || '%' as  cart_checkout_conversion 
  , round((checkouts::numeric / page_views:: numeric),2) || '%' as page_view_checkout_conversion
from event_session_counts
```

 - [x] Which steps in the funnel have largest drop off points?
 - from add_to_cart to checkout has the largest drop off 


total_sessions	|	page_view	|	add_to_cart	|	checkout	|
|---		        |---		    |---		      |---	|
578	            |	578	      |	467	        |	361	|

| Sessions Flow                 |  Product Sessions Conversion |
|---		                        |---		    |
land to page_views              | 100%      | 
from page_view to add_to_cart   | 81%       |
from add_to_cart to checkout    | 77%       |
from page_view to checkout      | 62%       |
            


- [x] Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. 

17:59:42  Found 23 models, 276 tests, 1 snapshot, 0 analyses, 427 macros, 1 operation, 0 seed files, 7 sources, 1 exposure, 0 metrics

---------------

Part 3: Reflection questions

---------------

3A. dbt next steps for you - Reflecting on your learning in this class...

1] if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

- With dbt, it is much easier to model the data, view connections, track revisions to the SQL code, take snapshots, and document the project for current and future analytics engineers, analysts, and other stakeholders. Display several pretty DAGs :) for execs, go over some models to show Analytics/Products teams how they can use information downstream and go over tests/documentation for data governance teams.


2] if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

- N/A, but I would recommend following a style guide for consistency, refactoring to use packages/macros that include several tests, and including detailed documentation for future reference.

3] if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

- I learned to develop SQL code in a manner that is more modularized to be reusable at different stages and used as building blocks to answer different business questions for teams.
- Writing tests at early stages to test assumptions made of the source data and to verify the data is valid and in compliance with data policies.
- Detecting when to extract code that can be moved to a macro to avoid repeating the same code in multiple places.

3B. Reflect: after learning about the various options for dbt deployment and seeing your final dbt project,
 how would you go about setting up a production/scheduled dbt run of your project in an ideal state? 
 You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

1] what steps would you have? Which orchestration tool(s) would you be interested in using? 

- To start with dbt Cloud and then move to Dagster to be able to customize deployment for dbt projects a bit more.

2] What schedule would you run your project on? 

- To start twice a day - during test phase and change the schedule if required or as needed.

3] Which metadata would you be interested in using? / How/why would you use the specific metadata? 

- Tables, columns, foreign keys, indexes  - to track and analyze schema changes
- User, user groups, privledges, connection history, sessions, table sizes, rows in tables - for data 
  protestion.