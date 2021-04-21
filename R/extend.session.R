#' @export
extend.session <- function(token){
  
  extend <- suppressWarnings( read.table(paste("https://api.boldsystems.org:6544/dropin/securitytoken_extend?t=",token,sep="")) )
  
  if( as.character(extend[,"V1"]) == "true"){
    
    print("Token time extended")
    print(paste("Your current session will expire in 6 hours at", Sys.time() + 6*60*60,sep=" "))
    
  } else if( as.character(extend[,"V1"]) == "Invalid credential token"){
    
    return(warning("Invalid or expired token entered. Time not extended."))
    
  }
}