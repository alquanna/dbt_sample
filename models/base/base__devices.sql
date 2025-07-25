{{ config(
   alias='base__devices',
   materialized='table',
   on_schema_change='fail',
   unique_key=['device_id']
)
}}

select d.id                 as device_id
     , d.type               as device_type
     , d.store_id           as store_id
from {{source('sellerx_test','device')}}   as d
