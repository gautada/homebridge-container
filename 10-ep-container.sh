#!/bin/ash
#
# Launch the podman service/process if not previously launched. If parameters are not provided
# launch as a process. If parameters provided fork the podman as a service.

RETURN_VALUE=0
echo "---------- [ HOMEKIT HUB(homebridge) ] ----------"
if [ -z "$ENTRYPOINT_PARAMS" ] ; then
 TEST="$(/usr/bin/pgrep /usr/bin/coredns)"
 if [ $? -eq 1 ] ; then
  # /usr/local/bin/homebridge --debug --no-qrcode --user-storage-path /opt/homebridge
  /home/homebridge/node_modules/homebridge/bin/homebridge --debug --no-qrcode --user-storage-path /opt/homebridge
  # TEST="$(/usr/bin/pgrep /usr/sbin/crond)"
  # if [ $? -eq 0 ] ; then
  #  # Kill the background cron service
  #  /usr/bin/sudo /usr/bin/killall crond
  # fi
  # echo "---------- [ {BLOCKING}SCHEDULER(crond) ] ----------"
  # /usr/bin/sudo /usr/sbin/crond -f -l 0
 fi
 unset TEST
fi
unset ENTRYPOINT_PARAM
return $RETURN_VALUE

