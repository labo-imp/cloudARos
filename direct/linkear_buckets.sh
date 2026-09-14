#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

sudo mkdir -p  /mnt/
sudo mkdir -p  /mnt/gcsfuse/
sudo mkdir -p  /mnt/cache/
sudo mkdir -p  /mnt/alive/
sudo chown -R  "$USER":"$USER" /mnt/gcsfuse/
sudo chown -R  "$USER":"$USER" /mnt/alive/
sudo chown -R  "$USER":"$USER" /mnt/cache/


MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

/snap/bin/gcloud storage ls | sed -r 's/gs:\/\///' | sed 's/.$//'       \
|  sed 's/^/\/usr\/bin\/gcsfuse  --implicit-dirs --temp-dir \/mnt\/gcsfuse --log-file \/mnt\/gcsfuse\/log.txt --cache-dir \/mnt\/gcsfuse --log-severity TRACE --file-mode 777 --dir-mode 777 --metadata-cache-ttl-secs=-1 --stat-cache-max-size-mb=-1   /'    \
|  sed 's/$/ \/home\/$USER\/buckets\/b/'    \
|  awk '{ print $0NR}' >  $vmach_bindir/linkear_buckets2.sh



if [[ "$MIHOST" == "desktop-analistajr" ]]; then

  cat <(echo 1111  & /snap/bin/gcloud storage ls) | sed -r 's/gs:\/\///' | sed 's/.$//'       \
  |  sed 's/^/\/usr\/bin\/gcsfuse  --implicit-dirs --temp-dir \/mnt\/gcsfuse --log-file \/mnt\/gcsfuse\/log.txt --cache-dir \/mnt\/gcsfuse --log-severity TRACE --file-mode 777 --dir-mode 777  --metadata-cache-ttl-secs=-1 --stat-cache-max-size-mb=-1  /'    \
  |  sed 's/$/ \/home\/$USER\/buckets\/b/'    \
  |  awk '{ print $0NR}' | tail -n+2 >  $vmach_bindir/linkear_buckets2.sh

fi



chmod  u+x  "$vmach_bindir"/linkear_buckets2.sh
"$vmach_bindir"/linkear_buckets2.sh
