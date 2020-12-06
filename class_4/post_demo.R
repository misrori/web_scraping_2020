library(httr)
library(jsonlite)
send_messageto_hype_crypto <- function(my_text) {
  
  headers = c(
    `Content-type` = 'application/json'
  )
  data= toJSON(list("text"= my_text), auto_unbox = T)
  res <- httr::POST(url = 'your webhook', httr::add_headers(.headers=headers), body = data)
}

send_messageto_hype_crypto('hellloo')
