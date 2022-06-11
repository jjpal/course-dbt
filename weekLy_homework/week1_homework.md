
Homework Week 1
---------------

Week 1 Project Aanswers:

1. How many users do we have?
'''
select count(distinct user_guid) as users
from dbt.dbt_juanita_p.stg_greenery__users;
'''
output: 130

2. On average, how many orders do we receive per hour?
'''
with orders_by_hour as(
select date_trunc('hour', orders_created_at_utc) as order_hour
       , count(distinct order_guid) as order_count
from dbt_juanita_p.stg_greenery__orders
group by 1
)
select round(sum(order_count))/count(distinct order_hour) as ave_orders_by_hour
from orders_by_hour
'''
output: 8

3. On average, how long does an order take from being placed to being delivered?
'''
'''

4. How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.
'''
'''

5. On average, how many unique sessions do we have per hour?
'''
'''