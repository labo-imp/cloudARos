options(repos = c("https://cloud.r-project.org/"))
options(Ncpus = 8)

require("bspm")
bspm::disable()
require("pak")



pak::pkg_install( c("AER","africamonitor"))
pak::pkg_install( c("aion","ARCensReg","ArDec"))
pak::pkg_install( c("ARDL","ardl.nardl","arfima","ASSA","astsa","autostsm"))
pak::pkg_install( c("bayesRecon","BAYSTAR"))
pak::pkg_install( c("bentcableAR","beyondWhittle","bfast","BGVAR","bigtime"))

quit( save="no" )
