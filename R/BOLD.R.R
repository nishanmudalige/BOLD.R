# BOLDR.R MASTER

########################################################################

library(jsonlite)
library(gtools)
library(RCurl)
library(ape)
library(plyr)
library(seqinr)

########################################################################


login.bold <- function(username){

  password.prompt <- paste("Please enter the password associated with the Bold Systems account for",username,sep=" ")
  password <- getPass::getPass(msg = password.prompt, forcemask = FALSE)
  
  # convert to UTF-8 URL Encoding for MOST special characters
  username <- URLencode(username, reserved=TRUE)
  password <- URLencode(password, reserved=TRUE)
  username <- gsub("\\.",	"%2E", username)  # b/c periods are not converted with URLencode
  password <- gsub("\\.",	"%2E", password)  # b/c periods are not converted with URLencode
  
  get.string <- paste("http://131.104.63.24:6544/dropin/acl_gettoken?username=",username,"&password=",password, sep="")
  
  token.string <- suppressWarnings( read.table(get.string) )
  
  if( as.character(token.string[,"V1"]) == "user, password not valid."){
    warning("Incorrect username or password")
  } else {
    isolate.token <- as.character(token.string[,"V2"])
    print("Login successful.")
    print(paste("Your current session will expire in 6 hours at", Sys.time() + 6*60*60,sep=" "))
    
    return( invisible(suppressWarnings(isolate.token) ) )
  }
  
}




########################################################################

extend.session <- function(token){
  
  extend <- suppressWarnings( read.table(paste("http://131.104.63.24:6544/dropin/securitytoken_extend?t=",token,sep="")) )
  
  if( as.character(extend[,"V1"]) == "true"){
    
    print("Token time extended")
    print(paste("Your current session will expire in 6 hours at", Sys.time() + 6*60*60,sep=" "))
    
  } else if( as.character(extend[,"V1"]) == "Invalid credential token"){
    
    return(warning("Invalid or expired token entered. Time not extended."))
    
  }
}




########################################################################

allowed.fields <- function(){
  
  allowed <- c( "associated_specimens","associated_taxa",
                "catalognum","class","collection_event_id","collectionnotes","collectiontime","collectors","country",
                "depth","depth_accuracy",
                "elev","elev_accuracy","extrainfo",
                "family","fieldnum",
                "genus",
                # "gps_accuracy_units",
                "gps_source",
                "habitat",
                "identification_method","identifier_fullname","inst_name",
                "lat","lifestage","long",
                "note",
                "order",
                "phylum","processid","province",
                "record.code","region","reproduction",
                "sampleid","sampling_protocol","sector",
                #"seqid",
                "sex","site","sitecode","species","specimenid","subfamily","subspecies",
                "taxnotes","tissuetype",
                "uri",
                "vouchertype",
                "taxon")
  
  return(allowed)
}




########################################################################

load.data <- function(record.codes, token){
  
  out <- NULL
  
  for(i in 1:length(record.codes)){
    
    if( !is.character(record.codes[i]) | !is.character(token) ){
      warning("Input not valid")
      break
    } else {
      
      current <- NULL
      
      get.package.id <- fromJSON(paste("http://131.104.63.24:6543/dropin/datastore_load_data?recordset_codes=",record.codes[i],"&t=",token, sep=""))
      current <- suppressWarnings(fromJSON(paste("http://131.104.63.24:6543/dropin/datastore_retrieve?package_id=",get.package.id$package_id,"&t=",token, sep="")))
      
      n <- length(current$processid)
      
      current <- append( list("record.code" = rep(record.codes[i], n)) , current)
      
      current <- data.frame(current, stringsAsFactors=FALSE, check.names=FALSE)
      
      out[[i]] <- current
      
    }
    
  }
  
  return(out)
  
}



########################################################################



