#if(!exists(headers, mode="function")) source("R/constants.R")
source("R/constants.R")



add <- function(value,name ) {
  headers <<- c(headers,name)
  stats <<- c(stats,value)
  
  headers
}


round_dec <- function(x) {
  res = round(as.numeric(x),ROUND)
  return(res)
}

int <- function(x) {
  res = as.integer(x)
  return(res)
}



###########################################

print_summary <- function(data.gc) {
  
  stats = rep(NA, 3)
  headers = c("PauseTime", "AvgPause", "MaxPause", "#Gc-Pause",
              "RunTime", "GC-Throughput", "GC Full" )
  
  attach(data.gc)
  #by(pause.time,gc.type,mean)
  #by(pause.time,gc.type,sd)    
  by(pause.time,gc.type,length)  # number of each GC events
  
  #summary(diff(timestamp))
  
  total_pause = sum(pause.time, na.rm = TRUE)            # Time spent in GC
  avg_pause = mean(pause.time, na.rm = TRUE) 
  max_pause = max(pause.time, na.rm = TRUE) 
  pause_count = int(length(pause.time)) 
  run_time=max(timestamp, na.rm = TRUE) - min(timestamp, na.rm = TRUE)
  gc_thrpt=total_pause*100.0/run_time                 # Percentage of time spent in GC
  
  gc.full <- pause.time[gc.type == "full"]
  gc.full.cnt = length(gc.full)
  
  stats = c (total_pause, avg_pause, max_pause, pause_count, run_time, gc_thrpt, gc.full.cnt)
  stats = round_dec(stats)
  #stats[1] = total_pause
  #stats[2] = run_time
  #stats[3] = gc_thrpt
  
  output = data.frame(stats, row.names=headers)
  print(output)
  detach(data.gc)
  
  
}
