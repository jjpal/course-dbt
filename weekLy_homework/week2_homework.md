Homework Week 2 - Week 2 project
==============

(Part 1) Models 
---------------

1 - What is our user repeat rate? 
    Formula: Repeat Rate = Users who purchased 2 or more times / users who purchased
```sql
with orders_purchased as (
  select user_guid
   , count(distinct order_guid) as user_order_count
  from dbt_juanita_p.stg_greenery__orders
  group by 1
)

, user_order_activity as (
  select user_guid
   , (user_order_count = 1)::int as one_order
   , (user_order_count >= 2)::int as two_orders
   , (user_order_count >= 3)::int as three_or_more_orders
  from orders_purchased
)

select sum(two_orders)::float / count(distinct user_guid)::float as user_repeat_rate
from user_order_activity;
```
output: 0.7983870967741935

2 - What are good indicators of a user who will likely purchase again? 
    * Repeat purchase rate
    * Amount of purchases
    * More than 1 visit to website
    * Time spent on the website
    * Looking into/taking advantage of promos

3 - What about indicators of users who are likely NOT to purchase again? 
    * Delivery of order/s took too long
    * Product/s not available in inventory more than once
    * Event type limited to one page_view
    * Time difference between users_created_at_utc and updated_at_utc
     - assumption: if the timestamps are close user has not come back to the website
    * User and company/distribution center is around the same area 
     - assumption: if not in the same area -> it would take longer -> opt to get something locally 

4 - If you had more data, what features would you want to look into to answer this question?
    * returns - why did they return the product
    * upstream engagement - what could have been done differently
    * how did the user find out about the company - see if Marketing has existing strategy
    * customer experience/rating - address possible user journey fails/ product updates
    * does the user follow the company on social platforms - user wants to be informed about future updates 

    NOTE: hypothetical question vs. something we can analyze in Greenery data set (exploratory analysis approach).

More stakeholders are coming to us for data, but we need to get more models created before we can help. 
- Create a marts folder, so we can organize our models, with the following subfolders for business units:
        Core,        Marketing,         Product

- Within each marts folder, create intermediate models and dimension/fact models.

    NOTE: what metrics might be useful for these business units, and build dbt models using greenery’s data

     For example, 
        some “core” datasets could include fact_orders, dim_products, and dim_users

        marketing mart could contain a model like user_order_facts which contains order information at the user level

        product mart could contain a model like fact_page_views which contains all page view_events from events data
			
	--- Explain the marts models you added. Why did you organize the models in the way you did?
    For core:
    - added dim_users that joins users table and address table - to be able to get some demographic information per state/country and to see user activity 
    - added dim_products that joins products and order_items tables - to be able to see inventory and last ordered 
      itmes together. 
    - added fact_order that includes orders information, applied discount/current promo status from promos table, ordered quantity from order_items, and product price/ inventory to apply possible discount if product is not available.

    For Marketing:
   - added user_order_facts that includes user and order information.

    For Product:
    - added fact_page_views which include totals for the different events.
    
       

    ---	Use the dbt docs to visualize your model DAGs to ensure the model layers make sense

	- Paste in an image of your DAG from the docs. 
	$ dbt docs generate 
	$ dbt docs serve --no-browser			
	
(Part 2) Tests 
---------------

We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. 

- Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

- What assumptions are you making about each model? (i.e. why are you adding each test?)
 * applied_discount_order_total - discount amount should not be greater than order total
 * product_price_positive - product price should be positive
 * user_name_account_age - user_name and account_age (date since user registered) should 
   not be null.

- Did you find any “bad” data as you added and ran tests on your models?
- How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

- Apply these changes to your github repo

Your stakeholders at Greenery want to understand the state of the data each day. 
- Explain how you would ensure these tests are passing regularly 
  Store results and forward alerts to slack/email.
- How you would alert stakeholders about bad data getting through.	
  Reviewing historical information if bad data consistently getting through - review with other teams about possible changes to interface.