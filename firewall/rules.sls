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
  file.append:
    - name: "/etc/rc2.d/S99iptables"
    - context:
        rule_path: {{ firewall.get('rules_path') }}
        interface: {{ salt['pillar.get']('firewall:interface', 'eth0') }}
        forwarding: {{ salt['pillar.get']('firewall:rules:forwarding:enable', false) }}
        forward_interfaces: {{ salt['pillar.get']('firewall:rules:forwarding:interfaces', {}) }}
    - source: salt://firewall/files/rc.d.iptables.jinja
    - template: jinja

{%- if salt['pillar.get']('firewall:rules:forwarding:enable', false) %}
{%- set forward_value=1 %}
{%- else%}
{%- set forward_value=0 %}
{%- endif %}

net.ipv4.conf.default.forwarding:
  sysctl.present:
    - value: 1

net.ipv4.conf.all.forwarding:
  sysctl.present:
    - value: 1

/proc/sys/net/ipv4/ip_forward:
  file.managed:
    - contents: 1