#!/bin/vbash

forward_rule_number=101
function forward_rule {
  rule=$((forward_rule_number))
  inbound=$1
  outbound=$2
  action=$3

  case $action in
    accept)
      set firewall ipv4 forward filter rule $rule action $action
      set firewall ipv4 forward filter rule $rule inbound-interface interface-group IG_$inbound
      set firewall ipv4 forward filter rule $rule outbound-interface interface-group IG_$outbound
      ;;
    drop)
      set firewall ipv4 forward filter rule $rule action $action
      set firewall ipv4 forward filter rule $rule outbound-interface interface-group IG_$outbound
      set firewall ipv4 forward filter rule $rule log 'enable'
      ;;
    jump)
      set firewall ipv4 forward filter rule $rule action $action
      set firewall ipv4 forward filter rule $rule inbound-interface interface-group IG_$inbound
      set firewall ipv4 forward filter rule $rule outbound-interface interface-group IG_$outbound
      set firewall ipv4 forward filter rule $rule jump-target ${inbound}-${outbound}
      ;;
  esac

  forward_rule_number=$((forward_rule_number+5))
}

# Configure input filter
#   input_rule <rule_number> <inbound_interface_group> jump
#   input_rule <rule_number> any drop
#
# interface_group do not have IG_ prefix - that is substituted
#
# jump target is <inbound>-local named rule
#
input_rule_number=101
function input_rule {
  rule=$((input_rule_number))
  inbound=$1
  action=$2

  case $action in
    drop)
      set firewall ipv4 input filter rule $rule action $action
      set firewall ipv4 input filter rule $rule log 'enable'
      ;;
    jump)
      set firewall ipv4 input filter rule $rule action $action
      set firewall ipv4 input filter rule $rule inbound-interface interface-group IG_$inbound
      set firewall ipv4 input filter rule $rule jump-target ${inbound}-local
      ;;
  esac

  input_rule_number=$((input_rule_number+5))
}

# Configure output filter
#   output_rule <rule_number> <outbound_interface_group> jump
#   output_rule <rule_number> any drop
#
# interface_group do not have IG_ prefix - that is substituted
#
# jump target is local-<outbound> named rule
#
output_rule_number=101
function output_rule {
  rule=$((output_rule_number))
  outbound=$1
  action=$2

  case $action in
    drop)
      set firewall ipv4 output filter rule $rule action $action
      set firewall ipv4 output filter rule $rule log 'enable'
      ;;
    jump)
      set firewall ipv4 output filter rule $rule action $action
      set firewall ipv4 output filter rule $rule outbound-interface interface-group IG_$outbound
      set firewall ipv4 output filter rule $rule jump-target local-$outbound
      ;;
  esac

  output_rule_number=$((output_rule_number+5))
}

function begin_traffic {
  shift # Ignore $1 which is "to"
  interface=$1

  if ! test "$interface" == "local"; then
    forward_rule $interface $interface accept
  fi
}

function handle_traffic {
  shift # Ignore $1 which is to
  outbound=$1
  shift
  shift # Ignore next word which is from
  for inbound in $*; do
    if test "$outbound" == "local"; then
      input_rule $inbound jump
    elif test "$inbound" == "local"; then
      output_rule $outbound jump
    else
      forward_rule $inbound $outbound jump
    fi
  done
}

function end_traffic {
  shift # Ignore $1 which is "to"
  outbound=$1

  if test "$outbound" == "local"; then
    input_rule any drop
    output_rule any drop
  else
    forward_rule any $outbound drop
  fi
}

load /opt/vyatta/etc/config.boot.default

set system host-name 'edge'
set system domain-name 'home.edel.host'

set system login user vyos authentication public-keys personal key 'AAAAC3NzaC1lZDI1NTE5AAAAIIT4sEbrkIjXhKqumXKQXusYSC05+3BEwVNeNnomz7l9'
set system login user vyos authentication public-keys personal type 'ssh-ed25519'

set system name-server '10.10.10.10'
set system name-server '10.10.10.11'

set system sysctl parameter kernel.pty.max value '24000'

set system acceleration qat

set system syslog global facility all level info
set system syslog host 10.10.10.5 facility kern level 'warning'
set system syslog host 10.10.10.5 protocol 'tcp'
set system syslog host 10.10.10.5 port '6001'
set system syslog host 10.10.10.5 format octet-counted

