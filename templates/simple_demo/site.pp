{% include 'header.pp' %}

{#- include all controller nodes #}
{%- for node in nodes -%}
{%- if node['role'] == 'controller' %}
{% include 'controller.pp' %}
{% endif %}
{%- endfor %}

{#- include all compute nodes #}
{%- for node in nodes -%}
{%- if node['role'] == 'compute' %}
{% include 'compute.pp' %}
{% endif %}
{%- endfor %}

{#- include all swift nodes if swift is enabled#}
{%- if flags['use_swift'] %}
{%- for node in nodes -%}
{%- if node['role'] == 'swift' %}
{% include 'swift.pp' %}
{% endif %}
{%- endfor %}
{%- endif %}

{% include 'footer.pp' %}