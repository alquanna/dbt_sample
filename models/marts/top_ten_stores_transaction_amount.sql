{{ config(
   alias='top_ten_stores_transaction_amount',
   materialized='view'
)
}}

select store_name                        as store_name
     , round(sum(transaction_amount), 2) as total_transaction_amount
from {{ref('stg__store_transactions')}}
group by store_name
order by sum(transaction_amount) desc
limit 10