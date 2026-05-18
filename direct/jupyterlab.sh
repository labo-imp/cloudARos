#!/bin/bash

# cambio la clave cada vez que inicio el proceso de  jupyter-lab

# elimino archivo jupyter_server_config.py , haciendo backup
rm -f /home/"$USER"/.jupyter/jupyter_server_config.py.old
if [ -f /home/"$USER"/.jupyter/jupyter_server_config.py ]; then
    mv  /home/"$USER"/.jupyter/jupyter_server_config.py  /home/"$USER"/.jupyter/jupyter_server_config.py.old
fi

source  /home/"$USER"/.venv/bin/activate

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MY_PROJECT_ID=$(/usr/bin/gcloud projects list --filter="projectId~$vcur_gcprojprefix AND lifecycleState:ACTIVE" --format="value(projectId)")
gcloud config set project "$MY_PROJECT_ID"

CLAVE=$(/usr/bin/gcloud secrets versions access latest --secret="ds-password")
PW_HASH=$(python3 -c "from jupyter_server.auth import passwd; print(passwd('$CLAVE'))")


cat >  /home/"$USER"/.jupyter/jupyter_server_config.json << FILE
{
  "IdentityProvider": {
    "hashed_password": "$PW_HASH"
  }
}
FILE

chmod  0600    /home/"$USER"/.jupyter/jupyter_server_config.json
mkdir -p /home/"$USER"/buckets/b1/exp

# llamada a jupyter-lab
cd  /home/"$USER"/.jupyter/ || exit 1
/home/"$USER"/.venv/bin/jupyter-lab --no-browser --port=8888 --ip=0.0.0.0 --NotebookApp.token= --notebook-dir=/home/"$USER"/

cd /home/"$USER" || exit 1

