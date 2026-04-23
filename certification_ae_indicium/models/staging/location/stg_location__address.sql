{{ 
config(
    tags=['staging', 'location'],
    unique_key='address_id'
) 
}}

with 
    source as (
        select
            "Address.Addressid" as address_id
            , "Address.City" as city_name
            , "Address.Stateprovinceid" as state_province_id
        from {{ source('location', 'address') }}
    )

select *
from source