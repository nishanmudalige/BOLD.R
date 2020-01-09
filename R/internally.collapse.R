internally.collapse <- function(df){
  
  df <- df[order(df$processid), ]
  
  repeated.table <- data.frame(table(df$processid), stringsAsFactors = FALSE)
  
  if( nrow(df) == nrow(repeated.table) ){
    return(df)
  }
  
  colnames(repeated.table) <- c("processid", "freq")
  
  repeated.table <- repeated.table[which(repeated.table$freq > 1), ]
  
  for(i in 1:nrow(repeated.table)){
    
    current <- repeated.table[i, ]
    
    repeated.indices.all <- which(df$processid %in% current$processid)
    repeated.indices <- repeated.indices.all
    
    API <- df[repeated.indices, "API.accessed"]
    
    if( any(API == "Private") ){
      indices.API.table <- data.frame(repeated.indices, API, stringsAsFactors = FALSE)
      colnames(indices.API.table) <- c("index", "API")
      repeated.indices <- indices.API.table[which(indices.API.table$API == "Private"), "index"]
    }
    
    newest.time <-  max(df[repeated.indices, "time.accessed"])
    
    newest.index <- which(df[repeated.indices,"time.accessed"] == newest.time)
    newest.index <- repeated.indices[newest.index]
    
    # remove oldest
    repeated.indices.all <- repeated.indices.all[which(repeated.indices.all != newest.index)]
    
    df <- df[-repeated.indices.all, ]
    
  }
  
  return(df)
  
}
