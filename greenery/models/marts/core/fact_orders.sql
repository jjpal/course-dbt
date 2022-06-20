
{{
  config(
    materialized='table'
  )
}}

select
  o.order_guid
  , o.promo_guid
  , o.user_guid
  , o.order_total
  , o.orders_created_at_utc
  , o.tracking_guid
  , o.shipping_service
  , o.delivered_at_utc
  , pr.discount
  , pr.promo_status
  , oi.product_guid
  , oi.quantity
  , p.product_inventory
  , p.product_price
from {{ ref('stg_greenery__orders') }} o
left join {{ ref('stg_greenery__promos') }} pr
  on o.promo_guid = pr.promo_guid
left join {{ ref('stg_greenery__order_items') }} oi
  on o.order_guid = oi.order_guid
left join {{ ref('stg_greenery__products') }} p
  on oi.product_guid = p.product_guid
