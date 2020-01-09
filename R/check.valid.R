check.valid <-function(df){
  
  # check if data frame is entered
  if(class(df) != "data.frame"){
    warning('Object entered is not a data frame.')
    return(FALSE)
  }
  
  # check for process id
  if( is.null(df$processid) ){
    warning('Data frame entered does not have a valid process id.')
    return(FALSE)
  }
  
  # check for process id is not a character
  if( !is.character(df$processid) ){
    warning('Data frame entered does not have a valid process id.')
    return(FALSE)
  }
  
  # Check if record code is missing
  if( is.null(df$record.code)){
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  
  # Check if record code is not character
  if( !is.character(df$record.code)){
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  
  # Check if time accessed is missing
  if( is.null(df$time.accessed)){
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  
  # Check if time accessed is missing
  if( !all(class(df$time.accessed) == c("POSIXct", "POSIXt")) ){
    
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  else{
    return(TRUE)
  }
  
  
}
