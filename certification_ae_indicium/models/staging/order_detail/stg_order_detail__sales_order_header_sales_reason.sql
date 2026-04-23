{{ 
config(
    tags=['staging', 'order_detail'],
    unique_key='order_id'
) 
}}

with 
    source as (
        select
            "Salesorderheadersalesreason.Salesorderid" as order_id,
	        "Salesorderheadersalesreason.Salesreasonid" as reason_id,
        from {{ source('orderdetail', 'salesorderheadersalesreason') }}
    )

select *
from source