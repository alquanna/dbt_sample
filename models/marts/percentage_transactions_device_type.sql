{{ config(
   alias='percentage_transactions_device_type',
   materialized='view'
)
}}

select device_type
     , round((count(device_type) 
        / (select count(device_type) 
            from {{ref('stg__store_transactions')}}))*100, 2) as percentage
from {{ref('stg__store_transactions')}}
group by device_type