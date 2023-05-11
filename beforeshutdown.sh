#!/bin/bash

file=/etc/systemd/system/run-before-shutdown.service
if [ ! -f "$file" ];then
echo "[Unit]
Description=Run my custom task at shutdown
DefaultDependencies=no
Before=shutdown.target

[Service]
Type=oneshot
ExecStart=/root/scripts/beforeshutdown.sh
TimeoutStartSec=0

[Install]
WantedBy=shutdown.target" >> $file
fi

echo "$(date) - $(hostname) Shutdown" >> /var/log/moix/shutdown.log
mail -s "$(hostname) Shutdown" 23andreu@gmail.com
