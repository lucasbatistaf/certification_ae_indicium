{{ 
config(
    tags=['staging', 'order_detail'],
    unique_key='order_id'
) 
}}

with 
    source as (
        select
            "Creditcard.Creditcardid" as credit_card_id
            , "Creditcard.Cardtype" as credit_card_type
        from {{ source('orderdetail', 'creditcard') }}
    )

select *
from source