{{
  config(
    materialized='table'
  )
}}

with src_greenery_order_items as (
  select * from {{ source('src_greenery','order_items') }}
)
, renamed_recast as (
  select
    order_id as order_guid
    , product_id as product_guid 
    , quantity 
  from src_greenery_order_items
)

select * from renamed_recast
