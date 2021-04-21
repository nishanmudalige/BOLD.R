#' @export
analysis.metadata <- function(record.codes, token){
  
  out <- NULL
  
  for(i in 1:length(record.codes)){
    
    if( !is.character(record.codes[i]) | !is.character(token) ){
      warning("Input not valid")
      break
    } else {
      
      current <- NULL
      
      # get.package.id <- fromJSON(paste(" https://api.boldsystems.org:6543/dropin/datastore_load_metadata?recordset_codes=",record.codes[i],"&t=",token, sep=""))
      # current <- suppressWarnings(fromJSON(paste(" https://api.boldsystems.org:6543/dropin/datastore_retrieve?package_id=",get.package.id$package_id,"&t=",token, sep="")))
      
	  get.package.id <- fromJSON(paste(" https://api.boldsystems.org/dropin/datastore_load_metadata?recordset_codes=",record.codes[i],"&t=",token, sep=""))
      current <- suppressWarnings(fromJSON(paste(" https://api.boldsystems.org/dropin/datastore_retrieve?package_id=",get.package.id$package_id,"&t=",token, sep="")))

      
      n <- length(current$processid)
      
      current <- append( list("record.code" = rep(record.codes[i], n)) , current)
      
      current <- data.frame(current, stringsAsFactors=FALSE, check.names=FALSE)
      
      
      # current <- current[ ,names(current) %in% allowed]
      
      
      out[[i]] <- current
      
    }
  }
  
  return(out)
  
}