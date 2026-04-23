{{ 
config(
    tags=['staging', 'location'],
    unique_key='state_province_id'
) 
}}

with 
    source as (
        select
            "Stateprovince.Stateorovinceid" as state_province_id
            , "Stateprovince.Name" as state_province_name
            , "Stateprovince.Countryregioncode" as country_region_id
        from {{ source('location', 'stateprovince') }}
    )

select *
from source