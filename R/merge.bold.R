merge.bold <- function(df.x, df.y){
  
  # check if data frame is entered
  if(class(df.x) != "data.frame" | class(df.y) != "data.frame"){
    warning('one or more objects entered is not a data frame.')
    return(invisible())
  }
  
  # check for process id
  if( is.null(df.x$processid) | is.null(df.y$processid) ){
    warning('one or more data frames entered does not have a valid process id.')
    return(invisible())
  }
  
  # check for process id is not a character
  if( !is.character(df.x$processid) | !is.character(df.y$processid) ){
    warning('one or more data frames entered does not have a valid process id')
    return(invisible())
  }
  
  # Check if record code is missing
  if( is.null(df.x$record.code) | is.null(df.y$record.code) ){
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  # Check if record code is not character
  if( !is.character(df.x$record.code) | !is.character(df.y$record.code) ){
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  # Check if time accessed is missing
  if( is.null(df.x$time.accessed) | is.null(df.y$time.accessed) ){
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  # Check if time accessed is missing
  if( !all(class(df.x$time.accessed) == c("POSIXct", "POSIXt")) | !all(class(df.y$time.accessed) == c("POSIXct", "POSIXt")) ){
    
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  df.x <- internally.collapse(df.x)
  df.y <- internally.collapse(df.y)
  
  out <- rbind.fill(df.x, df.y)
  
  out <- internally.collapse(out)
  
  out <- out[order(out$processid), ]
  
  return(out)
  
}
