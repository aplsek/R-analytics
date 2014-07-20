# main file
source('R/constants.R')
source('R/utils.R')
source('R/functions.R')
source('R/plot_functions.R')
source('R/style.R')

inFile = commandArgs(trailingOnly=TRUE)[1]
data.file = commandArgs(trailingOnly=TRUE)[2]
report.id = commandArgs(trailingOnly=TRUE)[3]
#outFile = commandArgs(trailingOnly=TRUE)[4]


#data.file <- args[1]
#data.file <- "data.txt"
#data.file <- "dataParOld.txt"

outFile.stats <- "gc.stats.txt"
outFile <- "table.out.txt"
outFile2 <- "table-gctype.out.txt"
data.gc <- read.csv(data.file,sep=',', header=TRUE)
data.gc <- computeAllocationRate(data.gc)
write.csv(file=outFile.stats, x=data.gc)
#write.csv(file=outFile, x=data.gc)

df <-statsMain(data.gc)
dd <- as.data.frame(df)
write.csv(file=outFile, x=dd)

df <-statsByGCType(data.gc)

dd <- as.data.frame(df)
write.csv(file=outFile2, x=dd)
