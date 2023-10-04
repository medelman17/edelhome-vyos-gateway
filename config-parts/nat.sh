set nat source rule 100 description 'INSIDE -> OUTSIDE/COMCAST'
set nat source rule 100 outbound-interface 'eth0.4092'
set nat source rule 100 destination address '0.0.0.0/0'
set nat source rule 100 translation address 'masquerade'