public.remove <- function(df.from.BOLD.public){
  
  remove.columns <- c("markercode", "nucleotides", "genbank_accession")
  # "collectiondate_end", "collectiondate_start"    )
  
  df.from.BOLD.public <- df.from.BOLD.public[, -which(names(df.from.BOLD.public) %in% remove.columns)]
  
  return(df.from.BOLD.public)
  
}