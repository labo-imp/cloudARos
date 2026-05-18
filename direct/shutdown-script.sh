#!/bin/bash

bucket=$(/usr/bin/gsutil ls)

tab="	"
fecha=$(date +"%Y%m%d %H%M%S")
echo "$fecha""$tab""$HOSTNAME"  >  /home/ds/sh/z-GCshutdown.txt

ruta=""
if [ -f "$vmach_bindir"/rutashutdown.txt ]; then
  ruta=$(<"$vmach_bindir"/rutashutdown.txt)
fi

/usr/bin/gsutil  cp  "$vmach_bindir"/z-GCshutdown.txt  "$bucket""$ruta"/z-GCshutdown.txt
"$vmach_bindir"/zulip_enviar.sh  "SHUTDOWN     $HOSTNAME"
"$vmach_bindir"/shutdown-tail.sh
