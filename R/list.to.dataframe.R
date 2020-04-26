#' @export
list.to.dataframe <- function(input.list, specific=NULL){
  if(is.null(specific)){
    x <- data.frame(input.list[[1]], stringsAsFactors=FALSE, check.names=FALSE)
    if(length(input.list)>=2){
      for(i in 2:length(input.list)){
        x <- merge(x, data.frame(input.list[[i]], stringsAsFactors=FALSE, check.names=FALSE), all = TRUE)
      }
    }
    
    x <- set.field.types(x)
    
    return(x)
  } else {
    x <- data.frame(input.list[[1]], stringsAsFactors=FALSE, check.names=FALSE)
    temp.rows <- nrow(x)
    for(i in 1:length(input.list)){
      record.code.vec <- as.vector(input.list[[i]]$"record.code")
      if( all(!is.na(match(record.code.vec, specific))) ){
        x <- merge(x, data.frame(input.list[[i]], stringsAsFactors=FALSE, check.names=FALSE), all = TRUE)
      }
    }
    
    x <- x[-(1:temp.rows),]
    
    x <- set.field.types(x)
    
    return(x)
  }
}
