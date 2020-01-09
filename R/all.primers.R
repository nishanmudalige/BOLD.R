all.primers <- function(df){
  
  
  if( !check.valid(df) ){
    # check.valid(df)
    return(invisible())
  }
  
  nucraw.index <- which(grepl("_nucraw$", names(df)))
  aminoraw.index <- which(grepl("_aminoraw$", names(df)))
  nucaln.index <- which(grepl("_nucaln$", names(df)))
  aminoaln.index <- which(grepl("_aminoaln$", names(df)))
  return( sort( names(df)[ c(nucraw.index, aminoraw.index, nucaln.index, aminoaln.index)] ) )
  
}
