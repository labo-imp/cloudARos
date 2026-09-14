#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

/usr/bin/curl -X POST "$vcur_zulipurl" \
    -u "$vcur_zulipbot" \
    --data-urlencode type=direct \
    --data-urlencode 'to=email' \
    --data-urlencode 'content= '"$1"'.'
