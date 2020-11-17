library(rvest)
library(data.table)
my_url <- 'https://www.economist.com/finance-and-economics/'

get_one_page <- function(my_url) {
  t <- read_html(my_url)
  boxes <- 
  t %>% 
    html_nodes('.teaser')
  
  box_dfs <- lapply(boxes, function(x){
    tlist <- list()
    tlist[['my_title']] <- 
      x %>% 
      html_nodes('.headline-link')%>%
      html_text()
    
    my_relative_link <- 
      x%>% 
      html_nodes('.headline-link')%>%
      html_attr('href')
    
    tlist[['my_link']] <- paste0('https://www.economist.com/', my_relative_link)
    
    tlist[['my_teaser']] <-
      x %>% 
      html_nodes('.teaser__text')%>%
      html_text()
    
    #
    
    return(tlist)
    
  })
  df <- rbindlist(box_dfs, fill = T)
  return(df)
  #
}

df <- get_one_page(my_url)

get_data_from_economist <- function(number_of_page=5) {
  pages <- c('https://www.economist.com/finance-and-economics/', paste0('https://www.economist.com/finance-and-economics/?page=',2:number_of_page))
  df <- rbindlist(lapply(pages, get_one_page))
  return(df)
}

df <- get_data_from_economist(3)
