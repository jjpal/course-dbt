{{
  config(
    materialized='table'
  )
}}

select oi.product_guid
       , sum(oi.quantity) as product_ordered
       , p.product_name
       , p.product_inventory
       , p.product_price
from {{ ref('stg_greenery__order_items') }} as oi 
join {{ ref('stg_greenery__products') }} as p
on oi.product_guid = p.product_guid
group by 1, 3, 4, 5
order by product_ordered desc  
    