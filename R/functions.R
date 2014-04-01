if(!exists(headers, mode="function")) source("constants.R")




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
