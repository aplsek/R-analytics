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



#print_summary(data.gc)

#computeStats(data.gc)

df <-statsMain(data.gc)
#
#df <- df[,-1,drop=FALSE]
df

dd <- as.data.frame(df)
dd

#tab <- xtable(summary(df))
#print(tab, type="html")


tab1 <- gvisTable(dd, options = list(width = 600, height = 650,
                                     page = "enable", pageSize = nrow(dd)))
print(tab1, "chart")



#plotGC(data.gc)

#plotPauseHisto(data.gc)

print("Hello World")