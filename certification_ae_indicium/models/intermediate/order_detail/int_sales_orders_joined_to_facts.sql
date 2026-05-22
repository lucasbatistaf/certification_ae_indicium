{{ 
config(
    tags=['intermediate', 'order_detail'],
    unique_key='sales_reason_id'
) 
}}    

with
    sales_detail as (
        select
            order_id
            , product_id
            , order_qty
            , unit_price
            , unit_discount
        from {{ ref('stg_order_detail__sales_order_detail') }}
    ),
    sales_header as (
        select
            order_id
            , customer_id
            , address_id
            , replace(order_date, '-','') as date_id
        from {{ ref('stg_order_detail__sales_order_header') }}
    )
    
select
    md5(sd.product_id || sd.order_id) as surrogate_key
    , sd.product_id
    , sd.order_id
    , sh.customer_id
    , sh.address_id
    , sh.date_id
    , sd.order_qty
    , sd.unit_price
    , sd.unit_discount
from sales_detail as sd
left join sales_header as sh on sd.order_id = sh.order_id