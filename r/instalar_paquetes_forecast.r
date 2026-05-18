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

paq10 <- c("mlr3","mlr3mbo","mlr3learners","mlr3tuning","bbotk")
paq11 <- c("forecast","prophet","sarima","tseries","tsibble","timeSeries")
paq12 <- c("zoo","xts","dtw","ptw","rucrdtw","IncDTW","twdtw","collapse")
paq13 <- c("tis","fable","modeltime","modeltime.ensemble","modeltime.resample")
pak::pkg_install( c(paq10, paq11, paq12, paq13) )



paq14 <- c("legion","MAPA","forecTheta","gsarima")
paq15 <- c("BayesARIMAX","partsm","pcts","TSLSTM","TSdeeplearning","TSANN","feasts")
pak::pkg_install( c(paq14, paq15) )


paq20 <- c("AER","africamonitor","aion","almanac","ARCensReg","ArDec")
paq21 <- c("ARDL","ardl.nardl","arfima","ASSA","astsa","autostsm")
paq22 <- c("BayesARIMAX","bayesRecon","BAYSTAR")
paq23 <- c("bentcableAR","beyondWhittle","bfast","BGVAR","bigtime")
paq24 <- c("BigVAR","biwavelet","blocklength", "BNPTSclust","boot")
paq25 <- c("BootPR","bootUR","breakfast","bspec","bsts","bsvars")
paq26 <- c("bundesbank","BVAR","bvartools","CADFtest","carfima","CFtime")
paq27 <- c("changepoint","changepoint.geo","changepoint.np","chron","clock")
paq28 <- c("coconots","cointReg","costat","ctbi","dataseries","datetimeoffset")
paq29 <- c("DChaos","dCovTS","depmixS4","dfms","diffusion","DIMORA")
pak::pkg_install( c( paq20, paq21, paq22, paq23, paq24, paq25, paq26, paq27, paq28, paq29 ) )


paq30 <- c("disaggR","dLagM","dlm","dlnm","DTSg","dtts","dtw")
paq31 <- c("dtwclust","dygraphs","dyn","dynlm","EBMAforecast","ecb","Ecdat")
paq32 <- c("ecm","ecp","EMD","ensembleBMA","era","esemifar","EXPARMA")
paq33 <- c("expsmooth","fable.prophet","fabletools","fanplot","FAVAR","FCVAR")
paq34 <- c("fdaACF","fGarch","finnts","FinTS","FKF","FKF.SP")
paq35 <- c("fma","fnets","fNonlinear","ForeCA","forecastHybrid")
paq36 <- c("forecastLSW","FoReco","ForeComp","forecTheta")
paq37 <- c("fpp2","fpp3","fracdiff","fredr","freqdom")
paq38 <- c("funtimes","garma","gasmodel","gdpc")
paq39 <- c("glarma","GlarmaVarSel","GMDH","gmvarkit","GNAR","graphicalVAR")
pak::pkg_install( c( paq30, paq31, paq32, paq33, paq34, paq35, paq36, paq37, paq38, paq39 ) )



paq40 <- c("gratis","gravitas","greybox","gsarima","gsignal")
paq41 <- c("hht","hpfilter","hts","hwwntest","imputeTestbench","imputeTS")
paq42 <- c("IncDTW","influxdbr","InspectChangepoint","itsmr","jalcal")
paq43 <- c("kalmanfilter","KFAS","kza","legion","locits","lomb")
paq44 <- c("lpacf","LSTS","LSWPlib","ltsa","lubridate")
paq45 <- c("MAPA","mAr","MARSS","mbsts","Mcomp","meboot","mFilter")
paq46 <- c("mgm","mixAR","mlVAR","modeltime","modeltime.ensemble")
paq47 <- c("modeltime.resample","mondate","mrf","MSwM","MTS","mtsdi")
paq48 <- c("multDM","MultiGlarmaVarSel","MultipleBubbles","multitaper")
paq49 <- c("mvLSW","nardl","NlinTS","nlts","nnfor")

pak::pkg_install( c( paq40, paq41, paq42, paq43, paq44, paq45, paq46, paq47, paq48, paq49 ) )


quit( save="no" )
