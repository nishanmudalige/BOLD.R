#' @export
all.data.list = function(record.codes, token){
  
  out.list = NULL
  good.list = NULL
  bad.list = NULL
  
  for(i in 1:length(record.codes)){
    
    x.load = load.data(record.codes[i], token)
    x.meta = analysis.metadata(record.codes[i], token)
    
    if( identical( data.frame(x.load)$record.code, character(0)) ){
      # bad.list[[i]] = record.codes[i]
      warning(paste("The following was not recognized as valid record set codes:", record.codes[i]))
      next
    } else {
      
      current = merge( data.frame(x.load, stringsAsFactors=FALSE, check.names=FALSE),
                        data.frame(x.meta, stringsAsFactors=FALSE, check.names=FALSE), all = TRUE)#, by="processid")
      
      current = data.frame(current, stringsAsFactors=FALSE, check.names=FALSE)
      
      allowed = allowed.fields()
      
      allowed = c(allowed, names(current)[endsWith(names(current), "_nucraw")] )
      allowed = c(allowed, names(current)[endsWith(names(current), "_gb_asc")] )
      
      # current = current[ , names(current) %in% allowed]
      
      current[current == "" ] = NA
      
      out.list[[i]] = current
    }
  }
  
  
  
  good.list = out.list[lapply(out.list,length)>0]
  good.list = list.to.dataframe(good.list)
  
  return(good.list)
}




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