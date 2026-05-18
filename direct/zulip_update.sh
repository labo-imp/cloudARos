#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

/usr/bin/curl -X PATCH "$vcur_zulipurl"/api/v1/messages/"$1" \
    -u "$vcur_zulipbot" \
    --data-urlencode 'content= '"$2"'.'
