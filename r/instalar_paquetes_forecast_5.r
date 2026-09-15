options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")

pak::pkg_install( c("BigVAR","biwavelet","blocklength", "BNPTSclust","boot"))
pak::pkg_install( c("BootPR","bootUR","breakfast","bspec","bsts","bsvars"))
pak::pkg_install( c("bundesbank","BVAR","bvartools","CADFtest","carfima","CFtime"))
pak::pkg_install( c("changepoint","changepoint.geo","changepoint.np","chron","clock"))
pak::pkg_install( c("coconots","cointReg","costat","ctbi","dataseries","datetimeoffset"))
pak::pkg_install( c("DChaos","dCovTS","depmixS4","dfms","diffusion","DIMORA"))


quit( save="no" )
