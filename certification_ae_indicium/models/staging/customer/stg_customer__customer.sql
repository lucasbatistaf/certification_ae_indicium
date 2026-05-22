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
        from {{ source('customer', 'customer') }}
    )

select *
from source