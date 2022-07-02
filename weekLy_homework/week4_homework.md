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



Part 2. Modeling challenge

---------------

How are our users moving through the product funnel?
Which steps in the funnel have largest drop off points?

Product funnel is defined with 3 levels for our dataset:

1] Sessions with any event of type page_view / add_to_cart / checkout
2] Sessions with any event of type add_to_cart / checkout
3] Sessions with any event of type checkout
- [x] A] Create any additional dbt models needed to help answer these questions from our product team.

Created a new model the fact_events model

```sql
with event_session_counts as(
  select
      count(distinct (session_guid)) as total_sessions 
      , count(distinct ( case when page_view > 0 then session_guid end )) as page_view 
      , count(distinct ( case when add_to_cart > 0 then session_guid end )) as add_to_cart
      , count(distinct ( case when checkout > 0 then session_guid end )) as checkout
  from dbt_juanita_p.fact_events
)

select
  total_sessions 
  , round((add_to_cart::numeric / page_view:: numeric),2) || '%' as view_cart_flow  
  , round((checkout::numeric / add_to_cart:: numeric),2) || '%' as  cart_checkout_flow 
  , round((checkout::numeric / page_view:: numeric),2) || '%' as page_view_checkout_flow
from event_session_counts
```

B] Use an exposure on your product analytics model to represent that this is being used in downstream BI tools. 


Part 3: Reflection questions

---------------

3A. dbt next steps for you - Reflecting on your learning in this class...

* if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?

* if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?

* if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?


3B. Reflect: after learning about the various options for dbt deployment and seeing your final dbt project,
 how would you go about setting up a production/scheduled dbt run of your project in an ideal state? 
 You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

* Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? 
What schedule would you run your project on? 
Which metadata would you be interested in using? 
How/why would you use the specific metadata? 