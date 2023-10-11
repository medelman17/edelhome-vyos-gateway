#!/bin/vbash
# shellcheck disable=all
set system ipv6 disable-forwarding

set system host-name 'edge'
set system domain-name 'home.edel.host'
set system ipv6 disable-forwarding
set system login user vyos authentication public-keys personal key 'AAAAC3NzaC1lZDI1NTE5AAAAIIT4sEbrkIjXhKqumXKQXusYSC05+3BEwVNeNnomz7l9'
set system login user vyos authentication public-keys personal type 'ssh-ed25519'
set system name-server '10.10.10.10'
set system name-server '10.10.10.11'
set system sysctl parameter kernel.pty.max value '24000'
set system time-zone 'America/New_York'