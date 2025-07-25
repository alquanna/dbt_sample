{{ config(
   alias='stg__store_transactions',
   materialized='table',
   on_schema_change='fail',
   unique_key=['hashed_id'],
)
}}

select t.transaction_id
     , t.main_product_name
     , t.product_sku
     , t.transaction_amount
     , t.transaction_status
     , t.transaction_happened_at
     , t.device_id
     , d.device_type
     , s.store_id
     , s.store_name
     , s.store_country
     , s.store_type
from {{ref('base__transactions')}} as t
left join {{ref('base__devices')}} as d
    on t.device_id = d.device_id
left join {{ref('base__stores')}} as s
    on d.store_id = s.store_id