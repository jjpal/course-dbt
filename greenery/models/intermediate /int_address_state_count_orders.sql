{{
  config(
    materialized='table'
  )
}}

select 
       a.state 
       , count(a.state) as order_count
       , sum(o.order_total) as order_totals
from {{ ref('stg_greenery__addresses') }} as a
join {{ ref('stg_greenery__orders') }} as o
on a.address_guid = o.address_guid
group by 1
order by order_count desc
