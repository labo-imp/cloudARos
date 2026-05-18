#!/bin/bash


# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

echo "ingrese SU email utilizado en Zulip"
read  leido
sed -i  's/email/'"\$leido"'/g'  "$vmach_bindir"/zulip_enviar.sh

sleep 2
"$vmach_bindir"/zulip_enviar.sh  "se ha vinculado Zulip correctamente"
