#!/bin/bash

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

/usr/bin/gsutil ls | sed -r 's/gs:\/\///' | sed 's/.$//'       \
|  sed 's/^/\/usr\/bin\/gcsfuse  --implicit-dirs --temp-dir \/mnt\/gcsfuse --log-file \/mnt\/gcsfuse\/log.txt  --log-severity TRACE --file-mode 777 --dir-mode 777 --metadata-cache-ttl-secs=-1 --stat-cache-max-size-mb=-1   /'    \
|  sed 's/$/ \/home\/$USER\/buckets\/b/'    \
|  awk '{ print $0NR}' >  $vmach_bindir/linkear_buckets2.sh


if [[ "$MIHOST" == "desktop-analistajr" ]]; then

  cat <(echo 1111  & /usr/bin/gsutil ls) | sed -r 's/gs:\/\///' | sed 's/.$//'       \
  |  sed 's/^/\/usr\/bin\/gcsfuse  --implicit-dirs --temp-dir \/mnt\/gcsfuse --log-file \/mnt\/gcsfuse\/log.txt  --log-severity TRACE --file-mode 777 --dir-mode 777  --metadata-cache-ttl-secs=-1 --stat-cache-max-size-mb=-1  /'    \
  |  sed 's/$/ \/home\/$USER\/buckets\/b/'    \
  |  awk '{ print $0NR}' | tail -n+2 >  $vmach_bindir/linkear_buckets2.sh

fi

chmod  u+x  "$vmach_bindir"/linkear_buckets2.sh
"$vmach_bindir"/linkear_buckets2.sh
