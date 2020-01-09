label.maker <- function(x.df, label.headers=c(...) ){
  
  label.matrix <- x.df
  
  if( (table(label.headers %in% colnames(label.matrix)))["TRUE"] != length(label.headers) ){
    warning("One or more column headers is incorrect.")
    return(invisible())
  }
  
  label.matrix <- label.matrix[,label.headers]
  label.matrix <- as.matrix(label.matrix, ncol=length(label.headers))
  
  out <- NULL
  
  if(ncol(label.matrix) > 1){
    for(i in 1:ncol(label.matrix)){
      current <- label.matrix[, which(colnames(label.matrix) == label.headers[i]) ]
      current[is.na(current)] <- ""
      out <- paste(out, current, sep="|")
    }
    out <- sub('.', '', out)
  } else{
    out <- label.matrix
  }
  
  return(out)
}
