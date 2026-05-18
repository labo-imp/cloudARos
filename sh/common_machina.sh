#!/bin/bash
# fecha revision   2026-05-18  12:02

export vmach_machinadir=/home/"$USER"/machina
vmach_bindir=/home/"$USER"/sh
vmach_logdir=/home/"$USER"/log

tabulador="	"
logfile=""$vmach_bindir"/log_install.txt"

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)
export MIHOST

fmach_bitacora() {
  local fecha=$(date +"%Y%m%d %H%M%S")

  echo "$fecha""$tabulador""$1"  >>  "$logfile"
}

fmach_salir_si_ya_instalado() {
  # si ya corrio esta seccion, exit
  [ -e ""$vmach_logdir"/$1" ] && exit 0
}


fmach_salir_si_no_instalado() {
  local archivo=$1
  [ ! -e ""$vmach_logdir"/$archivo" ] && exit 1
}

# grabo
fmach_registrar_instalacion() {
  fecha=$(date +"%Y%m%d %H%M%S")
  echo "$fecha" > "$vmach_logdir"/"$1"
}


export vmach_github_user="labo-imp"
export vmach_github_repo="cloudARos"

export vmach_gcprojprefix="machinae"
export vmach_gcprojname="Machinae"
export vmach_gcimagename="labo-image"
export vmach_gcimagefamily="labo-family"