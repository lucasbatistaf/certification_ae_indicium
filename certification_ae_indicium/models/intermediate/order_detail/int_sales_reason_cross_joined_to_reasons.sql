{{ 
config(
    tags=['intermediate', 'order_detail'],
    unique_key='sales_reason_id'
) 
}}    

with

    header_sales_reason as (
        select
            order_id
            , reason_id
        from {{ ref('stg_order_detail__sales_order_header_sales_reason') }}
    ),

    sales_reason as (
        select *
        from {{ ref('stg_order_detail__sales_reason') }}
    ),

    union_reason as (
        select    
            (t1.sales_reason_id || t2.sales_reason_id || t3.sales_reason_id)::integer as sales_reason_id
            , t1.sales_reason_name || ', ' || t2.sales_reason_name || ', ' || t3.sales_reason_name as sales_reason_name
            , t1.sales_reason_type || ', ' || t2.sales_reason_type || ', ' || t3.sales_reason_type as sales_reason_type
        from sales_reason as t1
        cross join sales_reason as t2
        cross join sales_reason as t3
        where t1.sales_reason_id < t2.sales_reason_id
        and t2.sales_reason_id < t3.sales_reason_id
    
        union

        select    
            (t1.sales_reason_id || t2.sales_reason_id)::integer as sales_reason_id
            , t1.sales_reason_name || ', ' || t2.sales_reason_name as sales_reason_name
            , t1.sales_reason_type || ', ' || t2.sales_reason_type as sales_reason_type
        from sales_reason as t1
        cross join sales_reason as t2
        cross join sales_reason as t3
        where t1.sales_reason_id < t2.sales_reason_id
    
        union

        select    
            sales_reason_id::integer
            , sales_reason_name
            , sales_reason_type
        from sales_reason
    )

select
    hs.order_id
    , ur.sales_reason_id
    , ur.sales_reason_name
    , ur.sales_reason_type
from header_sales_reason as hs
left join union_reason as ur on hs.reason_id = ur.sales_reason_id