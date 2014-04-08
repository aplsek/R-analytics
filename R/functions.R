#if(!exists(headers, mode="function")) source("R/constants.R")
source("R/constants.R")
source("R/utils.R")

library(xtable)



###########################################


printStats <- function(df) {
  #rownames(df) <- df[,1]
  #  colnames(df) <- c("GCType", "CNT", "time", "Avg", "Max")
  #df[1] <- NULL
  #df <- df[,-1,drop=FALSE]
  
  print(df)
  
  #print(xtable(df), type = "html")
}


printStats2 <- function() {
  #rownames(df) <- df[,1]
#  colnames(df) <- c("GCType", "CNT", "time", "Avg", "Max")
  #df[1] <- NULL
  #df <- df[,-1,drop=FALSE]
 
  print(df)
  
 # print(xtable(df), type = "html")
}

statsByGCType <-function(data.gc) {
  #initSummary()
  df<-NULL;
  attach(data.gc)
  for (type in GC_TYPES) {
    pause_count = int(length(pause.time[gc.type == type])) 
    if (pause_count != 0) {
        gc.type.pause = round_dec(sum(pause.time[gc.type == type], na.rm = TRUE) )
        gc.type.avg = round_dec(mean(pause.time[gc.type == type], na.rm = TRUE) )
        gc.type.max = round_dec(max(pause.time[gc.type == type], na.rm = TRUE) )       
        df <-addRow(df,c(type, pause_count, gc.type.pause, gc.type.avg, gc.type.max))
    } 
  }
  detach(data.gc)
  

  colnames(df) <- c("GCType", "Cnt", "Time [s]", "Avg [s]", "Max [s]")
  #printStats(df)
 
  return(df)
}



statsMain <- function(data.gc) {
  df<-NULL;
  attach(data.gc)
    
  total_pause = round_dec(sum(pause.time, na.rm = TRUE))            # Time spent in GC
  avg_pause = round_dec(mean(pause.time, na.rm = TRUE)) 
  max_pause = round_dec(max(pause.time, na.rm = TRUE)) 
  pause_count = int(length(pause.time)) 
  run_time=round_dec(max(timestamp, na.rm = TRUE) - min(timestamp, na.rm = TRUE))
  gc_thrpt=round_dec(total_pause*100.0/run_time)                 # Percentage of time spent in GC
  avg_promo = round_dec(mean(promoRate, na.rm = TRUE)) 
  
  df <-addRow(df,c("PauseTime [s]", total_pause))
  df <-addRow(df,c("AvgPause [s]", avg_pause))
  df <-addRow(df,c("MaxPause [s]", max_pause))
  df <-addRow(df,c("#Gc-Pause", pause_count))
  df <-addRow(df,c("Run Time[s]", run_time))
  df <-addRow(df,c("GC-Throughput [%]", gc_thrpt))
 
  # TODO: fix for all different Full GCs types!!
  full_count = int(length(gc.type[gc.type == "g1-full"])) + int(length(gc.type[gc.type == "ParOld-full"]))
  if (full_count > 0 ) {
    print("full GCs!")
    df <-addRow(df,c("Full GCs", full_count))
    
    liveDataSize <- mean(old.occ.end[gc.type == "ParOld-full"]) 
    df <-addRow(df,c("Avg. Live Data Size", liveDataSize))
  }
  
  df <-addRow(df,c("Avg Promotion Rate [MB/s]", avg_promo))
  
  detach(data.gc)
  #printStats(df)
  colnames(df) <- c("Stat", "Value")
  #df[1] <- NULL
  return(df)
}


computeStats <- function(data.gc) {
  statsMain(data.gc)
  #statsByGCType(data.gc) 
}





