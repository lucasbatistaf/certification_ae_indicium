{{ 
config(
    tags=['marts', 'dimension', 'product'],
    unique_key='customer_id'
) 
}}    

with
    products as (
        select *
        from {{ ref('stg_product__product') }}
    )

select
    md5(product_id || product_number) as surrogate_key
    , product_id
    , product_name
    , product_number
from products