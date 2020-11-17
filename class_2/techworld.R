library(data.table)
library(rvest)

my_url <- 'https://www.technewsworld.com/perl/search.pl?x=16&y=10&query=big+data'

t <- read_html(my_url)
boxes <- t %>% 
  html_nodes('.shadow')
x <- boxes[[1]]
boxes_df <- lapply(boxes, function(x){
  t_list <- list()
  t_list[['title']] <- x %>% html_nodes('.searchtitle') %>% html_text()
  t_list[['link']] <- x %>% html_nodes('.searchtitle') %>% html_attr('href')
  t_list[['teaser']] <-  paste0(x %>% html_nodes('p') %>% html_text(), collapse = ' ')
  
  return(data.frame(t_list))  
  
})
df <- rbindlist(boxes_df)

# 

get_one_page_from_techworld  <- function(my_url) {
  print(my_url)
  t <- read_html(my_url)
  boxes <- t %>% 
    html_nodes('.shadow')
  x <- boxes[[1]]
  boxes_df <- lapply(boxes, function(x){
    t_list <- list()
    t_list[['title']] <- x %>% html_nodes('.searchtitle') %>% html_text()
    t_list[['link']] <- x %>% html_nodes('.searchtitle') %>% html_attr('href')
    t_list[['teaser']] <-  paste0(x %>% html_nodes('p') %>% html_text(), collapse = ' ')
    return(data.frame(t_list))  
  })
  df <- rbindlist(boxes_df)
  return(df)
}

# searchterm <- 'summer'
# page_to_download <- 5

get_techworld <- function(searchterm, page_to_download) {
  
  # create links
 links_to_get <- 
  paste0('https://www.technewsworld.com/perl/search.pl?x=0&y=0&query=',searchterm, '&init=', seq(0, (page_to_download*20), by = 20 ))
 ret_df <- rbindlist(lapply(links_to_get, get_one_page_from_techworld))
  return(ret_df)
  
}


df <- get_techworld(searchterm = 'love', 3)
