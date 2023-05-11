#!/bin/bash

# Cron:
# */30 * * * * /root/scripts/checkservices.sh

services=("docker" "ssh" "openvpn" "rsyslog" "cron" "apache2")

for service in ${services[@]}; do
        health=$(systemctl is-active $service)
        if [ $health == "active" ];then
                echo "$(date) - $service is running on $(hostname)" >> /var/log/moix/services.log
                exit 0
        elif [ $health == "inactive" ];then
                echo "$(date) - $service is not running $(hostname)" >> /var/log/moix/services.log
                mail -s "SERVICE $service STOPPED on $(hostname)" 23andreu@gmail.com
                exit 0
        elif [ $health == "failed" ];then
                echo "$(date) - !!ERROR!! $service can't be started. Errors must be corrected on $(hostname) !!" >> /var/log/moix/services.log
                mail -s "ERROR!! SERVICE $service FAILED on $(hostname)" 23andreu@gmail.com
                exit 0
        else
                echo "$(date) - !!WARNING!! $service can't be started. Check $service on $(hostname) !!" >> /var/log/moix/services.log
                mail -s "WARNING!! SERVICE $service FAILED on $(hostname)" 23andreu@gmail.com
                exit 1
        fi
done
