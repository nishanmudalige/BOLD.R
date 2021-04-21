#' @export
user.public.datasets <- function(username, token){
  if( !is.character(username) ){
    warning("Input not valid.")
    break
  } else {
    # get.string <- paste(" https://api.boldsystems.org:6544/dropin/user_publicdatasets?user_code=",username,"&t=",token, sep="")
    get.string <- paste(" https://api.boldsystems.org/dropin/user_publicdatasets?user_code=",username,"&t=",token, sep="")
    out <- suppressWarnings( fromJSON(get.string) )
    
    return(out)
  }
}
