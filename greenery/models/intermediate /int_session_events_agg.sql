{{
  config(
    materialized='table'
  )
}}

select 
      session_guid     
      , events_created_at_utc
      , user_guid      
      , sum(case when event_type = 'page_view' then 1 else 0 end) as page_views
      , sum(case when event_type = 'add_to_cart' then 1 else 0 end) as add_to_carts
      , sum(case when event_type = 'checkout' then 1 else 0 end) as check_outs
      , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_ships
from {{ ref('stg_greenery__events') }}
group by 1, 2, 3




