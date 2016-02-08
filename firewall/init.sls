{% from "firewall/map.jinja" import firewall with context %}

firewall:
  - name: {{ firewall.get('package') }}
  {%- if 'version' in firewall %}
  - version: {{ firewall.get('version') }}
  {%- endif %}