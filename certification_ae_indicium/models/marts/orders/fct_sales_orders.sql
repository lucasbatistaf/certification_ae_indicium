{{ 
config(
    tags=['marts', 'fact'],
    unique_key='fact_surrogate_key'
) 
}}

with 

    int_sales_orders as (
        select 
            surrogate_key
            , product_id
            , order_id
            , customer_id
            , address_id
            , date_id
            , order_qty
            , unit_price
            , unit_discount
        from {{ ref('int_sales_orders_joined_to_facts') }}
    ),
    
    dim_customers as (
        select
            surrogate_key
            , customer_id
        from {{ ref('dim_customers') }}
    ),

    dim_dates as (
        select
            surrogate_key
            , date_id
        from {{ ref('dim_dates') }}
    ),

    dim_locations as (
        select
            surrogate_key
            , address_id
        from {{ ref('dim_locations') }}
    ),

    dim_order_detail as (
        select
            surrogate_key
            , order_id
        from {{ ref('dim_order_details') }}
    ),

    dim_products as (
        select
            surrogate_key
            , product_id
        from {{ ref('dim_products') }}
    )

select
    so.surrogate_key as fact_surrogate_key
    , pr.surrogate_key as product_id
    , od.surrogate_key as order_id
    , cu.surrogate_key as customer_id
    , lo.surrogate_key as address_id
    , dt.surrogate_key as date_id
    , so.order_qty as order_qty
    , so.unit_price as unit_price
    , so.unit_discount as unit_discount
from int_sales_orders as so
left join dim_customers as cu on so.customer_id = cu.customer_id
left join dim_dates as dt on so.date_id = dt.date_id
left join dim_locations as lo on so.address_id = lo.address_id
left join dim_order_detail as od on so.order_id = od.order_id
left join dim_products as pr on so.product_id = pr.product_id