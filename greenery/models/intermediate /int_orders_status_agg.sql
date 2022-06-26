{{
  config(
    materialized='table'
  )
}}

{%
  set order_statuses = dbt_utils.get_query_results_as_dict(
   "select distinct quote_literal(order_status) as order_status
   , order_status as column_name from"
  ~ ref ('stg_greenery__orders')
  )
%}

select
  order_guid
  , user_guid
  , address_guid
  , orders_created_at_utc
  {%- for order_status in order_statuses['order_status'] %}
  , sum(case when order_status = {{ order_status }} then 1 else 0 end) as {{ order_statuses['column_name'][loop.index0] }} 
  {%- endfor %}
from {{ ref('stg_greenery__orders') }}
group by 1,2,3,4

