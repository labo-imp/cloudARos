#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_jlworld_first.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_sys_system.txt


# Instalo Julia   version: 1.12.6  | Release Date: 2026-04-10 ---------------
# Documentacion  https://julialang.org/downloads/platform/#linux_and_freebsd

sudo  DEBIAN_FRONTEND=noninteractive  apt-get update

# Instalo la ultima version estable de Julia
cd  "$vmach_bindir"/  || exit 1
curl -fsSL https://install.julialang.org > julia_install.sh
chmod  u+x "$vmach_bindir"/julia_install.sh
./julia_install.sh --yes  --add-to-path true

cd  /home/"$USER" || exit 1
. /home/"$USER"/.bashrc 
source  /home/"$USER"/.venv/bin/activate

# corro script de Julia que genera un archivo
/home/"$USER"/.juliaup/bin/julia  /home/"$USER"/machina/jl/test_julia.jl  "$vmach_logdir"/ins_julia.txt
[ ! -e "$vmach_logdir/ins_julia.txt" ] && exit 1


fmach_bitacora   "Julia language"
fmach_registrar_instalacion $logito