{% from "firewall/map.jinja" import firewall with context %}

firewall:
  pkg.installed:
    - name: {{ firewall.get('package') }}
    {%- if 'version' in firewall %}
    - version: {{ firewall.get('version') }}
    {%- endif %}