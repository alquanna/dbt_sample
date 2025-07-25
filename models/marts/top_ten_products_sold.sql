{{ config(
   alias='top_ten_products_sold',
   materialized='view'
)
}}

select product_sku                      as product_sku
     , count(transaction_id)            as transaction_count
from {{ref('stg__store_transactions')}}
group by product_sku
order by count(transaction_id) desc
limit 10