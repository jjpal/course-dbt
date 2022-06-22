{{
  config(
    materialized='table'
  )
}}

select user_guid
       , users_created_at_utc as user_registered_on
       , coalesce(first_name, '') || ' '|| coalesce(last_name, '') as user_full_name
       , age(users_created_at_utc) as user_account_age
from {{ ref('stg_greenery__users') }}
order by user_account_age desc       


