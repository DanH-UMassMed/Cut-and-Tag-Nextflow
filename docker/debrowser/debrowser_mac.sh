#!/bin/bash

# Simplify the use of debrowser on an Apple Mac computer

PORT_IN_USE=`lsof -i :8088 | grep LISTEN|cut -d ' ' -f 2`
DEBROWSER_ID=`docker ps|grep danhumassmed/debrowser:1.0.1|cut -d ' ' -f1`


action=$(echo "$1" | tr '[:lower:]' '[:upper:]')

if [ -z "$action" ]; then
    action="START"
fi


start() {
	if [ -n "$PORT_IN_USE" ]; then
   	   echo "DEBrowser port is in use by PID:[$PORT_IN_USE]."
       echo "DEBrowser container ID:[${DEBROWSER_ID}]."
       echo "Try debrowser.sh RESTART if the port is not accessable from the browser"
	else
   	   echo "Starting DEBrowser ..."
       echo "Allow 40 seconds for server to start"
       echo "DEBrowser is available at: http://127.0.0.1:8088"
	   nohup docker run --platform linux/amd64 --rm -p 8088:8088 -t danhumassmed/debrowser:1.0.1 Rscript /startDEBrowser.R  > /dev/null 2>&1 &
	fi
}


stop() {
	if [ -n "${DEBROWSER_ID}" ]; then
   	 echo "Stopping docker container ID:[${DEBROWSER_ID}]"
		 docker stop ${DEBROWSER_ID}
	else
   	 echo "DEBrowser is not running."
	    if [ -n "${PORT_IN_USE}" ]; then
   	    echo "However port 8088 is blocked Sstopping process PID:[${PORT_IN_USE}]"
			 kill -9 ${PORT_IN_USE}
       fi
	fi

}

case "$action" in
    "START")
        start
        ;;
    "RESTART")
		  stop
        sleep 5
        start
        ;;
    "STATUS")
	    if [ -z "${DEBROWSER_ID}" ]; then
          echo "DEBrowser is not running."
	       if [ -n "${PORT_IN_USE}" ]; then
             echo "However DEBrowser Port is blocked by PID:$PORT_IN_USE"
          fi
       else
          echo "DEBrowser is running with container ID:[${DEBROWSER_ID}]."
       fi
        ;;
    "STOP")
		  stop
        ;;
    *)
        echo "Unknown action: $action"
        echo "Usage debrowser.sh [START|STOP|RESTART|STATUS]"
        ;;
esac

