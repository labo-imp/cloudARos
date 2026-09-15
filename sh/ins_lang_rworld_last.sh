#!/bin/bash
# fecha revision   2026-09-14  17:47

# shellcheck source=SCRIPTDIR/common_machina.sh
source  /home/"$USER"/machina/sh/common_machina.sh

logito="ins_lang_rworld_last.txt"
fmach_salir_si_ya_instalado $logito
fmach_salir_si_no_instalado  ins_lang_rworld_first.txt

sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  update
sudo  DEBIAN_FRONTEND=noninteractive  apt-get --yes  dist-upgrade



# xgboost instalo la ultima version de desarrollo de XGBoost
# Documentacion  https://xgboost.readthedocs.io/en/latest/build.html
/home/"$USER"/machina/sh/ins_lang_lib_xgboost.sh  &
fmach_bitacora   "R  xgboost"

# Used  27G


# LightGBM instalo version de desarrollo
# Documentacion  https://lightgbm.readthedocs.io/en/latest/Installation-Guide.html#linux
/home/"$USER"/machina/sh/ins_lang_lib_lightgbm.sh  &
fmach_bitacora   "R  lightgbm"


sleep 300

fmach_bitacora   "R  packages lentos a"
/home/"$USER"/machina/sh/ins_lang_lib_lentosR.sh
fmach_bitacora   "R  packages lentos b"


# Segunda instalacion de paquetes de R , 40 minutos en vm  t2d-standard-4
fmach_bitacora   "R  packages 2a"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_2.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages 2b"

# Paquetes Forecast
fmach_bitacora   "R  packages forecast_1"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_1.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages forecast_2"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_2.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages forecast_3"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_3.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages forecast_4"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_4.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages forecast_5"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_5.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages forecast_6"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_6.r  | sudo tee -a "$vmach_bindir"/log.txt
fmach_bitacora   "R  packages forecast_7"
Rscript --verbose  /home/"$USER"/machina/r/instalar_paquetes_forecast_7.r  | sudo tee -a "$vmach_bindir"/log.txt

fmach_bitacora   "R  packages forecast_final"

# Used  30G

fmach_bitacora   "lang_rlang_paquetes"
fmach_registrar_instalacion $logito