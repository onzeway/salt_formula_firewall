{% from "firewall/map.jinja" import firewall with context %}

firewall:
  - name: {{ firewall.get('package') }}
  {%- if 'version' in firewall %}
  - version: {{ firewall.get('version') }}
  {%- endif %}
  file.managed:
    - name: {{ firewall.get('rules_path') }}
    - user: root
    - group: root
    - mode: 755
    - context:
        rules: {{ firewall.get('rules', {}) }}
    - source: salt://firewall/files/iptables.jinja
    - template: jinja
  cmd.wait:
    - name: iptables-restore < {{ path }}
    - watch:
      - file: firewall
    - require:
      - pkg: firewall