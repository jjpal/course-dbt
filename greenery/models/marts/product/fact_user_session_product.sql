{{
  config(
    materialized='table'
  )
}}

 select 
      int_usp.product_guid
      , intp.product_name
      , sum(int_usp.add_to_cart) / count(distinct int_usp.session_guid) as conversion_rate_by_product     
 from {{ ref('int_user_sessions_product_agg') }} as int_usp
 left join {{ ref('int_order_items_product_agg') }} as intp
 on int_usp.product_guid =  intp.product_guid
 group by 1, 2
 order by conversion_rate_by_product desc 