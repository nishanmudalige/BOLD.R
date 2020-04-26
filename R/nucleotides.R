#' @export
nucleotides <- function(df){
  
  nucleotides.name <- names(df)[ which(endsWith(names(df), "_nucraw") ) ]
  
  if( identical(nucleotides.name, character(0) ) ){
    return("there are no nucleotides in this dataframe")
  } else{
    return(nucleotides.name) 
  }
}
