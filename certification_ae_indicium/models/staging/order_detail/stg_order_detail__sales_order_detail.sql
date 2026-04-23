{{ 
config(
    tags=['staging', 'order_detail'],
    unique_key='order_id'
) 
}}

with 
    source as (
        select
            "Salesorderdetail.Salesorderid" as order_id
            , "Salesorderdetail.Salesorderdetailid" as order_detail_id
            , "Salesorderdetail.Productid" as product_id
            , "Salesorderdetail.Orderqty" as order_qty
            , "Salesorderdetail.Unitprice" as unit_price
            , "Salesorderdetail.Unitpricediscount" as unit_discount
        from {{ source('orderdetail', 'salesorderdetail') }}
    )

select *
from source