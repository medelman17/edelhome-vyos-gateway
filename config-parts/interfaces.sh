#!/bin/vbash

set interfaces ethernet eth0 description 'LAN'
set interfaces ethernet eth0 address '10.10.0.1/24'
set interfaces ethernet eth0 hw-id '00:0c:29:fd:81:6c'
set interfaces ethernet eth0 mtu '1500'
set interfaces ethernet eth0 vif 9 address '10.10.9.1/24'
set interfaces ethernet eth0 vif 9 description 'MANAGEMENT'
set interfaces ethernet eth0 vif 10 address '10.10.10.1/24'
set interfaces ethernet eth0 vif 10 description 'SERVERS'
set interfaces ethernet eth0 vif 20 address '10.10.20.1/24'
set interfaces ethernet eth0 vif 20 description 'TRUSTED'
set interfaces ethernet eth0 vif 30 address '192.168.2.1/24'
set interfaces ethernet eth0 vif 30 description 'GUEST'
set interfaces ethernet eth0 vif 40 address '10.10.30.1/24'
set interfaces ethernet eth0 vif 40 description 'IOT'
set interfaces ethernet eth0 vif 50 address '10.10.50.1/24'
set interfaces ethernet eth0 vif 50 description 'ESXi MGMT'
set interfaces ethernet eth0 vif 51 address '10.10.51.1/24'
set interfaces ethernet eth0 vif 51 description 'ESXi vMotion'
set interfaces ethernet eth0 vif 52 address '10.10.52.1/24'
set interfaces ethernet eth0 vif 52 description 'ESXi vSAN'
set interfaces ethernet eth0 vif 53 address '10.10.53.1/24'
set interfaces ethernet eth0 vif 53 description 'ESXi Other'
set interfaces ethernet eth0 vif 4092 description 'WAN - COMCAST'
set interfaces ethernet eth0 vif 4092 address dhcp
set interfaces ethernet eth0 vif 4092 address dhcpv6
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0 address 1
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 interface eth0 sla-id 1 
set interfaces ethernet eth0 vif 4092 dhcpv6-options pd 0 length 56
set interfaces ethernet eth0 vif 4092 dhcpv6-options rapid-commit
set interfaces ethernet eth0 vif 4092 ipv6 address autoconf