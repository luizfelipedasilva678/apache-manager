#!/bin/bash

# apache-manager.sh - Script to manage apache service
#
# Usage:
# ./apache-manager.sh

apache_status() {
    status=$(systemctl status apache2 | grep Active)
    echo "$(echo $status | cut -d ' ' -f 2)"
}

while :; do
    action=$(
        dialog --stdout \
            --title "Status: $(apache_status)" \
            --menu "" \
            0 0 0 \
            start "Start Apache" \
            stop "Stop Apache" \
            restart "Restart Apache"
    )
    [ $? -ne 0 ] && exit

    case "$action" in
    start)
        systemctl start apache2
        ;;
    stop)
        systemctl stop apache2
        ;;
    restart)
        systemctl restart apache2
        ;;
    esac
done
