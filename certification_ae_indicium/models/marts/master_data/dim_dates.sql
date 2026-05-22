{{ 
config(
    tags=['marts', 'dimension', 'dates'],
    unique_key='date_id'
) 
}}

with
    dates as (
        select *
        from {{ ref('date_seed') }}
    )

select
    md5(date_id) as surrogate_key
    , date_id
    , dates
    , days
    , months
    , monthnames
    , years
    , quarters
    , semesters
    , weekdays
from dates