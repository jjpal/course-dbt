{{
  config(
    materialized='table'
  )
}}

select
  int_orders_count_delivered.user_guid
  , int_orders_count_delivered.order_count
  , int_orders_count_delivered.time_delivery
  , fo.order_total
  , fo.tracking_guid
  , fo.shipping_service
  , int_users_registered.user_registered_on
  , int_users_registered.user_full_name
  , int_users_registered.user_account_age
  , du.user_email
  , du.user_phone_number
from {{ ref('int_orders_count_delivered') }}  
join {{ ref('fact_orders') }} as fo
on int_orders_count_delivered.user_guid = fo.user_guid
join {{ ref('int_users_registered') }}
on fo.user_guid = int_users_registered.user_guid
join {{ ref('dim_users') }} as du
on fo.user_guid = du.user_guid
  
