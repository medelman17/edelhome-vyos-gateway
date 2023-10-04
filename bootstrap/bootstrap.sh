#!/bin/bash

load /opt/vyatta/etc/config.boot.default

set interfaces ethernet eth0 description 'INSIDE'
set interfaces ethernet eth0 address '10.10.0.1/24'
set interfaces ethernet eth0 hw-id '00:0c:29:fd:81:6c'

set interfaces ethernet eth0 vif 4092 description 'COMCAST'
set interfaces ethernet eth0 vif 4092 address dhcp
set interfaces ethernet eth0 vif 4092 address dhcpv6
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0 address 1
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0 sla-id 1 
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 length 56
set interfaces ethernet eth0 vif 4092 dhcpv6-options rapid-commit
set interfaces ethernet eth0 vif 4092 ipv6 address autoconf

set system login user vyos authentication public-keys personal key 'AAAAC3NzaC1lZDI1NTE5AAAAIIT4sEbrkIjXhKqumXKQXusYSC05+3BEwVNeNnomz7l9 michael@edel.monster'
set system login user vyos authentication public-keys personal type 'ssh-ed25519'

set service ssh disable-password-authentication
set service ssh port '22'

delete system host-name

set system host-name 'gateway'
set system domain-name 'home.edel.host'
set system name-server '1.1.1.1'
set system sysctl parameter kernel.pty.max value '24000'
set system time-zone 'America/New_York'

set service dhcp-server shared-network-name INSIDE authoritative
set service dhcp-server shared-network-name INSIDE ping-check
set service dhcp-server shared-network-name INSIDE subnet 10.10.0.0/24 default-router '10.10.0.1'
set service dhcp-server shared-network-name INSIDE subnet 10.10.0.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name INSIDE subnet 10.10.0.0/24 lease '86400'
set service dhcp-server shared-network-name INSIDE subnet 10.10.0.0/24 range 0 start '10.10.0.200'
set service dhcp-server shared-network-name INSIDE subnet 10.10.0.0/24 range 0 stop '10.10.0.254'

set nat source rule 100 description 'INSIDE -> OUTSIDE/COMCAST'
set nat source rule 100 outbound-interface 'eth0.4092'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 translation address 'masquerade'
