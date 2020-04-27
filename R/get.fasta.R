# suppressMessages(library(Biostrings) )
library(seqinr)

get.fasta <- function(taxon=NULL, ids=NULL, bin=NULL, container=NULL,
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
  
  # pass version info
  version.info <- BOLDR.version.info()
  
  # specimen, sequence, combined
  get <- paste("http://www.boldsystems.org/index.php/API_Public/sequence?",
               "&taxon=",taxon,
               "&bin=",bin,
               "&container=",container,
               "&institutions=",institutions,
               "&researchers=",researchers,
               "&geo=",geo,
               "&marker=",marker,
               "&format=tsv",version.info, sep="")
  
  # Test whether parameters return an empty file
  test.empty <- try(read.delim(get, sep='\t', header=TRUE, nrows=1))
  test.empty <- as.character(test.empty)
  test.empty <- strsplit(test.empty, " ")
  if( (test.empty[[1]])[1] == "Error" ){
    warning("Public data does not exist for all specified value(s) of parameter(s). Please check your input.")
    # return(invisible())
    return(NULL)
  }
  
  # df <- read.fasta(get)
  
  # fastaFile <- readDNAStringSet(get, format = "FASTA" )
  # name = names(fastaFile)
  # sequence = paste(fastaFile)
  # df <- data.frame(name, sequence, stringsAsFactors = FALSE)
  fastafile <- read.fasta(get)
  
  length.fasta <- as.data.frame(lengths(fastafile))
  length.fasta <- length.fasta[1,1]
  
  # df <- NULL
  
  for(i in 1:length.fasta){
    
    temp.string <- do.call(paste, c(as.list(fastafile[i]), sep = ""))
    temp.string <- toupper(paste(temp.string, collapse=""))

    temp.name <- attr(fastafile[i], "name")
    
    temp.row <- cbind(temp.name, temp.string)
    
    if(i == 1){
      df <- temp.row
    } else {
      df <- rbind(df, temp.row)
    }
    
  }
  
  df <- data.frame(df, stringsAsFactors = FALSE)
  
  colnames(df) <- c("name", "sequence")
  
  return(df)
}


# temp33 <- get.fasta(container = "SSBAA")
# 
# temp33$sequence
# 
# 
# temp33[,"sequence"]
# 
# get.string <- paste("http://www.boldsystems.org/index.php/API_Public/sequence?","&container=SSBAA", sep="")
# temp <- read.fasta(get.string)
# 
# 
# temp[1]




# #
# # Identity is on the main diagonal:
# #
# dotPlot(letters, letters, main = "Direct repeat")
# #
# # Internal repeats are off the main diagonal:
# #
# dotPlot(rep(letters, 2), rep(letters, 2), main = "Internal repeats")
# #
# # Inversions are orthogonal to the main diagonal:
# #
# dotPlot(letters, rev(letters), main = "Inversion")
# #
# # Insertion in the second sequence yields a vertical jump:
# #
# dotPlot(letters, c(letters[1:10], s2c("insertion"), letters[11:26]),
#         main = "Insertion in the second sequence", asp = 1)
# #
# # Insertion in the first sequence yields an horizontal jump:
# #
# dotPlot(c(letters[1:10], s2c("insertion"), letters[11:26]), letters,
#         main = "Insertion in the first sequence", asp = 1)
# #
# # Protein sequences have usually a good signal/noise ratio because there
# # are 20 possible amino-acids:
# #
# aafile <- system.file("sequences/seqAA.fasta", package = "seqinr")
# protein <- read.fasta(aafile)[[1]]
# dotPlot(protein, protein, main = "Dot plot of a protein\nwsize = 1, wstep = 1, nmatch = 1")
# #
# # Nucleic acid sequences have usually a poor signal/noise ratio because
# # there are only 4 different bases:
# #
# dnafile <- system.file("sequences/malM.fasta", package = "seqinr")
# dna <- protein <- read.fasta(dnafile)[[1]]
# dotPlot(dna[1:200], dna[1:200],
#         main = "Dot plot of a nucleic acid sequence\nwsize = 1, wstep = 1, nmatch = 1")
# #
# # Play with the wsize, wstep and nmatch arguments to increase the
# # signal/noise ratio:
# #
# dotPlot(dna[1:200], dna[1:200], wsize = 3, wstep = 3, nmatch = 3,
#         main = "Dot plot of a nucleic acid sequence\nwsize = 3, wstep = 3, nmatch = 3")
