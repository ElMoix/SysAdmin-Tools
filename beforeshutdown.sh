#!/bin/bash
echo "$(date) - $(hostname) Shutdown" >> /var/log/moix/shutdown.log
mail -s "$(hostname) Shutdown" 23andreu@gmail.com
