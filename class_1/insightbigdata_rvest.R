library(rvest)
library(data.table)
#read_html just pass the url
t <- read_html('https://insidebigdata.com/?s=big+data')

# save it and check if the characters that you are looking for are inside the document
write_html(t, 't.html')


titles <- 
  t %>% 
  html_nodes('.entry-title-link') %>% 
  html_text()

times <- 
  t %>% 
  html_nodes('.time') %>% 
  html_text()

my_link <- 
  t %>% 
  html_nodes('.entry-title-link') %>% 
  html_attr('href')

text_summary <- 
  t %>% 
  html_nodes('#content p') %>% 
  html_text()

#if the length of the vectors are the same, we are lucky it is easy to create a df
df <- data.frame('title'=titles, 'links'= my_link, 'summary'= text_summary)  


#ok now lets put it into a function

get_insidebigdata_page <- function(my_url) {
  
  t <- read_html(my_url)
  
  # save it and check if the characters that you are looking for are inside the document
  write_html(t, 't.html')
  
  
  titles <- 
    t %>% 
    html_nodes('.entry-title-link') %>% 
    html_text()
  
  times <- 
    t %>% 
    html_nodes('.time') %>% 
    html_text()
  
  my_link <- 
    t %>% 
    html_nodes('.entry-title-link') %>% 
    html_attr('href')
  
  text_summary <- 
    t %>% 
    html_nodes('#content p') %>% 
    html_text()
  
  #if the length of the vectors are the same, we are lucky it is easy to create a df
  df <- data.frame('title'=titles, 'links'= my_link, 'summary'= text_summary)  
  
  return(df)
  
}


#try your function
t <- get_insidebigdata_page('https://insidebigdata.com/page/2/?s=big+data')

#create the urls
t_urls <- paste0('https://insidebigdata.com/page/', 2:5, '/?s=big+data' )

#apply your function to your list
df_list <- lapply(t_urls, get_insidebigdata_page)

#create a data.table object of the list of data.frames
df <- rbindlist(df_list)


