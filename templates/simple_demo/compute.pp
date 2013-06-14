# Compute template
node '{{ node['name'] }}' {
  class { 'netconfig' :
    hostname => '{{ node['name'] }}',
    router   => '{{ node['router'] }}',
    dns1     => '{{ general['dns1'] }}',
    dns2     => '{{ general['dns2'] }}',
  }

{%- for interface in node['interfaces'] %}
  NetworkInterface { '{{ interface['name'] }}' :
    ip      => '{{ interface['ip']|default('0.0.0.0') }}',
    promisc => {{ interface['promisc']|default('False') }},
  }
{%- endfor %}

  class { 'nova-compute' : }

{%- if flags['use_nagios'] %}
  class { 'nagios::client' : }
{%- endif %}

}