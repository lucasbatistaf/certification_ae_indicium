{{ 
config(
    tags=['staging', 'order_detail'],
    unique_key='order_id'
) 
}}

with 
    source as (
        select
            "Salesorderheadersalesreason.Salesorderid" as order_id
	        , "Salesorderheadersalesreason.Salesreasonid" as reason_id
        from {{ source('orderdetail', 'salesorderheadersalesreason') }}
    )

select
    order_id
    , listagg(reason_id, '')::integer as reason_id
from source
group by 1