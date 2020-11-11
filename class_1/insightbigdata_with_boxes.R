library(rvest)
library(data.table)
#read_html just pass the url
t <- read_html('https://insidebigdata.com/?s=big+data')
# save it and check if the characters that you are looking for are inside the document
write_html(t, 't.html')

boxes <- 
  t %>%
  html_nodes('.has-post-thumbnail')



# x <-boxes[3]  it helps to see what is going on in the lapply

list_of_df <- 
lapply(boxes, function(x){

  titles <- 
    x %>% 
    html_nodes('.entry-title-link') %>% 
    html_text()
  
  times <- 
    x %>% 
    html_nodes('.time') %>% 
    html_text()
  if (length(times) ==0) {
    times <- ''
  }
  
  my_link <- 
    x %>% 
    html_nodes('.entry-title-link') %>% 
    html_attr('href')
  
  text_summary <- 
    x %>% 
    html_nodes('p') %>% 
    html_text()
  if (length(text_summary) ==0) {
    text_summary <- ''
  }
  
  categories <- 
    x %>% html_nodes('.categories') %>% 
    html_text()
  if (length(categories) ==0) {
    categories <- ''
  }
  
  # it will be a one row data.frame
  return(data.frame('title'=titles, 'links'= my_link, 'summary'= text_summary, 'categories' = categories, 'times'=times)    )
})

page_df <- rbindlist(list_of_df)



# put it into function

get_one_page  <- function(my_url ) {
  t <- read_html(my_url)
  # save it and check if the characters that you are looking for are inside the document
  write_html(t, 't.html')
  
  boxes <- 
    t %>%
    html_nodes('.has-post-thumbnail')
  
  list_of_df <- 
    lapply(boxes, function(x){
      
      titles <- 
        x %>% 
        html_nodes('.entry-title-link') %>% 
        html_text()
      
      times <- 
        x %>% 
        html_nodes('.time') %>% 
        html_text()
      if (length(times) ==0) {
        times <- ''
      }
      
      my_link <- 
        x %>% 
        html_nodes('.entry-title-link') %>% 
        html_attr('href')
      
      text_summary <- 
        x %>% 
        html_nodes('p') %>% 
        html_text()
      if (length(text_summary) ==0) {
        text_summary <- ''
      }
      
      categories <- 
        x %>% html_nodes('.categories') %>% 
        html_text()
      if (length(categories) ==0) {
        categories <- ''
      }
      
      # it will be a one row data.frame
      return(data.frame('title'=titles, 'links'= my_link, 'summary'= text_summary, 'categories' = categories, 'times'=times)    )
    })
  
  page_df <- rbindlist(list_of_df)
  return(page_df)
  
}




#try your function
t <- get_one_page('https://insidebigdata.com/page/2/?s=big+data')

#create the urls
t_urls <- paste0('https://insidebigdata.com/page/', 2:5, '/?s=big+data' )

#apply your function to your list
df_list <- lapply(t_urls, get_one_page)

#create a data.table object of the list of data.frames
df <- rbindlist(df_list)

