{{
  config(
    materialized='table'
  )
}}

with src_greenery_addresses as (
  select * from {{ source('src_greenery','addresses') }}
)
, renamed_recast as (
  select
    address_id as address_guid 
    , address
    , zipcode
    , state
    , country    
  from src_greenery_users
)

select * from renamed_recast