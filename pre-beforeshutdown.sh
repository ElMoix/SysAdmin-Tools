#!/bin/bash

echo "[Unit]
Description=Run my custom task at shutdown
DefaultDependencies=no
Before=shutdown.target

[Service]
Type=oneshot
ExecStart=/root/scripts/beforeshutdown.sh
TimeoutStartSec=0

[Install]
WantedBy=shutdown.target" >> /etc/systemd/system/run-before-shutdown.service
