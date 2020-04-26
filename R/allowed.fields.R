#' @export
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
