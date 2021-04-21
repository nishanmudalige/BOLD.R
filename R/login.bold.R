#' @export
login.bold <- function(username){
  
  password.prompt <- paste("Please enter the password associated with the Bold Systems account for",username,sep=" ")
  password <- getPass::getPass(msg = password.prompt, forcemask = FALSE)
  
  # convert to UTF-8 URL Encoding for MOST special characters
  username <- URLencode(username, reserved=TRUE)
  password <- URLencode(password, reserved=TRUE)
  username <- gsub("\\.",	"%2E", username)  # b/c periods are not converted with URLencode
  password <- gsub("\\.",	"%2E", password)  # b/c periods are not converted with URLencode
  
  # get.string <- paste("https://api.boldsystems.org:6544/dropin/acl_gettoken?username=",username,"&password=",password, sep="")
  get.string <- paste("https://api.boldsystems.org/dropin/acl_gettoken?username=",username,"&password=",password, sep="")
  
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