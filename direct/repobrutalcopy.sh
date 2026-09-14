#!/bin/bash

# shellcheck source=SCRIPTDIR/../sh/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh
# shellcheck source=SCRIPTDIR/../curso/common_curso.sh
source  /home/"$USER"/machina/curso/common_curso.sh

MIHOST=$(echo "$HOSTNAME" | /usr/bin/cut -d . -f1)

cd  "$vcur_repo_catedra_destino"/"$vcur_github_catedra_repo"  || exit 1
git checkout "$MIHOST" || git checkout -b  "$MIHOST"
rsync -a "$vcur_repo_catedra_destino"/"$vcur_github_catedra_repo"/   /home/"$USER"/buckets/b1/backup/"$vcur_github_catedra_repo"/  --delete-after


if [[ "$MIHOST" == "desktop-analistajr" ]]; then
  rsync -a /home/"$USER"/buckets/b1/   /home/"$USER"/buckets/b2/
fi

date >> "$vmach_bindir"/repobrutalcopy.txt
