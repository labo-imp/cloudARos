options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")


pak::pkg_install( c("gratis","gravitas","greybox","gsarima","gsignal"))
pak::pkg_install( c("hht","hpfilter","hts","hwwntest","imputeTestbench","imputeTS"))
pak::pkg_install( c("IncDTW","influxdbr","InspectChangepoint","itsmr","jalcal"))
pak::pkg_install( c("kalmanfilter","KFAS","kza","legion","locits","lomb"))
pak::pkg_install( c("lpacf","LSTS","LSWPlib","ltsa","lubridate"))
pak::pkg_install( c("MAPA","mAr","MARSS","mbsts","Mcomp","meboot","mFilter"))
pak::pkg_install( c("mgm","mixAR","mlVAR","modeltime","modeltime.ensemble"))
pak::pkg_install( c("modeltime.resample","mondate","mrf","MSwM","MTS","mtsdi"))
pak::pkg_install( c("multDM","MultiGlarmaVarSel","MultipleBubbles","multitaper"))
pak::pkg_install( c("mvLSW","nardl","NlinTS","nlts","nnfor"))


quit( save="no" )
