#!/bin/vbash

# lan
set interfaces ethernet eth0 description 'LAN'
set interfaces ethernet eth0 address '10.10.0.1/24'
set interfaces ethernet eth0 hw-id '00:0c:29:fd:81:6c'
set interfaces ethernet eth0 mtu '1500'

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

# iot
set interfaces ethernet eth0 vif 40 address '10.10.30.1/24'
set interfaces ethernet eth0 vif 40 description 'IOT'

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