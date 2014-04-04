source("R/constants.R")
source("R/utils.R")


library(ggplot2)




plotGC2 <- function (data.gc) {
  main_title="GC Timeline"
  qplot(timestamp,pause.time, main = main_title, data=data.gc, colour = gc.type)
}

histo2 <- function(data.gc) {
  main_title="PauseTime Histogram"
  #ggplot(data.gc, aes(x = pause.time)) + geom_histogram(binwidth = 0.25, fill = aes(colour = gc.type))
  ggplot(data.gc, main = main_title, aes(x=pause.time, fill = gc.type)) + geom_histogram(binwidth = 0.25,alpha = 0.5, position = "identity")
}



#data.gc= read.csv(data.file,sep=',', header=TRUE)
#plotGC2(data.gc)
#histo2(data.gc)


