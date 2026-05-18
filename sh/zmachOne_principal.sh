#!/bin/bash
# fecha revision   2026-05-18  12:02

# abort on any subprocess error
set -eo pipefail

# apagado por si se olvidaron
echo "Apagado" && sleep 10800 &&  /home/"$USER"/machina/direct/apagar_vm.sh  &

# verifico el repo de la catedra
/home/"$USER"/machina/sh/ins_common.sh


# lo minimo necesario antes de secretos
/home/"$USER"/machina/sh/ins_sys_architecture.sh
/home/"$USER"/machina/sh/ins_sys_services_recrear.sh
/home/"$USER"/machina/sh/ins_sys_buckets.sh

/home/"$USER"/machina/sh/ins_sec_estudiante_secretos.sh

/home/"$USER"/machina/sh/ins_crear_repos.sh
/home/"$USER"/machina/sh/ins_autoexec.sh

# instalacion pesada
/home/"$USER"/machina/sh/ins_sys_system.sh
/home/"$USER"/machina/sh/ins_sys_gnome.sh

# tonterias
/home/"$USER"/machina/sh/ins_sys_halfswap.sh
/home/"$USER"/machina/sh/ins_sys_sysstat.sh
/home/"$USER"/machina/sh/ins_tool_expshared.sh
/home/"$USER"/machina/sh/ins_tool_semaforo.sh
/home/"$USER"/machina/sh/ins_datasets.sh
/home/"$USER"/machina/sh/ins_plat_zulip.sh

# los lenguajes y sus paquetes
/home/"$USER"/machina/sh/ins_lang_pyworld_first.sh
/home/"$USER"/machina/sh/ins_lang_rworld_first.sh
/home/"$USER"/machina/sh/ins_lang_jlworld_first.sh

# utilidades
/home/"$USER"/machina/sh/ins_tool_memcpu.sh
/home/"$USER"/machina/sh/ins_lang_mlflow.sh
/home/"$USER"/machina/sh/ins_plat_kaggle.sh


# instalacion de paquetes de los lenguajes
/home/"$USER"/machina/sh/ins_lang_pyworld_last.sh
/home/"$USER"/machina/sh/ins_lang_rworld_last.sh
/home/"$USER"/machina/sh/ins_lang_jlworld_last.sh

/home/"$USER"/machina/sh/ins_runatboot.sh
/home/"$USER"/machina/sh/ins_plat_jupyterlab.sh
/home/"$USER"/machina/sh/ins_lang_kernels.sh


/home/"$USER"/machina/sh/ins_sys_gnome_apps.sh
/home/"$USER"/machina/sh/ins_sys_gnome_menus.sh


sudo adduser "$USER" sudo

sudo  DEBIAN_FRONTEND=noninteractive   apt-get  --yes  update
sudo  DEBIAN_FRONTEND=noninteractive   apt-get  --yes  dist-upgrade
sudo  DEBIAN_FRONTEND=noninteractive   apt-get  --yes  autoremove


printf "\n\n\n"
printf "Ha finalizado la parte  desatendida  de la instalacion\n\n"
