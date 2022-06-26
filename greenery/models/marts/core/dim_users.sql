{{
  config(
    materialized='table'
  )
}}

select
       intu.user_guid
       , intu.user_full_name
       , u.email as user_email
       , u.phone_number as user_phone_number
       , intu.user_registered_on
       , age(u.updated_at_utc, u.users_created_at_utc) as last_update_activity
       , intu.user_account_age
       , a.address as user_address
       , a.zipcode as user_zip_code
       , a.state as user_state
       , a.country as user_country
from {{ ref('int_users_registered') }} intu
left join {{ ref('stg_greenery__users') }} u
on intu.user_guid = u.user_guid
left join {{ ref('stg_greenery__addresses') }} a
on u.address_guid = a.address_guid

