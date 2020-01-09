merge.load.and.meta <- function(x.load, x.meta){
  
  out.data <- merge(x.load, x.meta, all = TRUE)
  
  out.data <- data.frame(out.data, stringsAsFactors=FALSE, check.names=FALSE)
  
  colnames(out.data) <- gsub("\\.", "-", colnames(out.data))
  is.na(out.data) <- out.data==''
  
  return(out.data)
}
