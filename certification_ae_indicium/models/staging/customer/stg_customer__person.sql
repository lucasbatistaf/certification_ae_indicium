{{ 
config(
    tags=['staging', 'customer'],
    unique_key='person_id'
) 
}}

with 
    source as (
        select
            "Person.Businessentityid" as person_id
            , "Person.Persontype" as person_type
            , COALESCE("Person.Firstname" || ' ' || "Person.Lastname", 'No name') as person_name
        from {{ source('customer', 'person') }}
        where "Person.Persontype" IN ('IN', 'SC')
    )

select *
from source