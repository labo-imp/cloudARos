#!/bin/bash

# esto podria estar corriendo NUEVAS definiciones
# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh


# despersonalizacion
mkdir -p "$vmach_bindir"/
cp /home/"$USER"/machina/sh/common_machina.sh  "$vmach_bindir"/common.sh
cat /home/"$USER"/machina/curso/common_curso.sh  >>  "$vmach_bindir"/common.sh

sudo usermod -aG sudo ds

sudo  cp  /home/"$USER"/machina/unit/*@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable  runatboot@"$USER".service


# shared dirs
envsubst < /home/"$USER"/machina/cfg/expshared_cred.txt   >   "$vmach_bindir"/expshared_cred.txt

# memcpu
rm  -f "$vmach_bindir"/memcpu  "$vmach_bindir"/settimeout
gcc -Wall /home/"$USER"/machina/c/memcpu.cpp   -o "$vmach_bindir"/memcpu `pkg-config --libs gio-2.0 --cflags`
gcc  /home/"$USER"/machina/c/settimeout.cpp   -o "$vmach_bindir"/settimeout
cp /home/"$USER"/machina/direct/settimeout.sh  "$vmach_bindir"/

# mlflow
cp /home/"$USER"/machina/r/startup_mlflow.r   "$vmach_bindir"
cp /home/"$USER"/machina/r/shutdown_mlflow.r  "$vmach_bindir"
cp /home/"$USER"/machina/r/alive_mlflow.r     "$vmach_bindir"

date >> "$vmach_bindir"/services_recrear2.txt