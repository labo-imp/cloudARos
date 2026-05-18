#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

cd "$vcur_repo_catedra_destino"/backup/catedra  || exit 1
git checkout main
git pull origin main
