#!/bin/vbash

# Guest VLAN
set service dhcp-server shared-network-name GUEST authoritative
set service dhcp-server shared-network-name GUEST ping-check
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 default-router '192.168.2.1'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 lease '86400'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 range 0 start '192.168.2.200'
set service dhcp-server shared-network-name GUEST subnet 192.168.2.0/24 range 0 stop '192.168.2.254'

# IoT VLAN
set service dhcp-server shared-network-name IOT authoritative
set service dhcp-server shared-network-name IOT ping-check
set service dhcp-server shared-network-name IOT subnet 10.10.30.0/24 default-router '10.10.30.1'
set service dhcp-server shared-network-name IOT subnet 10.10.30.0/24 domain-name 'home.edel.ost'
set service dhcp-server shared-network-name IOT subnet 10.10.30.0/24 lease '86400'
set service dhcp-server shared-network-name IOT subnet 10.10.30.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name IOT subnet 10.10.30.0/24 range 0 start '10.10.30.200'
set service dhcp-server shared-network-name IOT subnet 10.10.30.0/24 range 0 stop '10.10.30.254'

# LAN
set service dhcp-server shared-network-name LAN authoritative
set service dhcp-server shared-network-name LAN ping-check
set service dhcp-server shared-network-name LAN subnet 10.10.0.1/24 default-router '10.10.0.1'
set service dhcp-server shared-network-name LAN subnet 10.10.0.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 10.10.0.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name LAN subnet 10.10.0.0/24 range 0 start '10.10.0.200'
set service dhcp-server shared-network-name LAN subnet 10.10.0.0/24 range 0 stop '10.10.0.254'

# MGMT
set service dhcp-server shared-network-name LAN authoritative
set service dhcp-server shared-network-name LAN ping-check
set service dhcp-server shared-network-name LAN subnet 10.10.9.1/24 default-router '10.10.9.1'
set service dhcp-server shared-network-name LAN subnet 10.10.9.0/24 lease '86400'
set service dhcp-server shared-network-name LAN subnet 10.10.9.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name LAN subnet 10.10.9.0/24 range 0 start '10.10.9.200'
set service dhcp-server shared-network-name LAN subnet 10.10.9.0/24 range 0 stop '10.10.9.254'

# Servers VLAN
set service dhcp-server shared-network-name SERVERS authoritative
set service dhcp-server shared-network-name SERVERS ping-check
set service dhcp-server shared-network-name SERVERS subnet 10.10.10.0/24 default-router '10.10.10.1'
set service dhcp-server shared-network-name SERVERS subnet 10.10.10.0/24 domain-name 'home.edel.host'
set service dhcp-server shared-network-name SERVERS subnet 10.10.10.0/24 lease '86400'
set service dhcp-server shared-network-name SERVERS subnet 10.10.10.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name SERVERS subnet 10.10.10.0/24 range 0 start '10.10.10.200'
set service dhcp-server shared-network-name SERVERS subnet 10.10.10.0/24 range 0 stop '10.10.10.254'

# TRUSTED 
set service dhcp-server shared-network-name TRUSTED authoritative
set service dhcp-server shared-network-name TRUSTED ping-check
set service dhcp-server shared-network-name TRUSTED subnet 10.10.20.0/24 default-router '10.10.20.1'
set service dhcp-server shared-network-name TRUSTED subnet 10.10.20.0/24 domain-name 'home.edel.host'
set service dhcp-server shared-network-name TRUSTED subnet 10.10.20.0/24 lease '86400'
set service dhcp-server shared-network-name TRUSTED subnet 10.10.20.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name TRUSTED subnet 10.10.20.0/24 range 0 start '10.10.20.200'
set service dhcp-server shared-network-name TRUSTED subnet 10.10.20.0/24 range 0 stop '10.10.20.254'


# ESXi MGMT 
set service dhcp-server shared-network-name ESXI_MGMT authoritative
set service dhcp-server shared-network-name ESXI_MGMT ping-check
set service dhcp-server shared-network-name ESXI_MGMT subnet 10.10.50.0/24 default-router '10.10.50.1'
set service dhcp-server shared-network-name ESXI_MGMT subnet 10.10.50.0/24 domain-name 'home.edel.host'
set service dhcp-server shared-network-name ESXI_MGMT subnet 10.10.50.0/24 lease '86400'
set service dhcp-server shared-network-name ESXI_MGMT subnet 10.10.50.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name ESXI_MGMT subnet 10.10.50.0/24 range 0 start '10.10.50.200'
set service dhcp-server shared-network-name ESXI_MGMT subnet 10.10.50.0/24 range 0 stop '10.10.50.254'

# ESXi MGMT 
set service dhcp-server shared-network-name ESXI_vMOTION authoritative
set service dhcp-server shared-network-name ESXI_vMOTION ping-check
set service dhcp-server shared-network-name ESXI_vMOTION subnet 10.10.51.0/24 default-router '10.10.51.1'
set service dhcp-server shared-network-name ESXI_vMOTION subnet 10.10.51.0/24 domain-name 'home.edel.host'
set service dhcp-server shared-network-name ESXI_vMOTION subnet 10.10.51.0/24 lease '86400'
set service dhcp-server shared-network-name ESXI_vMOTION subnet 10.10.51.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name ESXI_vMOTION subnet 10.10.51.0/24 range 0 start '10.10.51.200'
set service dhcp-server shared-network-name ESXI_vMOTION subnet 10.10.51.0/24 range 0 stop '10.10.51.254'

# ESXi vSAN 
set service dhcp-server shared-network-name ESXI_vSAN authoritative
set service dhcp-server shared-network-name ESXI_vSAN ping-check
set service dhcp-server shared-network-name ESXI_vSAN subnet 10.10.52.0/24 default-router '10.10.52.1'
set service dhcp-server shared-network-name ESXI_vSAN subnet 10.10.52.0/24 domain-name 'home.edel.host'
set service dhcp-server shared-network-name ESXI_vSAN subnet 10.10.52.0/24 lease '86400'
set service dhcp-server shared-network-name ESXI_vSAN subnet 10.10.52.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name ESXI_vSAN subnet 10.10.52.0/24 range 0 start '10.10.52.200'
set service dhcp-server shared-network-name ESXI_vSAN subnet 10.10.52.0/24 range 0 stop '10.10.52.254'

# ESXi vSAN 
set service dhcp-server shared-network-name ESXI_OTHER authoritative
set service dhcp-server shared-network-name ESXI_OTHER ping-check
set service dhcp-server shared-network-name ESXI_OTHER subnet 10.10.53.0/24 default-router '10.10.53.1'
set service dhcp-server shared-network-name ESXI_OTHER subnet 10.10.53.0/24 domain-name 'home.edel.host'
set service dhcp-server shared-network-name ESXI_OTHER subnet 10.10.53.0/24 lease '86400'
set service dhcp-server shared-network-name ESXI_OTHER subnet 10.10.53.0/24 name-server '1.1.1.1'
set service dhcp-server shared-network-name ESXI_OTHER subnet 10.10.53.0/24 range 0 start '10.10.53.200'
set service dhcp-server shared-network-name ESXI_OTHER subnet 10.10.53.0/24 range 0 stop '10.10.53.254'