set system time-zone 'America/New_York'

# lan
set interfaces ethernet eth0 description 'LAN'
set interfaces ethernet eth0 address '10.10.0.1/24'
set interfaces ethernet eth0 hw-id '00:0c:29:fd:81:6c'
set interfaces ethernet eth0 mac '00:0c:29:fd:81:6c'
set interfaces ethernet eth0 mtu '9000'

# mgmt
set interfaces ethernet eth0 vif 9 description 'MGMT'
set interfaces ethernet eth0 vif 9 address '10.10.9.1/24'
set interfaces ethernet eth0 vif 9 mtu '9000'

# servers
set interfaces ethernet eth0 vif 10 description 'SERVERS'
set interfaces ethernet eth0 vif 10 address '10.10.10.1/24'
set interfaces ethernet eth0 vif 10 mtu '9000'

# trusted
set interfaces ethernet eth0 vif 20 address '10.10.20.1/24'
set interfaces ethernet eth0 vif 20 description 'TRUSTED'
set interfaces ethernet eth0 vif 20 mtu '9000'

# guest
set interfaces ethernet eth0 vif 30 address '10.10.30.1/24'
set interfaces ethernet eth0 vif 30 description 'GUEST'
set interfaces ethernet eth0 vif 30 mtu '9000'

# iot
set interfaces ethernet eth0 vif 40 address '10.10.40.1/24'
set interfaces ethernet eth0 vif 40 description 'IOT'
set interfaces ethernet eth0 vif 40 mtu '9000'

set interfaces ethernet eth0 vif 50 address '10.10.50.1/24'
set interfaces ethernet eth0 vif 50 description 'ESXi MGMT'
set interfaces ethernet eth0 vif 50 mtu '9000'

set interfaces ethernet eth0 vif 51 address '10.10.51.1/24'
set interfaces ethernet eth0 vif 51 description 'ESXi vMotion'
set interfaces ethernet eth0 vif 51 mtu '9000'

set interfaces ethernet eth0 vif 52 address '10.10.52.1/24'
set interfaces ethernet eth0 vif 52 description 'ESXi vSAN'
set interfaces ethernet eth0 vif 52 mtu '9000'

set interfaces ethernet eth0 vif 53 address '10.10.53.1/24'
set interfaces ethernet eth0 vif 53 description 'ESXi Other'
set interfaces ethernet eth0 vif 53 mtu '9000'

# wan - comcast
set interfaces ethernet eth0 vif 4092 description 'COMCAST'
set interfaces ethernet eth0 vif 4092 mtu 1500
set interfaces ethernet eth0 vif 4092 address dhcp
set interfaces ethernet eth0 vif 4092 dhcp-options reject 192.168.100.0/24
set interfaces ethernet eth0 vif 4092 address dhcpv6
set interfaces ethernet eth0 vif 4092 dhcpv6-options no-release
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0 address 0
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0 sla-id 0
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.9 address 1
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.9 sla-id 1 
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.10 address 2
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.10 sla-id 2
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.20 address 3
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.20 sla-id 3
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.30 address 4
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.30 sla-id 4
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.40 address 5
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.40 sla-id 5
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.50 address 6
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0.50 sla-id 6
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 length 56
set interfaces ethernet eth0 vif 4092 dhcpv6-options rapid-commit
set interfaces ethernet eth0 vif 4092 ipv6 address autoconf

# nat
set nat source rule 100 description 'INSIDE -> OUTSIDE'
set nat source rule 100 outbound-interface 'eth0.4092'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 translation address 'masquerade'

# force iot to use DNS
set nat destination rule 5340 description 'FORCE DNS for IOT'
set nat destination rule 5340 destination address '!10.10.10.10-10.10.10.11'
set nat destination rule 5340 destination port '53'
set nat destination rule 5340 inbound-interface 'eth0.40'
set nat destination rule 5340 protocol 'tcp_udp'
set nat destination rule 5340 translation address '10.10.10.10'
set nat destination rule 5340 translationm port '53'


