{{ 
config(
    tags=['marts', 'dimension', 'location'],
    unique_key='address_id'
) 
}}

with
    cities as (
        select
            address_id
            , city_name
            , state_province_id
        from {{ ref('stg_location__address') }}
    ),

    countries as (
        select *
        from {{ ref('stg_location__country_region') }}
    ),

    states as (
        select *
        from {{ ref('stg_location__state_province') }}
    )

select
    md5(ci.address_id) as surrogate_key
    , ci.address_id as address_id
    , ci.city_name as city_name
    , st.state_province_name as state_province_name
    , co.country_name as country_name
from cities as ci
left join states as st on ci.state_province_id = st.state_province_id
left join countries as co on st.country_region_id = co.country_region_id