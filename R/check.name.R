check.name <- function(object){
  
  the.name <- deparse(substitute(object))
  if( !exists(the.name) ){
    warning( paste("Object '",the.name,"' not found",sep="") )
    return(FALSE)
  } else {
    return(TRUE)
  }
  
}