set service dhcp-relay server 10.10.10.10
set service dhcp-relay upstream-interface eth0.10
set service dhcp-relay relay-options relay-agents-packets discard
set service dhcp-relay listen-interface eth0
set service dhcp-relay listen-interface eth0.9
set service dhcp-relay listen-interface eth0.10
set service dhcp-relay listen-interface eth0.20
set service dhcp-relay listen-interface eth0.30
set service dhcp-relay listen-interface eth0.40
set service dhcp-relay listen-interface eth0.50
set service dhcp-relay listen-interface eth0.51
set service dhcp-relay listen-interface eth0.52
set service dhcp-relay listen-interface eth0.53

set service ssh listen-address '10.10.9.1'
set service ssh listen-address '10.10.20.1'
set service ssh disable-password-authentication

delete service ntp allow-client
set service ntp allow-client address '127.0.0.0/8'
set service ntp allow-client address '10.0.0.0/8'
set service ntp allow-client address '172.16.0.0/12'
set service ntp allow-client address '192.168.0.0/16'
delete service ntp server
set service ntp server us.pool.ntp.org

set service router-advert interface eth0.20 prefix ::/64 valid-lifetime '172800'
set service router-advert interface eth0.30 prefix ::/64 valid-lifetime '172800'
set service router-advert interface eth0.40 prefix ::/64 valid-lifetime '172800'

#firewall 
set firewall global-options all-ping enable
set firewall global-options broadcast-ping enable

set firewall group interface-group IG_lan interface 'eth0'
set firewall group interface-group IG_mgmt interface 'eth0.9'
set firewall group interface-group IG_servers interface 'eth0.10'
set firewall group interface-group IG_iot interface 'eth0.40'
set firewall group interface-group IG_guest interface 'eth0.30'
set firewall group interface-group IG_trusted interface 'eth0.20'
set firewall group interface-group IG_esxi_mgmt interface 'eth0.50'
set firewall group interface-group IG_esxi_vmotion interface 'eth0.51'
set firewall group interface-group IG_esxi_vsan interface 'eth0.52'
set firewall group interface-group IG_wan interface 'eth0.4092'

set firewall group address-group router-addresses 10.10.0.1
set firewall group address-group router-addresses 127.0.0.1
set firewall group address-group router-addresses 10.10.9.1

# Default forward policy
set firewall ipv4 forward filter default-action accept
set firewall ipv4 forward filter rule 1 action 'accept'
set firewall ipv4 forward filter rule 1 state established 'enable'
set firewall ipv4 forward filter rule 2 action 'accept'
set firewall ipv4 forward filter rule 2 state related 'enable'
set firewall ipv4 forward filter rule 999 action 'jump'
set firewall ipv4 forward filter rule 999 inbound-interface interface-group 'OUTSIDE'
set firewall ipv4 forward filter rule 999 jump-target 'OUTSIDE-INSIDE'

# Default input policy
set firewall ipv4 input filter default-action 'accept'
set firewall ipv4 input filter rule 1 action 'accept'
set firewall ipv4 input filter rule 1 state established 'enable'
set firewall ipv4 input filter rule 2 action 'accept'
set firewall ipv4 input filter rule 2 state related 'enable'
set firewall ipv4 input filter rule 999 action 'jump'
set firewall ipv4 input filter rule 999 inbound-interface interface-group 'OUTSIDE'
set firewall ipv4 input filter rule 999 jump-target 'OUTSIDE-LOCAL'

# Default output policy
set firewall ipv4 output filter default-action 'accept'
set firewall ipv4 output filter rule 1 action 'accept'
set firewall ipv4 output filter rule 1 state established 'enable'
set firewall ipv4 output filter rule 2 action 'accept'
set firewall ipv4 output filter rule 2 state related 'enable'

# Ensure VyOS can talk to itself
set firewall ipv4 output filter rule 10 action accept
set firewall ipv4 output filter rule 10 source group address-group router-addresses
set firewall ipv4 output filter rule 10 destination group address-group router-addresses
set firewall ipv4 input  filter rule 10 action accept
set firewall ipv4 input  filter rule 10 source group address-group router-addresses
set firewall ipv4 input  filter rule 10 destination group address-group router-addresses

begin_traffic to containers
handle_traffic to containers from guest iot lan servers trusted mgmt esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic to containers 

egin_traffic  to guest
handle_traffic to guest from containers iot lan servers trusted mgmt esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic    to guest

