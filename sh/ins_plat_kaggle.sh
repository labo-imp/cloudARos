#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

logito="ins_plat_kaggle.txt"
fmach_salir_si_no_instalado  ins_sys_system.txt
fmach_salir_si_no_instalado  ins_sec_estudiante_secretos.txt
fmach_salir_si_no_instalado  ins_lang_pyworld_first.txt


source /home/"$USER"/.venv/bin/activate
R_LIBS_USER=/home/"$USER"/.local/lib/R/site-library
export R_LIBS_USER


# Instalo el servicio que actualiza kaggle al iniciar la virtual machine
sudo  cp  /home/"$USER"/machina/unit/kaggle@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable kaggle@"$USER".service
# no le doy start aun


fmach_registrar_instalacion $logito