{{ 
config(
    tags=['staging', 'order_detail'],
    unique_key='order_id'
) 
}}

with 
    source as (
        select
            "Salesorderheader.Salesorderid" as order_id
            , "Salesorderheader.Customerid" as customer_id
            , "Salesorderheader.Shiptoaddressid" as address_id
            , "Salesorderheader.Creditcardid" as credit_card_id
            , "Salesorderheader.Salesordernumber" as order_number
            , "Salesorderheader.Status" as order_status
            , "Salesorderheader.Subtotal" as order_subtotal
            , "Salesorderheader.Taxamt" as order_tax_amt
            , "Salesorderheader.Freight" as order_freight
            , "Salesorderheader.Totaldue" as order_total_due
            , "Salesorderheader.Orderdate" as order_date
        from {{ source('orderdetail', 'salesorderheader') }}
    )

select *
from source