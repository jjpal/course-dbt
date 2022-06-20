{{
  config(
    materialized='table'
  )
}}

select
    p.product_guid
  , p.product_name
  , p.product_price
  , p.product_inventory
  , oi.quantity as current_ordered_items
from {{ ref('stg_greenery__products') }} p
left join {{ ref('stg_greenery__order_items') }} oi
  on p.product_guid = oi.product_guid


  