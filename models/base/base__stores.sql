{{ config(
   alias='base__stores',
   materialized='table',
   on_schema_change='fail',
   unique_key=['store_id']
)
}}

select s.id              as store_id
     , s.name            as store_name
     , s.address         as store_address
     , s.city            as store_city
     , s.country         as store_country
     , s.typology        as store_type
     , s.customer_id     as customer_id
     , s.created_at      as record_created_at
from {{source('sellerx_test','store')}} as s

