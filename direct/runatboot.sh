#!/bin/bash

mkdir -p "$vmach_logdir"

# para zulip
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  /home/"$USER"/buckets/b1/estudiante_secretos.sh


sed -i  's/email/'"$estudiante_zulip_email"'/g'  "$vmach_bindir"/zulip_enviar.sh

"$vmach_bindir"/zulip_enviar.sh  "startup     $HOSTNAME"

/usr/bin/gnome-extensions  enable Vitals@CoreCoding.com
/usr/bin/gnome-extensions  enable  executor@raujonas.github.io

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

if [ ! -f "$vmach_logdir"/manual.txt ]; then

  if [[ "$MIHOST" == "zzzzzzzz" ]]; then
    "$vmach_bindir"/settimeout.sh  60 120 10
  fi

  if [[ "$MIHOST" == "desktop-jr" ]]; then
    "$vmach_bindir"/settimeout.sh  30 15 10
  fi
  
fi


if [[ "$MIHOST" == "desktop-jr" ]]; then
  "$vmach_bindir"/correr_en_desktop_jr.sh
fi


# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh
# shellcheck source=SCRIPTDIR/../secrets/estudiante_secretos.sh
source  /home/"$USER"/buckets/b1/estudiante_secretos.sh

# Cambio de clave
MY_PROJECT_ID=$(/usr/bin/gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

CLAVE=$(/usr/bin/gcloud secrets versions access latest --secret="ds-password")
echo  "ds:$CLAVE" | /usr/sbin/chpasswd
# echo  "ds:$CLAVE" | sudo  /usr/sbin/chpasswd
# sudo usermod -aG sudo ds

/usr/bin/ssh-keygen -A

mkdir -p "$vmach_logdir"
