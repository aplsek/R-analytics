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

#data.gc <- read.csv(data.file,sep=',', header=TRUE)
data.gc= read.csv(data.file,sep=',', header=TRUE)

A <- function(x) {
  as.POSIXlt(x, origin="2014-01-01")
}

x <- 5138.7070
#as.POSIXct(Sys.Date())+x/1000
ISOdatetime(2013,8,22,0,0,0) +  5138.7070/1e3
as.POSIXct(as.numeric(ISOdatetime(2013,8,22,0,0,0)) +  34200577/1e3,  origin="1970-01-01")

tt <- c ("timestamp")
dd <-data.file
dd <- lapply(dd[tt], A)
dd



plotGCseriesOld(data.gc)
plotGCseries_Survivor(data.gc)
