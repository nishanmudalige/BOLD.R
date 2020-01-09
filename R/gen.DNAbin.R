gen.DNAbin <- function(x.df=NULL, alignment=NULL, labels.headers=c(...)){
  
  if(is.null(x.df)){
    warning("Please enter a dataframe")
    return(invisible())
  }
  
  if( !( endsWith(alignment, "_nucraw") | endsWith(alignment, "_nucaln") ) ){
    # warning("Alignment choice must end with suffix '_aminoraw', '_aminoaln', '_nucraw' or '_nucraln'")
    warning("Alignment choice must end with suffix '_nucraw' or '_nucaln'")
    return(invisible())
  }
  
  
  labels <- label.maker(x.df, labels.headers)
  
  label.maker.warn.test <- tryCatch(label.maker(x.df, labels.headers), error=function(e) e, warning=function(w) w)
  if(is(label.maker.warn.test,"warning")){
    return(invisible())
  }
  
  
  x.matrix <- x.df
  
  if( !(alignment %in% names(x.matrix)) ){
    warning("Speficied alignment not found.")
    return(invisible())
  }
  
  x.matrix <- x.matrix[, which(colnames(x.matrix) == alignment) ]
  x.matrix <- cbind(labels, x.matrix)
  x.matrix <- as.matrix(x.matrix, ncol=2 )
  
  if( all(x.matrix[,2] == "") == TRUE ){
    warning("There are no sequences of specified type.")
    return(invisible())
  }
  
  # remove rows without a sequence
  empty.counter <- length(which(x.matrix[,2] == ""))
  x.matrix <- x.matrix[which(x.matrix[,2] != ""), ]
  y <- NULL
  
  for(i in 1: nrow(x.matrix) ){
    y[[i]] <- strsplit( tolower(x.matrix[i,2]) ,"")
  }
  
  z <- t(y[[1]]$x.matrix)
  
  for(i in 2: nrow(x.matrix) ){
    z <- rbind.fill.matrix(z, t(y[[i]]$x.matrix) )
  }
  
  rownames(z) <- x.matrix[,1]
  
  print( paste("there were",empty.counter,"rows without any sequences.") )
  return(as.DNAbin(z))
  
}
