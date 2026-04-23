{{ 
config(
    tags=['staging', 'product'],
    unique_key='product_id'
) 
}}

with 
    source as (
        select
            "Product.Productid" as product_id
            , "Product.Name" as product_name
            , "Product.Productnumber" as product_number
        from {{ source('product', 'product') }}
    )

select *
from source