
types <- c("g1-young", "g1evac", "g1full", "g1-young_to-spaceexhausted", "g1-young_initial-mark_to-spaceexhausted", "g1-young_initial-mark", "g1-mixed")
colors <- c("blue", "green", "red", "dark red", "dark red", "yellow", "brown")
GC_TYPES <-  data.frame(colors,types)


# Plot GC Pause Time Distribution
plotPauseHisto <- function (data.gc) {
  plot.title <- "GC Pause Time Distribution"
  with(data.gc, {
    hist(pause.time,breaks=100, 
         xlab="GC Pause Time(sec)",
         xlim=c(0,1.0),
         main=plot.title)
  })   
}

plotGC <- function (data.gc) {
  title <-"GC Timeline"
  x_lab = "Elapsed Time (s)"
  y_lab = "GC Pause Time Time(s)"
  
  plot(0,0,xlim = c(-10,10),ylim = c(-10,10),type = "n")
  
  with(data.gc, {
    for (type in GC_TYPES) {
      gc.p <- pause.time[gc.type == type]
      gc.t <- timestamp[gc.type == type]
      color <- GC_TYPES$colors[GC_TYPES$types == type]
      
      lines(gc.p,
            gc.t,col=color,type="h")
    }
  }
}

plotGCtype <- function(data.gc) {
with(data.gc, {
  title <-"GC Timeline"
  gc.minor <- pause.time[gc.type == "g1evac"]
  gc.minor.t <- timestamp[gc.type == "g1evac"]
  gc.full <- pause.time[gc.type == "g1young"]
  gc.full.t <- timestamp[gc.type == "g1young"]
  
  #print(gc.full)
  #print(gc.full.t)
  
  # Plot bars for full GC pause time 
  plot(gc.full.t,
       gc.full,
       xlab=x_lab,
       ylab=y_lab,type='h',
       main=title,col="blue")
  
  # Plot bars for minor GC pause time
  lines(gc.minor.t,
        gc.minor,col="dark green",type="h")
  
  # Set tick marks for every hour
  axis(1,seq(0,18,1))
  grid()
})
}

plotPause <- function (data.gc) {
  plot.title <- "GC Pauses Timeline"
  xtitle <- 'Elapsed Time (s)'
  ytitle <-'PauseTime (s)'
  with(data.gc, {
    x <- timestamp
    y <- pause.time
    plot(x,y,
         xlab=xtitle,ylab=ytitle,
         main=plot.title,type='o',col='blue')
  })
}

plot.pause.box <- function(data.gc) {
  plot.title <- "GC Pause Time Distribution as Boxplot"
  with(data.gc, {
    boxplot(pause.time ~ gc.type,main=plot.title)
  }) 
}

plot.survivor <- function(data.gc) {
  
  # Plot survived Heap
  xtitle <- 'Elapsed Time (hrs)'
  ytitle <-'Survivor Heap (MB)'
  plot.title <- "Survived Heap after Minor GC"
  
  with(data.gc, {
    
    x <- timestamp
    y <- young.end
    plot(x,y,
         xlab=xtitle,ylab=ytitle,
         main=plot.title,type='o',col='blue')
    
    # Plot on secondary axis
    par(new=TRUE)
    plot(x,pause.time,
         axes=FALSE,type='o',
         col="green",pch=23,xlab="",ylab="")
    axis(4)
    mtext("GC Pause Time (sec)",4)
  })
}

plot_old_gen <- function(data.gc) {
  # Check for memory leak
  xtitle <- 'Elapsed Time (hrs)'
  ytitle <-'Old Gen Heap (MB)'
  
  
  with(data.gc, {
    plot.title <- "Old Gen Space after Full GC"
    x <- sec.to.hours(timestamp[gc.type=="full"])
    y <- kb.to.mb(old.end[gc.type=="full"])
    plot(x,y,
         xlab=xtitle,ylab=ytitle,main=plot.title,type='o',col='blue')
    
    # Add fitted line
    abline(lm(y ~ x),col="red")
    retval <<- lm(y ~ x)
  })
  retval
}


plot_promo_rate <- function (data.gc) {
  
  
  plot.title <- "Heap Promoted into Old Gen Space"
  with(data.gc, {
    old.end <- kb.to.mb(heap.end - young.end)
    x <- sec.to.hours(timestamp)
    # If there is a full GC, promoted heap size would go negative
    y <- diff(old.end)
    plot(x[-1],y,
         xlab="Elapsed Time (hrs)",
         ylab="Promoted Heap (MB)",type='h',
         main=plot.title)
    grid()
  })
  
}