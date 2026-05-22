{# Macro to format and round floats #}

{% macro round_float(column_name) -%}
    {{ column_name }}::numeric(16, 2)
{%- endmacro %}
