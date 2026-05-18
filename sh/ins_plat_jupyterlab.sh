#!/bin/bash
# fecha revision   2026-05-18  12:02

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_plat_jupyterlab.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_pyworld_last.txt


# instalo  Jupyter Labs, estando DENTRO  del Virtual Environment ----------------
# Documentacion  https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html
cd /home/"$USER" || exit 1
source  /home/"$USER"/.venv/bin/activate
uv cache clean

/home/"$USER"/.local/bin/uv pip install  pygments  oauthlib
 
# la instalacion de jupyter lab
/home/"$USER"/.local/bin/uv pip  install jupyterlab

# instalo nvm  version  v0.40.4  del  2026-01-29
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.40.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts


/home/"$USER"/.local/bin/uv pip  install jupyterlab-spreadsheet

# instalo extensiones de Jupyter Lab
jupyter labextension install  jupyterlab-chart-editor
jupyter labextension install  @jupyterlab/toc


# instalo git para Jupyter Lab
/home/"$USER"/.local/bin/uv pip install --upgrade  jupyterlab  jupyterlab-git

# por supuesto, la instalacion de Jupyter Lab ya instala el kernel de Python

# para que se pueda ingresar a  Jupyter en forma remota
mkdir -p /home/"$USER"/.jupyter/
cp  /home/"$USER"/machina/py/jupyter_server_config.py   /home/"$USER"/.jupyter/jupyter_server_config.py

mkdir /home/"$USER"/.venv/.jupyter
cp  /home/"$USER"/machina/py/jupyter_server_config.py   /home/"$USER"/.venv/.jupyter/jupyter_server_config.py

/home/"$USER"/.local/bin/uv pip  install  --upgrade nbconvert


fmach_bitacora   "plat_JupyterLab"
fmach_registrar_instalacion $logito