analysis.metadata <- function(record.codes, token){
  
  out <- NULL
  
  for(i in 1:length(record.codes)){
    
    if( !is.character(record.codes[i]) | !is.character(token) ){
      warning("Input not valid")
      break
    } else {
      
      current <- NULL
      
      get.package.id <- fromJSON(paste("http://131.104.63.24:6543/dropin/datastore_load_metadata?recordset_codes=",record.codes[i],"&t=",token, sep=""))
      current <- suppressWarnings(fromJSON(paste("http://131.104.63.24:6543/dropin/datastore_retrieve?package_id=",get.package.id$package_id,"&t=",token, sep="")))
      
      n <- length(current$processid)
      
      current <- append( list("record.code" = rep(record.codes[i], n)) , current)
      
      current <- data.frame(current, stringsAsFactors=FALSE, check.names=FALSE)
      
      
      # current <- current[ ,names(current) %in% allowed]
      
      
      out[[i]] <- current
      
    }
  }
  
  return(out)
  
}




########################################################################

merge.load.and.meta <- function(x.load, x.meta){
  
  out.data <- merge(x.load, x.meta, all = TRUE)
  
  out.data <- data.frame(out.data, stringsAsFactors=FALSE, check.names=FALSE)
  
  colnames(out.data) <- gsub("\\.", "-", colnames(out.data))
  is.na(out.data) <- out.data==''
  
  return(out.data)
}




########################################################################

set.field.types <- function(x){
  
  x$associated_specimens <- as.character(x$associated_specimens)
  x$associated_taxa <- as.character(x$associated_taxa)
  x$catalognum <- as.character(x$catalognum)
  x$class <- as.character(x$class)
  x$collection_event_id <- as.character(x$collection_event_id)
  x$collectionnotes <- as.character(x$collectionnotes)
  x$collectiontime <- as.character(x$collectiontime)
  x$collectors <- as.character(x$collectors)
  x$country <- as.character(x$country)
  x$depth <- as.numeric(x$depth)
  x$depth_accuracy <- as.character(x$depth_accuracy)
  x$elev <- as.numeric(x$elev)
  x$elev_accuracy <- as.character(x$elev_accuracy)
  x$extrainfo <- as.character(x$extrainfo)
  x$family <- as.character(x$family)
  x$fieldnum <- as.character(x$fieldnum)
  x$genus <- as.character(x$genus)
  # x$gps_accuracy_units <- as.character(x$gps_accuracy_units)
  x$gps_source <- as.character(x$gps_source)
  x$habitat <- as.character(x$habitat)
  x$identification_method <- as.character(x$identification_method)
  x$identifier_fullname <- as.character(x$identifier_fullname)
  x$inst_name <- as.character(x$inst_name)
  x$lat <- as.numeric(x$lat)
  x$lifestage <- as.character(x$lifestage)
  x$long <- as.numeric(x$long)
  x$note <- as.character(x$note)
  x$order <- as.character(x$order)
  x$phylum <- as.character(x$phylum)
  x$processid <- as.character(x$processid)
  x$province <- as.character(x$province)
  x$record.code <- as.character(x$record.code)
  x$region <- as.character(x$region)
  x$reproduction <- as.character(x$reproduction)
  x$sampleid <- as.character(x$sampleid)
  x$sampling_protocol <- as.character(x$sampling_protocol)
  x$sector <- as.character(x$sector)
  # x$seqid <- as.numeric(x$seqid)
  x$sex <- as.character(x$sex)
  x$site <- as.character(x$site)
  x$sitecode <- as.character(x$sitecode)
  x$species <- as.character(x$species)
  x$specimenid <- as.numeric(x$specimenid)
  x$subfamily <- as.character(x$subfamily)
  x$subspecies <- as.character(x$subspecies)
  x$taxnotes <- as.character(x$taxnotes)
  x$taxon <- as.character(x$taxon)
  x$tissuetype <- as.character(x$tissuetype)
  x$uri <- as.character(x$uri)
  x$vouchertype <- as.character(x$vouchertype)
  
  return(x)
  
}


########################################################################

