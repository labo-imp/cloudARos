#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

sleep 30
usuarioid=$(id -u "$USER")
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/"$usuarioid"/bus
export DBUS_SESSION_BUS_ADDRESS

mkdir -p "$vmach_logdir"
cd  "$vmach_logdir"  || exit 1
"$vmach_bindir"/memcpu  "$usuarioid"
