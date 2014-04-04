library(knitr)
render_html()
#source("hooks.R") # mods to defaults
inFile = commandArgs(trailingOnly=TRUE)[1]
data.file = commandArgs(trailingOnly=TRUE)[2]
report.id = commandArgs(trailingOnly=TRUE)[3]
outFile = commandArgs(trailingOnly=TRUE)[4]
knit(inFile,output=outFile)