#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_kernels.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_pyworld_last.txt
fmach_salir_si_no_instalado  ins_plat_jupyterlab.txt


source  /home/"$USER"/.venv/bin/activate

#------------------------------------------------------------------------------
# configuro R para que pueda usarse desde Jupyter, kernel de R
# Cuarta instalacion de paquetes de R
# Documentacion  https://developers.refinitiv.com/article/setup-jupyter-notebook-r

if [ -e "$vmach_logdir"/ins_lang_rworld_last.txt ]; then
  Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_4.r
  fmach_bitacora   "R  kernel"
fi

# Used  25G
#------------------------------------------------------------------------------
# Agrego el kernel de Julia a Jupyterlab

if [ -e "$vmach_logdir"/ins_lang_jlworld_last.txt ]; then
  /home/"$USER"/.juliaup/bin/julia   /home/"$USER"/machina/jl/instalar_paquetes_julia_2.jl
  fmach_bitacora   "Julia kernel"
fi


fmach_bitacora   "Julia kernel"

#------------------------------------------------------------------------------
# Define home directory and data directory (adjust to your needs)

mkdir  -p /home/"$USER"/.jupyter/
USER_HOME_DIR=/home/"$USER"
DATA_DIR="$USER_HOME_DIR"/
export DATA_DIR
# Create the data directory

#------------------------------------------------------------------------------
# El servicio de Jupyter Lab

# password default
mkdir  -p /home/"$USER"/.jupyter
cat > /home/"$USER"/.jupyter/jupyter_server_config.json <<FILE
{
  "IdentityProvider": {
    "hashed_password": "argon2:$argon2id$v=19$m=10240,t=10,p=8$KuB64Bj/00OM/8CMhHaLPA$6yhxYaw+uQ+nl1GwDQObfuP8tG8ck1sjKIlF8ySLP/E"
  }
} 
FILE
chmod  0600    /home/"$USER"/.jupyter/jupyter_server_config.json


cp  /home/"$USER"/machina/py/jupyter_server_config.py   /home/"$USER"/.jupyter/jupyter_server_config.py



sudo  cp /home/"$USER"/machina/unit/jupyterlab@.service   /etc/systemd/system/
sudo  systemctl daemon-reload
sudo  systemctl enable jupyterlab@"$USER".service
sudo  systemctl start jupyterlab@"$USER".service

# systemctl status jupyterlab@"$USER".service


sleep 20
systemctl is-active --quiet jupyterlab@"$USER".service
if [ ! $? -eq 0 ]; then
    echo "servicio jupyterlab no esta funcionando"
    exit 1
else
  fecha=$(date +"%Y%m%d %H%M%S")
  echo "$fecha" > "$vmach_logdir"/$logito
fi


fmach_bitacora   "kernels"
fmach_registrar_instalacion $logito