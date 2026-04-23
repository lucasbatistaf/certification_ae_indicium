{{ 
config(
    tags=['staging', 'location'],
    unique_key='country_region_id'
) 
}}

with 
    source as (
        select
            "Countryregion.Countryregioncode" as country_region_id
            , "Countryregion.Name" as country_name
        from {{ source('location', 'countryregion') }}
    )

select *
from source