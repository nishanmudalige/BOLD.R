public.add.taxon <- function(df.from.BOLD.public){
  
  taxon.df <- df.from.BOLD.public[,c("phylum","class","order","family","genus","species")]
  taxon.df[taxon.df == ""] <- NA
  
  taxon <- NULL
  
  for(i in 1:nrow(taxon.df)){
    tax.col <- max( which( !is.na(taxon.df[i,]) ) )
    taxon[i] <- taxon.df[i,tax.col]
  }
  
  df.from.BOLD.public$taxon <- taxon
  
  return(df.from.BOLD.public)
  
}
