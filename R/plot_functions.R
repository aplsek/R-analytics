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
  main_title="YoungGen Occupation"
  qplot(timestamp,young.occ.start, main = main_title, data=data_gc, colour = gc.type)
}


sizeoldPlot <- function (data_gc) {
  main_title="OldGen Occupation (old.occ.start)"
  qplot(timestamp,old.occ.start, main = main_title, data=data_gc, colour = gc.type)
}

survPlot <- function (data_gc) {
  main_title="Survivor Size (survivor.start)"
  qplot(timestamp,survivor.start, main = main_title, data=data_gc)
}


occupation <- function (data_gc) {
  main_title="Heap Areas Occupation"
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
  main_title="Heap Area Sizes"
  # qplot(timestamp,old.occ.start, main = main_title, data=data_gc, colour = gc.type)
  
  ggplot() +
    geom_line(data = data_gc, aes(x = timestamp, y = old.size.start, color = "OldGen")) +
    geom_line(data = data_gc, aes(x = timestamp, y = young.size.start, color = "YoungGen"))  +
    geom_line(data = data_gc, aes(x = timestamp, y = heap.size.start, color = "Heap"))  +
    xlab('Time') +
    ylab('Heap Sizes [MB]')
}

#data.file <- "data.txt"
#data_gc= read.csv(data.file,sep=',', header=TRUE)
#plotGC2(data_gc)
#histo2(data_gc)

#sizeYoungPlot(data_gc)
#survPlot(data_gc)
#survivor.start(data_gc)
#occupation(data_gc)
#size(data_gc)



splitGCseries <- function(data.gc) {
  
  time <- data.gc$timestamp
  pause <- data.gc$pause.time
  sizeYoungStart <- data.gc$young.occ.start
  sizeYoungEnd <- data.gc$young.occ.end
  occOldStart <- data.gc$old.occ.start
  occOldEnd <- data.gc$old.occ.end
  survStart <- data.gc$survivor.start
  survEnd <- data.gc$survivor.end
  type<- data.gc$gc.type
  newTime <- c()
  sizeYoung <- c()
  occOld <- c()
  gcType <- c()
  surv <- c()
  j <- 1
  k<- 1
  #print(time[1])
  for (i in time) {
    newTime[j] <- i - pause[k]
    newTime[j+1] <- i
    sizeYoung[j] <- sizeYoungStart[k]
    sizeYoung[j+1] <- sizeYoungEnd[k]
    occOld[j] <- occOldStart[k]
    occOld[j+1] <- occOldEnd[k]
    surv[j] <- survStart[k]
    surv[j+1] <- survEnd[k]
    gcType[j] <-  type[k]
    gcType[j+1] <- type[k]
    j <- j+2
    k <- k +1
  }
  #newList
  dd <- data.frame(v1=newTime,v2=sizeYoung, v3=occOld, v4=gcType, v5=surv)
  colnames(dd) <- c("timestamp", "young", "old", "Type", "survivor")
  return(dd)
}

plotGCseries_Young <- function (data.gc) {
  dd<-splitGCseries(data.gc)
  qplot(timestamp,young, main = "test", data=dd,  geom="line")
  
}

plotGCseries_Survivor <- function (data.gc) {
  dd<-splitGCseries(data.gc)
  qplot(timestamp,survivor, main = "test", data=dd,  geom="line")

}



plotGCseriesOld <- function (data.gc) {
  dd<-splitGCseries(data.gc)
  
  #p<-qplot(timestamp,old, main = "test", data=dd, geom="line", log="y")
  qplot(timestamp,old, main = "test", data=dd,  geom="line")
  #p + geom_line(aes(colour = old))

  #print(type[1])
}