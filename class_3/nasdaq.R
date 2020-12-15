library(jsonlite)
library(data.table)
library(lubridate)

#my_page_id <- 1
get_one_page_of_nasdaq <- function(my_page_id) {
  print(my_page_id)
  t <- fromJSON(paste0('https://www.nasdaq.com/api/v1/screener?page=',my_page_id,'&pageSize=50'), flatten = T)
  # delete articels
  t$data$articles <- NULL
  t$data$priceChartSevenDay
  
  x <- t$data$priceChartSevenDay[[1]]
  t$data$priceChartSevenDay <- 
    unlist(
      lapply(t$data$priceChartSevenDay, function(x){
        if (nrow(x)==0) {
          return(0)
          
        }else{
          first <-head(x$price, 1) # head(x$price, 1)
          last <-  tail(x$price, 1)
          price_change <- ((last/first)-1)*100
          return(price_change)
        }
        
      })
    )
  # t$data$priceChartSevenDay
  # str(t$data$priceChartSevenDay[[1]])
  return( t$data)
  
}

list_of_df <- lapply(1:5, get_one_page_of_nasdaq)

my_final_res <- rbindlist(list_of_df)
