car_links <- c('https://www.ultimatespecs.com/car-specs/Aston-Martin/117232/Aston-Martin-DBX-40-V8.html',
               'https://www.ultimatespecs.com/car-specs/Aston-Martin/109041/Aston-Martin-DB11-V12.html', 
               'https://www.ultimatespecs.com/car-specs/Tesla/30808/Tesla-Roadster-Electric.html')



process_one_car_page  <- function(my_link) {

  #my_link <- 'https://www.ultimatespecs.com/car-specs/Aston-Martin/117232/Aston-Martin-DBX-40-V8.html'
  
  data_list <- list()
  t <- read_html(my_link)
  data_list[['car_id']] <- t %>% html_node('.breadcrumb') %>% html_text()
  data_list[['link']] <- my_link
  
  tkeys <- trimws(gsub(':', '', trimws(t %>% html_nodes('.tabletd') %>% html_text()),fixed = T))
  tvalue <- gsub('"', '', trimws(t %>% html_nodes('.tabletd_right') %>% html_text()), fixed = T)
  
  if (length(tkeys) ==length(tvalue)) {
    print('good data')
    for (i in 1:length(tkeys)) {
      data_list[[  tkeys[i]  ]] <- tvalue[i]
    }
  }
  
  # demodf <- data.frame(t(data.frame('key'= tkeys, 'value'= tvalue )))
  # names(demodf) <- as.character(demodf[1,])
  # demodf <- demodf[2:nrow(demodf),]
  # 
  return(data_list)
  
}


df <- rbindlist(lapply(car_links, process_one_car_page), fill = T)