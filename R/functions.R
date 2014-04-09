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
  df<-NULL
  attach(data.gc)
  
  total_pause = round_dec(sum(pause.time, na.rm = TRUE))            # Time spent in GC
  avg_pause = round_dec(mean(pause.time, na.rm = TRUE)) 
  max_pause = round_dec(max(pause.time, na.rm = TRUE)) 
  pause_count = int(length(pause.time)) 
  run_time=round_dec(max(timestamp, na.rm = TRUE) - min(timestamp, na.rm = TRUE))
  gc_thrpt=round_dec(total_pause*100.0/run_time)                 # Percentage of time spent in GC
  avg_promo = round_dec(mean(promoRate, na.rm = TRUE)) 
  #avg_allocRate = round_dec(mean(allocationRate, na.rm = TRUE)) 
  avg_allocRate = NA
  
  df <-addRow(df,c("PauseTime [s]", total_pause))
  df <-addRow(df,c("AvgPause [s]", avg_pause))
  df <-addRow(df,c("MaxPause [s]", max_pause))
  df <-addRow(df,c("#Gc-Pause", pause_count))
  df <-addRow(df,c("Run Time[s]", run_time))
  df <-addRow(df,c("GC-Throughput [%]", gc_thrpt))
  
  full_count= int(length(gc.type[ grep("full",gc.type)]))
  if (full_count > 0 ) {
    #print("full GCs!")
    df <-addRow(df,c("Full GCs", full_count))
    
    liveDataSize <- mean(old.occ.end[ grep("full",gc.type)]) 
    dd <- old.occ.end[grep("full",gc.type)]
    time <- timestamp[grep("full",gc.type)]
    df <-addRow(df,c("Avg. Live Data Size [MB]", liveDataSize))
  }
  
  df <-addRow(df,c("Avg Promotion Rate [MB/s]", avg_promo))
  df <-addRow(df,c("Avg Allocation Rate [MB/s]", avg_allocRate))
  
  detach(data.gc)
  colnames(df) <- c("Stat", "Value")
  return(df)
}


computeStats <- function(data.gc) {
  statsMain(data.gc)
  #statsByGCType(data.gc) 
}

allocationRate <- function(data.gc) {
  rate <- c()
  
  time <- data.gc$timestamp
  j <- 1
  k <- 1
  rate[1] <- 0
  prev_occ_end <- 0
  prev_timestamp <- 0
  attach(data.gc)
  for (i in time) {
    
    
    if (grepl("full", gc.type[k]) || is.na(young.occ.start[k])) {
      rate[k] <- NA
    } else {
      rate[k] <- round_dec(((young.occ.start[k] - prev_occ_end) / (timestamp[k] - prev_timestamp)))
      prev_timestamp <- timestamp[k]
      prev_occ_end <- young.occ.end[k] 
    }     
    k <- k + 1
  }
  detach(data.gc)
  rate[1] <- NA
  
  data.gc[, "allocationRate"] <- rate
  #head(data.gc,10)
  
  rateframe <- data.gc
  return(rateframe)
}



