######## import
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
data.file <- args[1]
#data.file <- "input.txt"

#data.gc <- read.csv(data.file,sep=',', header=TRUE)
data.gc= read.csv(data.file,sep=',', header=TRUE)



#print_summary(data.gc)

computeStats(data.gc)



#plotGC(data.gc)

#plotPauseHisto(data.gc)

print("Hello World")