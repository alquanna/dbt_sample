{{ config(
   alias='base__transactions',
   materialized='table',
   on_schema_change='fail',
   unique_key=['transaction_id'],
   partition_by={
       "field": "transaction_happened_at",
       "data_type": "timestamp",
       "granularity": "day"
   }
)
}}

select t.id                    as transaction_id
     , t.device_id             as device_id
     , t.product_name_a        as main_product_name
     , t.product_name_b        as secondary_product_name
     , t.product_sku           as product_sku
     , t.amount                as transaction_amount
     , t.status                as transaction_status
     , t.happened_at           as transaction_happened_at
     , t.created_at            as record_created_at
from {{source('sellerx_test','transaction')}} as t
