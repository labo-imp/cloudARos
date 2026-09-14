options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")


# muy pesados
pak::pkg_install("smooth")
pak::pkg_install("bayesforecast")
pak::pkg_install("bayesdfa")
pak::pkg_install("bayesm")
pak::pkg_install("Rlgt")
pak::pkg_install("bssm")
pak::pkg_install("Boom")
pak::pkg_install("HDTSA")

pak::pkg_install( c("mlr3","mlr3mbo","mlr3learners","mlr3tuning","bbotk"))
pak::pkg_install( c("forecast","prophet","sarima","tseries","tsibble","timeSeries"))
pak::pkg_install( c("zoo","xts","dtw","ptw","rucrdtw","IncDTW","twdtw","collapse"))
pak::pkg_install( c("tis","fable","modeltime","modeltime.ensemble","modeltime.resample"))


pak::pkg_install( c("legion","MAPA","forecTheta","gsarima"))
pak::pkg_install( c("partsm","pcts","TSLSTM","TSdeeplearning","TSANN","feasts"))


pak::pak( c("DavisVaughan/almanac")) 

pak::pkg_install( c("AER","africamonitor"))
pak::pkg_install( c("aion","ARCensReg","ArDec"))
pak::pkg_install( c("ARDL","ardl.nardl","arfima","ASSA","astsa","autostsm"))
pak::pkg_install( c("bayesRecon","BAYSTAR"))
pak::pkg_install( c("bentcableAR","beyondWhittle","bfast","BGVAR","bigtime"))

pak::pkg_install( c("BigVAR","biwavelet","blocklength", "BNPTSclust","boot"))
pak::pkg_install( c("BootPR","bootUR","breakfast","bspec","bsts","bsvars"))
pak::pkg_install( c("bundesbank","BVAR","bvartools","CADFtest","carfima","CFtime"))
pak::pkg_install( c("changepoint","changepoint.geo","changepoint.np","chron","clock"))
pak::pkg_install( c("coconots","cointReg","costat","ctbi","dataseries","datetimeoffset"))
pak::pkg_install( c("DChaos","dCovTS","depmixS4","dfms","diffusion","DIMORA"))


pak::pkg_install( c("disaggR","dLagM","dlm","dlnm","DTSg","dtts","dtw"))
pak::pkg_install( c("dtwclust","dygraphs","dyn","dynlm","EBMAforecast","ecb","Ecdat"))
pak::pkg_install( c("ecm","ecp","EMD","ensembleBMA","era","esemifar","EXPARMA"))
pak::pkg_install( c("expsmooth","fable.prophet","fabletools","fanplot","FAVAR","FCVAR"))
pak::pkg_install( c("fdaACF","fGarch","finnts","FinTS","FKF"))
pak::pkg_install( c("fma","fnets","fNonlinear","ForeCA","forecastHybrid"))
pak::pkg_install( c("forecastLSW","FoReco","ForeComp","forecTheta"))
pak::pkg_install( c("fpp2","fpp3","fracdiff","fredr","freqdom"))
pak::pkg_install( c("funtimes","garma","gasmodel","gdpc"))
pak::pkg_install( c("glarma","GlarmaVarSel","GMDH","gmvarkit","GNAR","graphicalVAR"))



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
