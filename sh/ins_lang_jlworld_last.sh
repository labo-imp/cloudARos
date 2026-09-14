#!/bin/bash
# fecha revision   2026-09-14  17:47

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_jlworld_last.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_jlworld_first.txt


# genero script con paquetes a instalar de Julia
# Documentacion  https://datatofish.com/install-package-julia/

source  /home/"$USER"/.venv/bin/activate
/home/"$USER"/.local/bin/uv cache clean

/home/"$USER"/.juliaup/bin/julia  /home/"$USER"/machina/jl/instalar_paquetes_julia_1.jl


deactivate


fmach_bitacora   "Julia packages"
fmach_registrar_instalacion $logito