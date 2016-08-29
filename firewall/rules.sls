{% from "firewall/map.jinja" import firewall with context %}

firewall_rules:
  file.managed:
    - name: {{ firewall.get('rules_path') }}
    - user: root
    - group: root
    - mode: 644
    - context:
        rules: {{ salt['pillar.get']('firewall:rules', {}) }}
        forwarding: {{ salt['pillar.get']('firewall:rules:forwarding:enable', false) }}
        forward_interfaces: {{ salt['pillar.get']('firewall:rules:forwarding:interfaces', {}) }}
    - source: salt://firewall/files/iptables.jinja
    - template: jinja
    - watch_in:
      - service: firewall_service
      
firewall_service:
  file.managed:
    - name: "/etc/init.d/iptables-rules"
    - user: root
    - group: root
    - mode: 755
    - context:
        rule_path: {{ firewall.get('rules_path') }}
    - source: salt://firewall/files/rc.d.iptables.jinja
    - template: jinja
  service.running:
    - name: iptables-rules
    - enable: True
    - reload: True
    - require:
      - file: firewall_service
    - watch:
      - file: firewall_rules

{%- if salt['pillar.get']('firewall:rules:forwarding:enable', false) %}
{%- set forward_value=1 %}

net.ipv4.conf.default.forwarding:
  sysctl.present:
    - value: {{ forward_value }}

net.ipv4.conf.all.forwarding:
  sysctl.present:
    - value: {{ forward_value }}

/proc/sys/net/ipv4/ip_forward:
  file.managed:
    - contents: {{ forward_value }}

{%- endif %}