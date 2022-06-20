{{
  config(
    materialized='table'
  )
}}

select state 
       , count(state)
from {{ ref('stg_greenery__addresses') }}
group by state
order by count desc