#' @export
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
