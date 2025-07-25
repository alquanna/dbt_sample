{{ config(
   alias='avg_transaction_amount_store_type_country',
   materialized='view'
)
}}

select store_type                           as store_type
     , store_country                        as store_country
     , round(avg(transaction_amount), 2)    as avg_transaction_amount
from {{ref('stg__store_transactions')}}
group by store_type, store_country
order by avg(transaction_amount) desc
limit 10