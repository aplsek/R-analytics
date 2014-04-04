source("R/constants.R")

## ---- Q1 ----

hello<- function(h) {
  print(h)
}


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


test <- function() {
  N <- 100  # some magic number, possibly an overestimate
  
  DF <- data.frame(num=rep(NA, N), txt=rep("", N),  # as many cols as you need
                   stringsAsFactors=FALSE)          # you don't know levels yet
  
  DF[1,]  <- c("Pause", 120)
  DF[2,]  <- c("MaxPause", 120)
  
  DF
}


initSummary <- function() {
  df<<-NULL;
}

addRow <- function(row) {
  rbind(df, row)->df
  #rbind(df, c("sssPause", 120))->df
}

addRow <- function(df,row) {
  rbind(df, row)->df
  #rbind(df, c("sssPause", 120))->df
  return(df)
}