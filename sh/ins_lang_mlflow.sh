#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_mlflow.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_pyworld_first.txt
fmach_salir_si_no_instalado  ins_lang_rworld_first.txt


envsubst < /home/"$USER"/machina/cfg/mlflow.yml   >   "$vmach_bindir"/mlflow.yml

cp /home/"$USER"/machina/r/startup_mlflow.r   "$vmach_bindir"
cp /home/"$USER"/machina/r/shutdown_mlflow.r  "$vmach_bindir"
cp /home/"$USER"/machina/r/alive_mlflow.r     "$vmach_bindir"


sudo  cp   /home/"$USER"/machina/unit/alive_mlflow@.service   /etc/systemd/system/
sudo  cp   /home/"$USER"/machina/unit/alive_mlflow@.timer   /etc/systemd/system/
sudo  systemctl enable alive_mlflow@"$USER".timer
sudo  systemctl daemon-reload
sudo systemctl enable --now  alive_mlflow@"$USER".timer


sudo  cp   /home/"$USER"/machina/unit/shutdown_mlflow@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable  shutdown_mlflow@"$USER".service


fmach_bitacora   "lang_mlflow"
fmach_registrar_instalacion $logito