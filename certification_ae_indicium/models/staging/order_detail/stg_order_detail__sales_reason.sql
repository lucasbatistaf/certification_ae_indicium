{{ 
config(
    tags=['staging', 'order_detail'],
    unique_key='sales_reason_id'
) 
}}

with 
    source as (
        select
            "Salesreason.Salesreasonid"::integer as sales_reason_id
            , "Salesreason.Name" as sales_reason_name
            , "Salesreason.Reasontype" as sales_reason_type
        from {{ source('orderdetail', 'salesreason') }}
    )

select *
from source