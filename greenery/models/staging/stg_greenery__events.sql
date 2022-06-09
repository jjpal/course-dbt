{{
  config(
    materialized='table'
  )
}}

with src_greenery_events as (
  select * from {{ source('src_greenery','events') }}
)
, renamed_recast as (
  select
    event_id as event_guid
    , seesion_id as session_guid
    , user_id as user_guid
    , event_type
    , page_url 
    , created_at as events_created_at_utc
    , order_id as order_guid
    , prdocut_id as product_guid 
  from src_greenery_users
)

select * from renamed_recast