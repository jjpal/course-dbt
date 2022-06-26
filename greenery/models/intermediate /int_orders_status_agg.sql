{{
  config(
    materialized='table'
  )
}}

-- {%
--   set event_types = dbt_utils.get_query_results_at_dict(
--    "select distinct quote_literal(event_type) as event_type, event_type as column_name from"
--   ~ ref('stg_greenery__events')
--   )
-- %}

-- select 
--        user_guid
--       , session_guid     
--       , product_guid  

-- {% for event_type in event_types['event_type'] %}
--     , sum(case when event_type = {{ event_type }} then 1 else 0 end) as event_types['column_name']
-- {% endfor %}
--from {{ ref('stg_greenery__events') }}
--group by 1, 2, 3


{%
  set order_status = dbt_utils.get_query_results_at_dict(
   "select distinct quote_literal(order_status) as order_status, order_status as column_name from"
  ~ ref('stg_greenery__events')
  )
%}

select 
       user_guid
      , order_guid     
      , tracking_guid  

{% for order_status in orders_status['order_status'] %}
    , sum(case when order_status = {{ order_status }} then 1 else 0 end) as orders_status['column_name']
{% endfor %}
from {{ ref('stg_greenery__orders') }}
group by 1, 2, 3
