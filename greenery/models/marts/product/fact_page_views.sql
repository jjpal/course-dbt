{{
  config(
    materialized='table'
  )
}}

with event_views_per_user as (
 select user_guid 
       , event_guid
       , event_type
 from {{ ref('stg_greenery__events') }}
)

select
      sum(case when event_type = 'page_view' then 1 else 0 end) as page_view
      , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_cart
      , sum(case when event_type = 'check_out' then 1 else 0 end) as check_out
      , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
from event_views_per_user