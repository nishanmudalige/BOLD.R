#' @export
load.data <- function(record.codes, token){
  
  out <- NULL
  
  for(i in 1:length(record.codes)){
    
    if( !is.character(record.codes[i]) | !is.character(token) ){
      warning("Input not valid")
      break
    } else {
      
      current <- NULL
      
      get.package.id <- fromJSON(paste("http://131.104.63.24:6543/dropin/datastore_load_data?recordset_codes=",record.codes[i],"&t=",token, sep=""))
      current <- suppressWarnings(fromJSON(paste("http://131.104.63.24:6543/dropin/datastore_retrieve?package_id=",get.package.id$package_id,"&t=",token, sep="")))
      
      n <- length(current$processid)
      
      current <- append( list("record.code" = rep(record.codes[i], n)) , current)
      
      current <- data.frame(current, stringsAsFactors=FALSE, check.names=FALSE)
      
      out[[i]] <- current
      
    }
    
  }
  
  return(out)
  
}