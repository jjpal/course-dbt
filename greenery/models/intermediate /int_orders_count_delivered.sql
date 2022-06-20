
{{
  config(
    materialized='table'
  )
}}

select user_guid
      , count(order_guid) as order_count
      , age(delivered_at_utc,orders_created_at_utc) as time_delivery
from {{ ref('stg_greenery__orders') }}
group by 1, 3
order by time_delivery desc
