#' @export
fasta.out <- function(x.df, marker.name, output.name = "output",
                      remove.empty = FALSE, nbchar = 60){
  
  # Remove blank records
  if(remove.empty == TRUE){
    x.df <- x.df[!is.na(x.df[,marker.name]), ]
  }
  
  extract.data <- cbind(x.df$processid, x.df[, which(names(x.df) == marker.name)] )
  
  extract.data.list <- lapply(strsplit(extract.data[,2],""), tolower)
  
  names(extract.data.list) <- x.df$processid
  
  write.fasta(sequences = extract.data.list, names = names(extract.data.list), 
              nbchar = nbchar, file.out = paste(output.name, ".fasta", sep=""))
  
}