#' @export
user.datasets <- function(username, token){
  if( !is.character(username) ){
    warning("Input not valid.")
    break
  } else {
    # get.string <- paste("http://131.104.63.24:6544/dropin/user_datasets?user_code=",username,"&t=",token, sep="")
    get.string <- paste("http://131.104.63.24/dropin/user_datasets?user_code=",username,"&t=",token, sep="")
    out <- suppressWarnings( fromJSON(get.string) )
    
    return(out)
  }
}