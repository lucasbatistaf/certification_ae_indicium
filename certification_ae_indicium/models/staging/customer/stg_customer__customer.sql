{{ 
config(
    tags=['staging', 'customer'],
    unique_key='customer_id'
) 
}}

with 
    source as (
        select
            "Customer.Customerid" as customer_id
            , "Customer.Personid" as person_id
            , "Customer.Storeid" as store_id
            , "Customer.Accountnumber" as account_number
            , case
                when "Customer.Personid" is null then 'SC'
                else 'IN'
            end as customer_type
        from {{ source('customer', 'customer') }}
    )

select *
from source