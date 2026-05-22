{{ 
config(
    tags=['marts', 'dimension', 'customer'],
    unique_key='customer_id'
) 
}}    

with
    customers as (
        select *
        from {{ ref('stg_customer__customer') }}
    ),

    people as (
        select *
        from {{ ref('stg_customer__person') }}
    ),

    stores as (
        select *
        from {{ ref('stg_customer__store') }}
    )

select
    md5(cu.customer_id || pe.person_type) as surrogate_key
    , cu.customer_id
    , pe.person_type
    , pe.person_id
    , pe.person_name
    , st.store_id
    , st.store_name
from customers as cu
left join people as pe on cu.person_id = pe.person_id
left join stores as st on cu.store_id = st.store_id
where person_type is not null