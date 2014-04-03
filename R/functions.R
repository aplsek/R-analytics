#if(!exists(headers, mode="function")) source("R/constants.R")
source("R/constants.R")
source("R/utils.R")





###########################################




printStats <- function() {
  #rownames(df) <- df[,1]
  #  colnames(df) <- c("GCType", "CNT", "time", "Avg", "Max")
  #df[1] <- NULL
  #df <- df[,-1,drop=FALSE]
  
  print(df)
}

statsByGCType <-function(data.gc) {
  initSummary()
  attach(data.gc)
  for (type in GC_TYPES) {
    pause_count = int(length(pause.time[gc.type == type])) 
    if (pause_count != 0) {
      gc.type.pause = round_dec(sum(pause.time[gc.type == type], na.rm = TRUE) )
      gc.type.avg = round_dec(mean(pause.time[gc.type == type], na.rm = TRUE) )
      gc.type.max = round_dec(max(pause.time[gc.type == type], na.rm = TRUE) )       
      addRow(c(type, pause_count, gc.type.pause, gc.type.avg, gc.type.max))
    } 
  }
  detach(data.gc)
  
  
  colnames(df) <<- c("GCType", "Cnt", "Time [s]", "Avg [s]", "Max [s]")
  printStats()
}



statsMain <- function(data.gc) {
  initSummary()
  attach(data.gc)
  
  total_pause = round_dec(sum(pause.time, na.rm = TRUE))            # Time spent in GC
  avg_pause = round_dec(mean(pause.time, na.rm = TRUE)) 
  max_pause = round_dec(max(pause.time, na.rm = TRUE)) 
  pause_count = int(length(pause.time)) 
  run_time=round_dec(max(timestamp, na.rm = TRUE) - min(timestamp, na.rm = TRUE))
  gc_thrpt=round_dec(total_pause*100.0/run_time)                 # Percentage of time spent in GC
  
  addRow(c("PauseTime [s]", total_pause))
  addRow(c("AvgPause [s]", avg_pause))
  addRow(c("MaxPause [s]", max_pause))
  addRow(c("#Gc-Pause", pause_count))
  addRow(c("Run Time[s]", run_time))
  addRow(c("GC-Throughput [%]", gc_thrpt))
  
  detach(data.gc)
  printStats()
}


computeStats <- function(data.gc) {
  statsMain(data.gc)
  statsByGCType(data.gc) 
}

