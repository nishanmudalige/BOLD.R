#' @export
get.private <- function(record.codes, token){
  
  if(missing(token)){
    warning("Please provide a valid token")
    return(invisible())
  }
  
  out <- all.data.list(record.codes, token)
  
  if( nrow(out) >=1  ){
    
    # Add time stamp
    time.accessed <- rep(Sys.time(), nrow(out))
    out <- cbind(out, time.accessed)
    
    out$API.accessed <- "Private"
    
  } else {
    
    out <- NULL
    
  }
  
  return(out)
  
}