begin_traffic  to iot
handle_traffic to iot from containers guest lan servers trusted mgmt esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic    to iot

begin_traffic  to lan
handle_traffic to lan from containers guest iot servers trusted mgmt esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic    to lan

begin_traffic  to servers
handle_traffic to servers from containers guest iot mgmt trusted lan esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic    to servers

begin_traffic  to trusted
handle_traffic to trusted from containers guest iot servers mgmt lan esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic    to trusted

begin_traffic  to mgmt
handle_traffic to mgmt from containers guest iot servers trusted lan esxi_mgmt esxi_vmotion esxi_vsan wan local
end_traffic    to mgmt

begin_traffic  to wan
handle_traffic to wan from containers guest iot servers trusted lan esxi_mgmt esxi_vmotion esxi_vsan mgmt local
end_traffic    to wan

begin_traffic  to local
handle_traffic to local from containers guest iot servers trusted lan esxi_mgmt esxi_vmotion esxi_vsan wan mgmt
end_traffic    to local


set firewall group interface-group OUTSIDE description 'Links to the Interwebs'
set firewall group interface-group OUTSIDE interface eth0.4092

set firewall group interface-group INSIDE description 'Everything EdelHome'
set firewall group interface-group INSIDE interface eth0
set firewall group interface-group INSIDE interface eth0.9
set firewall group interface-group INSIDE interface eth0.10
set firewall group interface-group INSIDE interface eth0.20
set firewall group interface-group INSIDE interface eth0.30
set firewall group interface-group INSIDE interface eth0.40
set firewall group interface-group INSIDE interface eth0.50
set firewall group interface-group INSIDE interface eth0.51
set firewall group interface-group INSIDE interface eth0.52
set firewall group interface-group INSIDE interface eth0.53

set firewall group address-group MIKROTIK_DEVICES description 'Mikrotik RouterOS'
set firewall group address-group MIKROTIK_DEVICES address '10.10.9.2'
set firewall group address-group MIKROTIK_DEVICES address '10.10.9.3'

set firewall group address-group UNIFI_DEVICES description 'Unifi Devices'
set firewall group address-group UNIFI_DEVICES address '10.10.9.5'
set firewall group address-group UNIFI_DEVICES address '10.10.9.6'
set firewall group address-group UNIFI_DEVICES address '10.10.9.7'
set firewall group address-group UNIFI_DEVICES address '10.10.9.8'

set firewall group network-group MULTICAST network '224.0.0.0/4'
set firewall group address-group GUESTS address '10.10.30.0/24'



set firewall ipv4 name OUTSIDE-INSIDE default-action 'drop'
set firewall ipv4 name OUTSIDE-INSIDE rule 1 action 'accept'
set firewall ipv4 name OUTSIDE-INSIDE rule 1 description 'Allow established/related'
set firewall ipv4 name OUTSIDE-INSIDE rule 1 state established 'enable'
set firewall ipv4 name OUTSIDE-INSIDE rule 1 state related 'enable'
set firewall ipv4 name OUTSIDE-INSIDE rule 10 action 'accept'
set firewall ipv4 name OUTSIDE-INSIDE rule 10 connection-status nat 'destination'
set firewall ipv4 name OUTSIDE-INSIDE rule 10 state new 'enable'

set firewall ipv4 name OUTSIDE-LOCAL default-action 'drop'
set firewall ipv4 name OUTSIDE-LOCAL rule 1 action 'accept'
set firewall ipv4 name OUTSIDE-LOCAL rule 1 description 'Allow ICMPv4'
set firewall ipv4 name OUTSIDE-LOCAL rule 1 icmp type-name 'echo-request'
set firewall ipv4 name OUTSIDE-LOCAL rule 1 limit burst '5'
set firewall ipv4 name OUTSIDE-LOCAL rule 1 limit rate '2/second'
set firewall ipv4 name OUTSIDE-LOCAL rule 1 protocol 'icmp'
set firewall ipv4 name OUTSIDE-LOCAL rule 50 action 'accept'
set firewall ipv4 name OUTSIDE-LOCAL rule 50 destination port '80,443'
set firewall ipv4 name OUTSIDE-LOCAL rule 50 protocol 'tcp'