list.to.dataframe <- function(input.list, specific=NULL){
  if(is.null(specific)){
    x <- data.frame(input.list[[1]], stringsAsFactors=FALSE, check.names=FALSE)
    if(length(input.list)>=2){
      for(i in 2:length(input.list)){
        # x <- suppressWarnings( gtools::smartbind(x, data.frame(input.list[[i]], stringsAsFactors=FALSE) , fill=NA ) )
        x <- merge(x, data.frame(input.list[[i]], stringsAsFactors=FALSE, check.names=FALSE), all = TRUE)
      }
    }
    # colnames(x) <- gsub("\\.", "-", colnames(x))
    
    x <- set.field.types(x)
    
    
    return(x)
  } else {
    x <- data.frame(input.list[[1]], stringsAsFactors=FALSE, check.names=FALSE)
    temp.rows <- nrow(x)
    for(i in 1:length(input.list)){
      record.code.vec <- as.vector(input.list[[i]]$"record.code")
      if( all(!is.na(match(record.code.vec, specific))) ){
        # x <- suppressWarnings( gtools::smartbind( x, data.frame(input.list[[i]], stringsAsFactors=FALSE) , fill=NA ))
        x <- merge(x, data.frame(input.list[[i]], stringsAsFactors=FALSE, check.names=FALSE), all = TRUE)
      }
    }
    x <- x[-(1:temp.rows),]
    # if(!is.null(x)){
    #   colnames(x) <- gsub("\\.", "-", colnames(x))
    # }
    
    x <- set.field.types(x)
    
    return(x)
  }
}




########################################################################

all.data.list <- function(record.codes, token){
  
  out.list <- NULL
  good.list <- NULL
  bad.list <- NULL
  
  for(i in 1:length(record.codes)){
    
    x.load <- load.data(record.codes[i], token)
    x.meta <- analysis.metadata(record.codes[i], token)
    
    if( identical( data.frame(x.load)$record.code, character(0)) ){
      # bad.list[[i]] <- record.codes[i]
      warning(paste("The following was not recognized as valid record set codes:", record.codes[i]))
      next
    } else {
      
      current <- merge( data.frame(x.load, stringsAsFactors=FALSE, check.names=FALSE),
                        data.frame(x.meta, stringsAsFactors=FALSE, check.names=FALSE), all = TRUE)#, by="processid")
      
      current <- data.frame(current, stringsAsFactors=FALSE, check.names=FALSE)
      
      allowed <- allowed.fields()
      
      allowed <- c(allowed, names(current)[endsWith(names(current), "_nucraw")] )
      allowed <- c(allowed, names(current)[endsWith(names(current), "_gb_asc")] )
      
      # current <- current[ , names(current) %in% allowed]
      
      current[current == "" ] <- NA
      
      out.list[[i]] <- current
    }
  }
  
  
  
  good.list <- out.list[lapply(out.list,length)>0]
  good.list <- list.to.dataframe(good.list)
  
  return(good.list)
}




########################################################################

get.private <- function(record.codes, token){
  
  if(missing(token)){
    warning("Please provide a valid token")
    return(invisible())
  }
  
  out <- all.data.list(record.codes, token)
  
  if( nrow(out) >=1  ){
    
    # Add time stamp
    time.accessed <- rep(Sys.time(), nrow(out))
    out <- cbind(out, time.accessed)
    
    out$API.accessed <- "Private"
    
  } else {
    
    out <- NULL
    
  }
  
  return(out)
  
}




########################################################################

user.datasets <- function(username, token){
  if( !is.character(username) ){
    warning("Input not valid.")
    break
  } else {
    get.string <- paste("http://131.104.63.24:6544/dropin/user_datasets?user_code=",username,"&t=",token, sep="")
    out <- suppressWarnings( fromJSON(get.string) )
    
    return(out)
  }
}


########################################################################

user.public.datasets <- function(username, token){
  if( !is.character(username) ){
    warning("Input not valid.")
    break
  } else {
    get.string <- paste("http://131.104.63.24:6544/dropin/user_publicdatasets?user_code=",username,"&t=",token, sep="")
    out <- suppressWarnings( fromJSON(get.string) )
    
    return(out)
  }
}



########################################################################

nucleotides <- function(df){
  
  nucleotides.name <- names(df)[ which(endsWith(names(df), "_nucraw") ) ]
  
  if( identical(nucleotides.name, character(0) ) ){
    return("there are no nucleotides in this dataframe")
  } else{
    return(nucleotides.name) 
  }
}



########################################################################

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


########################################################################

check.name <- function(object){
  
  the.name <- deparse(substitute(object))
  if( !exists(the.name) ){
    warning( paste("Object '",the.name,"' not found",sep="") )
    return(FALSE)
  } else {
    return(TRUE)
  }
  
}



