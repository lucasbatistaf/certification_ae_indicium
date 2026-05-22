{{ 
config(
    tags=['marts', 'dimension', 'order_detail'],
    unique_key='order_id'
) 
}}    

with
    header as (
        select *
        from {{ ref('stg_order_detail__sales_order_header') }}
    ),
    credit_cards as (
        select *
        from {{ ref('stg_order_detail__credit_card') }}
    ),
    header_sales_reasons as (
        select *
        from {{ ref('int_sales_reason_cross_joined_to_reasons') }}
    )

select
    md5(he.order_id) as surrogate_key
    , he.order_id
    , case 
            when he.order_status = 1 then 'In process'
            when he.order_status = 2 then 'Approved'
            when he.order_status = 3 then 'Backordered'
            when he.order_status = 4 then 'Rejected'
            when he.order_status = 5 then 'Shipped'
            when he.order_status = 6 then 'Cancelled'
        end as order_status
    , cc.credit_card_type as credit_card_type
    , coalesce(hs.sales_reason_name, 'No reason') as sales_reason_name
    , coalesce(hs.sales_reason_type, 'No reason') as sales_reason_type
from header as he
left join header_sales_reasons as hs on he.order_id = hs.order_id
left join credit_cards as cc on he.credit_card_id = cc.credit_card_id