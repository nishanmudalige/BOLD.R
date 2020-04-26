#' @export
get.public <- function(taxon=NULL, ids=NULL, bin=NULL, container=NULL,
                       institutions=NULL, researchers=NULL, geo=NULL, marker=NULL){
  
  # Get public data from BOLD with the API
  
  public.data <- NULL
  
  if( !is.null(container) ){
    project.codes <- unlist(strsplit(container, "\\|"))
    
    for(i in 1:length(project.codes)) {
      current <- get.from.BOLD.public(taxon=taxon, ids=ids, bin=bin,
                                      container=project.codes[i],
                                      institutions=institutions, 
                                      researchers=researchers, geo=geo, marker=marker)
      
      if( is.null(current) & length(project.codes) == 1 ){
        return(invisible())
      }
      
      if( is.null(current) ){
        next
      }
      
      current$record.code <- project.codes[i]
      
      current$record.code <- as.character(current$record.code)
      
      if(i == 1){
        public.data <- current
      } else {
        public.data <- rbind.fill(public.data, current)
      }
      
    }
    
  } else {
    
    # write other stuff here
    public.data <- get.from.BOLD.public(taxon=taxon, ids=ids, bin=bin,
                                        container=container,
                                        institutions=institutions, researchers=researchers, geo=geo, marker=marker)
    
    if(is.null(public.data)){
      return(invisible())
    }
    
    public.data$record.code <- "Public"
    
  }
  
  public.data$API.accessed <- "Public"
  
  public.data <- public.change.name.sequence(public.data)
  
  public.data <- public.change.name.genbank(public.data)
  
  # internally merge rows and remove duplicates
  public.data <- suppressWarnings(
    aggregate(x=public.data, by=list(name=public.data$processid), min, na.rm = TRUE) )
  
  
  # change names
  dictionary <- dictionary()
  
  for(i in 1:length(names(public.data)) ){
    current <- names(public.data)[i]
    if( current %in% dictionary[,"synonym"] ){
      dictionary.index <- which(current == dictionary[,"synonym"])
      names(public.data)[i] <- dictionary[dictionary.index, "name"]
    }
  }
  
  
  # add taxon
  public.data <- public.add.taxon(public.data)
  
  # set blanks to NA
  public.data[public.data == ""] <- NA
  
  # change specific columns to integers
  
  # add timestamp
  time.accessed <- rep(Sys.time(), nrow(public.data))
  public.data <- cbind(public.data, time.accessed)
  
  
  return(public.data)
  
}
