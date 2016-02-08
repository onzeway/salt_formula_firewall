{% from "firewall/map.jinja" import firewall with context %}

firewall_rules:
  file.managed:
    - name: {{ firewall.get('rules_path') }}
    - user: root
    - group: root
    - mode: 755
    - context:
        rules: {{ firewall.get('rules', {}) }}
    - source: salt://firewall/files/iptables.jinja
    - template: jinja

firewall_rules_apply:
  cmd.wait:
    - name: iptables-restore < {{ firewall.get('rules', {}) }}
    - watch:
      - file: firewall_rules
    - require:
      - pkg: firewall