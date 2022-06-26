{{
  config(
    materialized='table'
  )
}}

select
    intp.product_guid
  , intp.product_name
  , intp.product_price
  , intp.product_inventory
  , intp.product_ordered
  , e.page_url as product_url
from {{ ref('int_order_items_product_agg') }} intp
left join {{ ref('stg_greenery__events') }} e
  on intp.product_guid = e.product_guid
 


   