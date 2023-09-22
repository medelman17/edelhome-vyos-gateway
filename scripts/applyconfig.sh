#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

#ensure script is running correctly
if [ "$(id -g -n)" != 'vyattacfg' ] ; then
    exec sg vyattacfg -c "/bin/vbash $(readlink -f $0) $@"
fi

configure

echo "[*] configuring interfaces"

exit 

exit