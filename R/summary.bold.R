summary.bold <- function(df){
  
  nuc <- length(nucleotides(df))
  rowlength <- nrow(df)
  rec.code <- length(unique(df$record.code))
  duplicates <- length(which(duplicated(df) == "TRUE"))
  
  data <- c(rowlength, rec.code, duplicates, nuc)
  
  output <- as.table( matrix(data, ncol=1) )
  rownames(output) <- c("No. of records", 
                        "No. of unique record codes", 
                        "No. of duplicate records",
                        "No. of different primers")
  colnames(output) <- ""
  
  return(output)
  
}
