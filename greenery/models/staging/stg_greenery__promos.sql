{{
  config(
    materialized='table'
  )
}}

with src_greenery_promos as (
  select * from {{ source('src_greenery','promos') }}
)
, renamed_recast as (
  select
    promo_id as promo_guid
    , discount
    , status as promo_status
  from src_greenery_users
)

select * from renamed_recast
