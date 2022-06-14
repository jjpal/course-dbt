
Homework Week 1
---------------

Week 1 Project Aanswers:

1. How many users do we have?

```
select count(distinct user_guid) as users
from dbt.dbt_juanita_p.stg_greenery__users;
```

output: 130

2. On average, how many orders do we receive per hour?

```sql
with orders_by_hour as(
select date_trunc('hour', orders_created_at_utc) as order_hour
       , count(distinct order_guid) as order_count
from dbt_juanita_p.stg_greenery__orders
group by 1
)
select round(sum(order_count))/count(distinct order_hour) as ave_orders_by_hour
from orders_by_hour
```

output: 8

3. On average, how long does an order take from being placed to being delivered?

```sql
select avg(age(delivered_at_utc,orders_created_at_utc)) as avg_time_delivery
from dbt_juanita_p.stg_greenery__orders;
```

output: 3 days 21:24:11.803279

4. How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

```sql
with user_purchase_activity as(
select coalesce(users.first_name, '') || ' '|| coalesce(users.last_name, '') as name
       , count(distinct orders.order_guid) as order_count
from dbt_juanita_p.stg_greenery__users as users
inner join dbt_juanita_p.stg_greenery__orders as orders
on users.user_guid = orders.user_guid      
group by 1
order by 1
)
select sum(case when order_count = 1 then 1 else 0 end) as one_order
       , sum(case when order_count = 2 then 1 else 0 end) as two_orders
       , sum(case when order_count >= 3 then 1 else 0 end) as three_or_more_orders
from user_purchase_activity;

```

output: 25 28 71

5. On average, how many unique sessions do we have per hour?

```sql
with sessions_by_hour as(
select date_trunc('hour', events_created_at_utc) as event_hour
      , count(distinct session_guid) as session_count
from dbt_juanita_p.stg_greenery__events
group by 1)
select round(sum(session_count)/count(distinct event_hour)) as ave_session_by_hour
from sessions_by_hour;
```

output: 16