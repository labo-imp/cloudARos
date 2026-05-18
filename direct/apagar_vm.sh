#!/bin/bash
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(fcur_project_id)
gcloud config set project "$MY_PROJECT_ID"

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

if [[ "$MIHOST" == desktop* || "$MIHOST" == "instance-instalacion" ]]; then
  "$vmach_bindir"/zulip_enviar.sh  "SHUTDOWN SOFT    $HOSTNAME"
  nombrevm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/name -H 'Metadata-Flavor: Google')
  zonavm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/zone -H 'Metadata-Flavor: Google')
  gcloud --quiet compute instances stop "$nombrevm" --zone="$zonavm"  --project="$MY_PROJECT_ID"
else
  "$vmach_bindir"/zulip_enviar.sh  "SHUTDOWN EVAPORATE    $HOSTNAME"
  nombrevm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/name -H 'Metadata-Flavor: Google')
  zonavm=$(curl -X GET http://metadata.google.internal/computeMetadata/v1/instance/zone -H 'Metadata-Flavor: Google')
  gcloud --quiet compute instances delete "$nombrevm" --zone="$zonavm"  --project="$MY_PROJECT_ID"
fi
