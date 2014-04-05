source("R/constants.R")
source("R/utils.R")


library(ggplot2)




plotGC2 <- function (data_gc) {
  main_title="GC Timeline"
  qplot(timestamp,pause.time, main = main_title, data=data_gc, colour = gc.type)
}

histo2 <- function(data_gc) {
  main_title="PauseTime Histogram"
  #ggplot(data_gc, aes(x = pause.time)) + geom_histogram(binwidth = 0.25, fill = aes(colour = gc.type))
  ggplot(data_gc, main = main_title, aes(x=pause.time, fill = gc.type)) + geom_histogram(binwidth = 0.25,alpha = 0.5, position = "identity")
}

sizeYoungPlot <- function (data_gc) {
  main_title="GC Timeline"
  qplot(timestamp,young.occ.start, main = main_title, data=data_gc, colour = gc.type)
}


sizeoldPlot <- function (data_gc) {
  main_title="GC Timeline"
  qplot(timestamp,old.occ.start, main = main_title, data=data_gc, colour = gc.type)
}

survPlot <- function (data_gc) {
  main_title="GC Timeline"
  qplot(timestamp,survivor.start, main = main_title, data=data_gc)
}


occupation <- function (data_gc) {
  main_title="GC Timeline"
  # qplot(timestamp,old.occ.start, main = main_title, data=data_gc, colour = gc.type)
  
  ggplot() +
    geom_line(data = data_gc, aes(x = timestamp, y = old.occ.start, color = "OldGen")) +
    geom_line(data = data_gc, aes(x = timestamp, y = young.occ.start, color = "YougnGen"))  +
    geom_line(data = data_gc, aes(x = timestamp, y = survivor.start, color = "survivor"))  +
    geom_line(data = data_gc, aes(x = timestamp, y = heap.occ.end, color = "Heap"))  +
    xlab('Time') +
    ylab('Occupation [MB]')
}

size <- function (data_gc) {
  main_title="GC Timeline"
  # qplot(timestamp,old.occ.start, main = main_title, data=data_gc, colour = gc.type)
  
  ggplot() +
    geom_line(data = data_gc, aes(x = timestamp, y = old.size.start, color = "OldGen")) +
    geom_line(data = data_gc, aes(x = timestamp, y = young.size.start, color = "YougnGen"))  +
    geom_line(data = data_gc, aes(x = timestamp, y = heap.size.start, color = "Heap"))  +
    xlab('Time') +
    ylab('Occupation [MB]')
}

data.file <- "data.txt"
data_gc= read.csv(data.file,sep=',', header=TRUE)
#plotGC2(data_gc)
#histo2(data_gc)

#sizeYoungPlot(data_gc)
#survPlot(data_gc)
#survivor.start(data_gc)
occupation(data_gc)
size(data_gc)