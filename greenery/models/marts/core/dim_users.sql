{{
  config(
    materialized='table'
  )
}}

select
       u.user_guid
       , u.first_name
       , u.last_name
       , u.email as user_email
       , u.phone_number as user_phone_number
       , age(u.updated_at_utc, u.users_created_at_utc) as last_update_activity
       , a.address as user_address
       , a.zipcode as user_zip_code
       , a.state as user_state
       , a.country as user_country
from {{ ref('stg_greenery__users') }} u
left join {{ ref('stg_greenery__addresses') }} a
on u.address_guid = a.address_guid
