options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")


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



quit( save="no" )
