#' @export
public.change.name.sequence <- function(df.from.BOLD.public){
  
  entered.df <- df.from.BOLD.public
  
  unique.seq <- unique(entered.df$markercode)
  unique.seq <- unique.seq[unique.seq != ""]
  
  # Create a new empty dataframe with sequence information
  seq.df <- data.frame(matrix(NA, nrow=nrow(entered.df), ncol=length(unique.seq) ), stringsAsFactors = FALSE)
  names(seq.df) <- unique.seq
  
  # Insert values into dataframe
  for(i in 1:length(unique.seq)){
    current.seq.indices <- which(entered.df[,"markercode"] == unique.seq[i])
    # for(j in 1:nrow(entered.df)){
    seq.df[current.seq.indices, i] <- entered.df[current.seq.indices,"nucleotides"]
    # }
  }
  
  # Attach dataframe with sequence data
  names(seq.df) <- paste(unique.seq, "_nucraw", sep="")
  
  entered.df <- cbind(entered.df, seq.df)
  
  return(entered.df)
  
}
