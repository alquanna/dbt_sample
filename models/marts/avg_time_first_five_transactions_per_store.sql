{{ config(
   alias='avg_time_first_five_transactions_per_store',
   materialized='view'
)
}}

with first_five as (
    select store_name
         , transaction_id
         , transaction_happened_at
    from {{ref('stg__store_transactions')}}
    qualify row_number() over (partition by store_name order by transaction_happened_at) < 6
)

, min_max_times as (
    select store_name
         , min(transaction_happened_at) as earliest_transaction
         , max(transaction_happened_at) as fifth_transaction
    from first_five
    group by store_name
)


select store_name
    , round(avg(timestampdiff(day, earliest_transaction,
            fifth_transaction)), 2)                         as avg_days_to_first_five_transactions
    , round(avg(timestampdiff(hour, earliest_transaction,
            fifth_transaction)), 2)                         as avg_hours_to_first_five_transactions
from min_max_times
group by store_name
