{{
  config(
    materialized='table'
  )
}}

select product_guid
       , sum(quantity) as product_ordered
from {{ ref('stg_greenery__order_items') }}  
group by product_guid
order by product_ordered desc
