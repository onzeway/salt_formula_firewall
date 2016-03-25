{% from "firewall/map.jinja" import firewall with context %}

firewall_rules:
  file.managed:
    - name: {{ firewall.get('rules_path') }}
    - user: root
    - group: root
    - mode: 644
    - context:
        rules: {{ salt['pillar.get']('firewall:rules', {}) }}
    - source: salt://firewall/files/iptables.jinja
    - template: jinja

firewall_rules_apply:
  cmd.wait:
    - name: "iptables-restore < {{ firewall.get('rules_path') }}"
    - watch:
      - file: firewall_rules
    - require:
      - pkg: firewall
      - file: firewall_rules_startup
      
firewall_rules_startup:
  file.managed:
    - name: "{{ firewall.get('active_reboot_path') }}"
    - user: root
    - group: root
    - mode: 755
    - context:
        rule_path: {{ firewall.get('rules_path') }}
        interface: {{ salt['pillar.get']('firewall:interface', 'eth0') }}
    - source: salt://firewall/files/pre-up-iptables.jinja
    - template: jinja