#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh


diro=$(pwd)
cd  "$vmach_logdir"   || exit 1
"$vmach_bindir"/settimeout "$@"
echo "manual" > manual.txt

cd  "$diro" || exit 1