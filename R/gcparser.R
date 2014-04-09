######## import
library(googleVis)
library(MASS)

#if(!exists(plotPauseHisto, mode="function")) source("R/plot_functions.R")
#if(!exists(headers, mode="function")) source("R/constants.R")
#if(!exists(add, mode="function")) source("R/functions.R")
source("R/constants.R")
source("R/functions.R")
source("R/plot_functions.R")
#####
#####

#### RUN

args <- commandArgs(trailingOnly = TRUE)

print(args)
#data.file <- args[1]
data.file <- "data.txt"
data.file <- "dataParOld.txt"

#data.gc <- read.csv(data.file,sep=',', header=TRUE)
data.gc= read.csv(data.file,sep=',', header=TRUE)
df <- allocationRate(data.gc)

dd<-statsMain(df)
dd
#save(df,file="out.txt")
write.csv(df,file="out.txt",row.names=TRUE)

#plotLiveDataSize(data.gc)

plotAllocationRate(df)

#df <-statsByGCType(data.gc)
#df