#' @export
public.change.name.genbank <- function(df.from.BOLD.public){
  
  entered.df <- df.from.BOLD.public
  
  unique.seq <- unique(entered.df$markercode)
  unique.seq <- unique.seq[unique.seq != ""]
  
  # Create a new empty dataframe with sequence information
  genbank.df <- data.frame(matrix(NA, nrow=nrow(entered.df), ncol=length(unique.seq) ), stringsAsFactors = FALSE)
  names(genbank.df) <- unique.seq
  
  # Insert values into dataframe
  for(i in 1:length(unique.seq)){
    current.seq.indices <- which(entered.df[,"markercode"] == unique.seq[i])
    genbank.df[current.seq.indices, i] <- entered.df[current.seq.indices, "genbank_accession"]
  }
  
  # Attach dataframe with sequence data
  names(genbank.df) <- paste(unique.seq, "_gb_asc", sep="")
  
  entered.df <- cbind(entered.df, genbank.df)
  
  return(entered.df)
  
}
