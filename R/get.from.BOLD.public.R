#' @export
get.from.BOLD.public <- function(taxon=NULL, ids=NULL, bin=NULL, container=NULL,
                                 institutions=NULL, researchers=NULL, geo=NULL, marker=NULL){
  
  if(!is.null(taxon)){
    taxon <- gsub(",","|",taxon)
    taxon <- paste(taxon, collapse = '|')
    taxon <- URLencode(taxon)
  }
  if(!is.null(ids)){
    ids <- gsub(",","|",ids)
    ids <- paste(ids, collapse = '|')
    ids <- URLencode(ids)
  }
  if(!is.null(bin)){
    bin <- gsub(",","|",bin)
    bin <- paste(bin, collapse = '|')
    bin <- URLencode(bin)
  }
  if(!is.null(container)){
    container <- gsub(",","|",container)
    container <- paste(container, collapse = '|')
    container <- URLencode(container)
  }
  if(!is.null(institutions)){
    institutions <- gsub(",","|",institutions)
    institutions <- paste(institutions, collapse = '|')
    institutions <- URLencode(institutions)
  }
  if(!is.null(researchers)){
    researchers <- gsub(",","|",researchers)
    researchers <- paste(researchers, collapse = '|')
    researchers <- URLencode(researchers)
  }
  if(!is.null(geo)){
    geo <- gsub(",","|",geo)
    geo <- paste(geo, collapse = '|')
    geo <- URLencode(geo)
  }
  if(!is.null(marker)){
    marker <- gsub(",","|",marker)
    marker <- paste(marker, collapse = '|')
    marker <- URLencode(marker)
  }
  
  # specimen, sequence, combined
  get <- paste("https://www.boldsystems.org/index.php/API_Public/combined?",
               "taxon=",taxon,
               "&bin=",bin,
               "&container=",container,
               "&institutions=",institutions,
               "&researchers=",researchers,
               "&geo=",geo,
               "&marker=",marker,
               "&format=tsv", sep="")
  
  # Test whether parameters return an empty file
  test.empty <- try(read.delim(get, sep='\t', header=TRUE, nrows=1))
  test.empty <- as.character(test.empty)
  test.empty <- strsplit(test.empty, " ")
  if( (test.empty[[1]])[1] == "Error" ){
    warning("Public data does not exist for all specified value(s) of parameter(s). Please check your input.")
    # return(invisible())
    return(NULL)
  }
  
  df <- read.delim(get, sep='\t', header=TRUE)
  df <- data.frame(lapply(df, as.character), stringsAsFactors=FALSE)
  
  return(df)
}
