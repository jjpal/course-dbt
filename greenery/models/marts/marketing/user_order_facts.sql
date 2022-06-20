{{
  config(
    materialized='table'
  )
}}

select
  int_orders_count_delivered.user_guid
  , int_orders_count_delivered.order_count
  , int_orders_count_delivered.time_delivery
  , stg_greenery__orders.order_total
  , stg_greenery__orders.tracking_guid
  , stg_greenery__orders.shipping_service
--  , int_users_registered.user_registerd
--  , int_users_registered.user_user_full_name
--  , int_users_registered.user_user_account_age
  , stg_greenery__users.email as user_email
  , stg_greenery__users.phone_number as user_phone_number
from {{ ref('int_orders_count_delivered') }}  
join {{ ref('stg_greenery__orders') }}
on int_orders_count_delivered.user_guid = stg_greenery__orders.user_guid
--join int_users_registered
--on stg_greenery__orders.user_guid = int_users_registered.user_guid
join {{ ref('stg_greenery__users') }}
on stg_greenery__orders.user_guid = stg_greenery__users.user_guid
  
