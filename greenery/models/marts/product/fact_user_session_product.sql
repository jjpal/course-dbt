{{
  config(
    materialized='table'
  )
}}

 select 
      product_guid
      , sum(add_to_cart) / count(distinct session_guid)       
 from {{ ref('int_user_sessions_product_agg') }}
 group by 1