########################################################################

check.valid <-function(df){
  
  # check if data frame is entered
  if(class(df) != "data.frame"){
    warning('Object entered is not a data frame.')
    return(FALSE)
  }
  
  # check for process id
  if( is.null(df$processid) ){
    warning('Data frame entered does not have a valid process id.')
    return(FALSE)
  }
  
  # check for process id is not a character
  if( !is.character(df$processid) ){
    warning('Data frame entered does not have a valid process id.')
    return(FALSE)
  }
  
  # Check if record code is missing
  if( is.null(df$record.code)){
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  
  # Check if record code is not character
  if( !is.character(df$record.code)){
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  
  # Check if time accessed is missing
  if( is.null(df$time.accessed)){
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  
  # Check if time accessed is missing
  if( !all(class(df$time.accessed) == c("POSIXct", "POSIXt")) ){
    
    warning('Data frame entered does not contain data from BOLD.')
    return(FALSE)
  }
  else{
    return(TRUE)
  }
  
  
}




########################################################################

all.primers <- function(df){
  
  
  if( !check.valid(df) ){
    # check.valid(df)
    return(invisible())
  }
  
  nucraw.index <- which(grepl("_nucraw$", names(df)))
  aminoraw.index <- which(grepl("_aminoraw$", names(df)))
  nucaln.index <- which(grepl("_nucaln$", names(df)))
  aminoaln.index <- which(grepl("_aminoaln$", names(df)))
  return( sort( names(df)[ c(nucraw.index, aminoraw.index, nucaln.index, aminoaln.index)] ) )
  
}




########################################################################

label.maker <- function(x.df, label.headers=c(...) ){
  
  label.matrix <- x.df
  
  if( (table(label.headers %in% colnames(label.matrix)))["TRUE"] != length(label.headers) ){
    warning("One or more column headers is incorrect.")
    return(invisible())
  }
  
  label.matrix <- label.matrix[,label.headers]
  label.matrix <- as.matrix(label.matrix, ncol=length(label.headers))
  
  out <- NULL
  
  if(ncol(label.matrix) > 1){
    for(i in 1:ncol(label.matrix)){
      current <- label.matrix[, which(colnames(label.matrix) == label.headers[i]) ]
      current[is.na(current)] <- ""
      out <- paste(out, current, sep="|")
    }
    out <- sub('.', '', out)
  } else{
    out <- label.matrix
  }
  
  return(out)
}




########################################################################

gen.DNAbin <- function(x.df=NULL, alignment=NULL, labels.headers=c(...)){
  
  if(is.null(x.df)){
    warning("Please enter a dataframe")
    return(invisible())
  }
  
  if( !( endsWith(alignment, "_nucraw") | endsWith(alignment, "_nucaln") ) ){
    # warning("Alignment choice must end with suffix '_aminoraw', '_aminoaln', '_nucraw' or '_nucraln'")
    warning("Alignment choice must end with suffix '_nucraw' or '_nucaln'")
    return(invisible())
  }
  
  
  labels <- label.maker(x.df, labels.headers)
  
  label.maker.warn.test <- tryCatch(label.maker(x.df, labels.headers), error=function(e) e, warning=function(w) w)
  if(is(label.maker.warn.test,"warning")){
    return(invisible())
  }
  
  
  x.matrix <- x.df
  
  if( !(alignment %in% names(x.matrix)) ){
    warning("Speficied alignment not found.")
    return(invisible())
  }
  
  x.matrix <- x.matrix[, which(colnames(x.matrix) == alignment) ]
  x.matrix <- cbind(labels, x.matrix)
  x.matrix <- as.matrix(x.matrix, ncol=2 )
  
  if( all(x.matrix[,2] == "") == TRUE ){
    warning("There are no sequences of specified type.")
    return(invisible())
  }
  
  # remove rows without a sequence
  empty.counter <- length(which(x.matrix[,2] == ""))
  x.matrix <- x.matrix[which(x.matrix[,2] != ""), ]
  y <- NULL
  
  for(i in 1: nrow(x.matrix) ){
    y[[i]] <- strsplit( tolower(x.matrix[i,2]) ,"")
  }
  
  z <- t(y[[1]]$x.matrix)
  
  for(i in 2: nrow(x.matrix) ){
    z <- rbind.fill.matrix(z, t(y[[i]]$x.matrix) )
  }
  
  rownames(z) <- x.matrix[,1]
  
  print( paste("there were",empty.counter,"rows without any sequences.") )
  return(as.DNAbin(z))
  
}


########################################################################


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
  get <- paste("http://v4.boldsystems.org/index.php/API_Public/combined?",
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



########################################################################

dictionary <- function(){
  
  dictionary <- rbind(
    c("class",	"class_name"),
    c("collectionnotes",	"collection_note"),
    c("family",	"family_name"),
    c("genus",	"genus_name"),
    c("gps_accuracy_units",	"coord_accuracy"),
    c("gps_source",	"coord_source"),
    c("identifier_fullname",	"identification_provided_by"),
    c("inst_name",	"institution_storing"),
    c("long",	"lon"),
    c("note",	"notes"),
    c("order",	"order_name"),
    c("phylum",	"phylum_name"),
    c("province",	"province_state"),
    c("seqid",	"sequenceID"),
    c("site",	"exactsite"),
    c("sitecode",	"site_code"),
    c("species",	"species_name"),
    c("specimenid",	"recordID"),
    c("subfamily",	"subfamily_name"),
    c("subspecies",	"subspecies_name"),
    c("taxnotes",	"tax_note"),
    c("tissuetype",	"tissue_type"),
    c("uri",	"bin_uri"),
    c("vouchertype",	"voucher_status") )
  
  
  colnames(dictionary) <- c("name", "synonym")
  
  dictionary <- dictionary[rep(1:nrow(dictionary), 1, each=2),]
  
  for(i in 1:nrow(dictionary)){
    if(i %% 2 == 0){
      dictionary[i, "synonym"] <- dictionary[i, "name"]
    }
  }
  
  # Make future additions below this line
  
  dictionary <- data.frame(dictionary, stringsAsFactors = FALSE)
  
  return(dictionary)
  
}





########################################################################

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


########################################################################


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



########################################################################

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



########################################################################


public.remove <- function(df.from.BOLD.public){
  
  remove.columns <- c("markercode", "nucleotides", "genbank_accession")
  # "collectiondate_end", "collectiondate_start"    )
  
  df.from.BOLD.public <- df.from.BOLD.public[, -which(names(df.from.BOLD.public) %in% remove.columns)]
  
  return(df.from.BOLD.public)
  
}


########################################################################


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

########################################################################

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






########################################################################


merge.bold <- function(df.x, df.y){
  
  # check if data frame is entered
  if(class(df.x) != "data.frame" | class(df.y) != "data.frame"){
    warning('one or more objects entered is not a data frame.')
    return(invisible())
  }
  
  # check for process id
  if( is.null(df.x$processid) | is.null(df.y$processid) ){
    warning('one or more data frames entered does not have a valid process id.')
    return(invisible())
  }
  
  # check for process id is not a character
  if( !is.character(df.x$processid) | !is.character(df.y$processid) ){
    warning('one or more data frames entered does not have a valid process id')
    return(invisible())
  }
  
  # Check if record code is missing
  if( is.null(df.x$record.code) | is.null(df.y$record.code) ){
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  # Check if record code is not character
  if( !is.character(df.x$record.code) | !is.character(df.y$record.code) ){
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  # Check if time accessed is missing
  if( is.null(df.x$time.accessed) | is.null(df.y$time.accessed) ){
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  # Check if time accessed is missing
  if( !all(class(df.x$time.accessed) == c("POSIXct", "POSIXt")) | !all(class(df.y$time.accessed) == c("POSIXct", "POSIXt")) ){
    
    warning('one or more data frames entered does not contain data from BOLD.')
    return(invisible())
  }
  
  df.x <- internally.collapse(df.x)
  df.y <- internally.collapse(df.y)
  
  out <- rbind.fill(df.x, df.y)
  
  out <- internally.collapse(out)
  
  out <- out[order(out$processid), ]
  
  return(out)
  
}

########################################################################

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