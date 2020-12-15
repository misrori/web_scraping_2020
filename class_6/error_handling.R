library(data.table)
library(rvest)

car_links <- c('https://www.ultimatespecs.com/car-specs/BMW/114669/BMW-X7-G07-xDrive-M50i.html',
               'https://www.ultimatespecs.com/car-specs/Cadillac/121903/Cadillac-CT4-CT4-V-AWD.html',
               'https://www.ultimatespecs.com/car-specs/Aston-Martin/117232/Aston-Martin-DBX-40-V8.html')

#               'https://www.economist.com/finance-and-economics/2020/12/12/opec-loosens-up',

process_one_car  <- function(my_link) {
  
  t <- read_html(my_link)
  data_list <- list()
  data_list[['link']] <- my_link
  data_list[['name']] <- t %>% html_node('.breadcrumb') %>% html_text()
  
  tkey <- gsub(':', '', trimws( t %>% html_nodes('.tabletd') %>% html_text()), fixed = T)
  tvaleus <- trimws(t %>% html_nodes('.tabletd_right') %>% html_text())
  
  if (length(tkey) == length(tvaleus)) {
    for (key_id in 1:length(tvaleus)) {
      data_list[[ tkey[key_id] ]] <- tvaleus[key_id]
    }
  }
  return(data_list)
}


df <- rbindlist(lapply(car_links, process_one_car), fill = T)


View(df)