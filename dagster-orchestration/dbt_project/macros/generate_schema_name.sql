{% macro generate_schema_name(custom_schema_name, node) %}
    {# Nếu có custom_schema_name thì lấy luôn, không thêm target.schema #}
    {% if custom_schema_name is not none %}
        {{ custom_schema_name }}
    {% else %}
        {{ target.schema }}
    {% endif %}
{% endmacro %}