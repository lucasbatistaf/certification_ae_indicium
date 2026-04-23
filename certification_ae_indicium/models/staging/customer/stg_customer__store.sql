{{ 
config(
    tags=['staging', 'customer'],
    unique_key='store_id'
) 
}}

with 
    source as (
        select
            "Store.Businessentityid" as store_id
            , "Store.Name" as store_name
        from {{ source('customer', 'store') }}
    )

select *
from source