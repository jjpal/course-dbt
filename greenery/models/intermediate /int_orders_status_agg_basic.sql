{{
  config(
    materialized='table'
  )
}}

select user_guid
      , order_guid
      , orders_created_at_utc
      , sum(case when order_status = 'delivered' then 1 else 0 end) as delivered
      , sum(case when order_status = 'shipped' then 1 else 0 end) as shipped
      , sum(case when order_status = 'preparing' then 1 else 0 end) as preparing
from {{ ref('stg_greenery__orders') }}
group by 1, 2, 3
order by user_guid
