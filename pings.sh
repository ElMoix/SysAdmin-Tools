#!/bin/bash

# Cron:
#*/15 * * * * /root/scripts/pings.sh

pings="5"
targets=(8.8.8.8 1.1.1.1)

for target in ${targets[@]};do
	cmd="ping -c $pings $target"
	loss=$($cmd | grep "loss" | cut -d "," -f3 | cut -d " " -f2)
	if [ $loss == "0%" ];
	then
	        echo "$(date) - $(hostname) - NO ping loss to $target" >> /var/log/moix/pings.log
	else
        	echo "$(date) - $(hostname) - Ping loss was $loss to $target" >> /var/log/moix/pings.log
	fi
done
