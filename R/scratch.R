
headers = c("PauseTime", "AvgPause", "MaxPause", "#Gc-Pause" , "ttt")

existingDF <- as.data.frame(matrix(seq(20),nrow=5,ncol=4))
#r <- 6
#newrow <- c (12, 13)
r <- 6
newrow <- c (0, 0,0 ,0)


insertRow <- function(existingDF, newrow, r) {
  existingDF[seq(r+1,nrow(existingDF)+1),] <- existingDF[seq(r,nrow(existingDF)),]
  existingDF[r,] <- newrow
  existingDF
}

insertRow2 <- function(existingDF, newrow, r) {
  existingDF <- rbind(existingDF,newrow)
  existingDF <- existingDF[order(c(1:(nrow(existingDF)-1),r-0.5)),]
  row.names(existingDF) <- 1:nrow(existingDF)
  return(existingDF)  
}

row.names(existingDF)  <- headers


existingDF

existingDF <- insertRow2(existingDF, newrow, r)

existingDF


DF <- data.gc

#print_summary(data.gc)

data.gc[!duplicated(data.gc$gc.type), ]


types <- subset(DF, !duplicated(DF$gc.type))$gc.type

for (type in types ) {
  print(type)
}


#attach(data.gc)
#sum(pause.time)
#detach(data.gc)


#plotPauseHisto(data.gc)
#plotPause(data.gc)

#plotGCtype(data.gc)


#color <- GC_TYPES$["g1evac"]
#print(GC_TYPES)


#color <- GC_TYPES$colors[GC_TYPES$types == "g1evac"]
#color