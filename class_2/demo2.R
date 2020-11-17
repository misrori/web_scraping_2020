tl <- list()

tl[['first_elemnt']] <- 2

tl$second_element <- 'ceu'

tl[['first_vector']] <- 1:10
tl[['cars']] <- mtcars

tl$cars

list_2 <- list('a'=2, b=1:10, c=mtcars)
# i <-3

for (i in 1:length(letters)) {
  tl[[ paste0('letters_', i)  ]] <- letters[i]
}

names(tl)

notnamedlist<- list()
for (i in 1:length(letters)) {
  notnamedlist[[i]]<- letters[i]
}
names(notnamedlist)
notnamedlist[[2]]

str(notnamedlist[1])

notnamedlist[[1]]

str(mtcars)
as.character(2)

library(jsonlite)
tl
toJSON(tl)
toJSON(tl, auto_unbox = T)
toJSON(tl, auto_unbox = T, pretty = T)
write_json(tl, path = 'my_res.json',pretty = T,    auto_unbox = T)

from_list <- fromJSON('my_res.json')


# economist ---------------------------------------------------------------
library(rvest)
library(data.table)
library(jsonlite)
my_url <- 'https://www.economist.com/finance-and-economics/'

t <- read_html(my_url)
# write_html(t, 't.html')
boxes <- t %>% html_nodes('.teaser')

x <- boxes[[1]]
boxes_dfs <- lapply(boxes, function(x){
  tl <- list()
  tl[['title']] <- x %>% html_nodes('.headline-link') %>% html_text()
  tl[['link']] <- paste0('https://www.economist.com', x %>% html_nodes('.headline-link') %>% html_attr('href'))
  tl[['teaser']] <- x %>% html_nodes('.teaser__description') %>% html_text()
  #tl[['myerror']] <- x %>% html_nodes('.teaser__descriptiondd') %>% html_text()
  return(data.table(tl))
})

df <- rbindlist(boxes_dfs, fill = T)


get_economist_data <- function(my_url) {
  print(my_url)
  t <- read_html(my_url)
  # write_html(t, 't.html')
  boxes <- t %>% html_nodes('.teaser')
  
  # x <- boxes[[1]]
  boxes_dfs <- lapply(boxes, function(x){
    tl <- list()
    tl[['title']] <- x %>% html_nodes('.headline-link') %>% html_text()
    tl[['link']] <- paste0('https://www.economist.com', x %>% html_nodes('.headline-link') %>% html_attr('href'))
    tl[['teaser']] <- x %>% html_nodes('.teaser__description') %>% html_text()
    #tl[['myerror']] <- x %>% html_nodes('.teaser__descriptiondd') %>% html_text()
    return(tl)
  })
  
  df <- rbindlist(boxes_dfs, fill = T)
  return(df)
}

get_more_page  <- function(page_to_download = 5) {
  my_urls <- c('https://www.economist.com/finance-and-economics/', 
    paste0('https://www.economist.com/finance-and-economics/?page=', 2:page_to_download))
  
  list_of_dfs <- lapply(my_urls, get_economist_data)
  df <- rbindlist(list_of_dfs, fill=T)
  return(df)
}

df <- get_economist_data('https://www.economist.com/finance-and-economics/?page=2')
econ_data <- get_more_page(3)

# View(data.table(tl))


my_url <- 'https://en.wikipedia.org/wiki/Car'
t<- read_html(my_url)
list_of_table <- t %>% html_table(fill = T)
df <- list_of_table[[1]]

df <- fromJSON('https://deathtimeline.com/api/deaths?season=1')
list_of_df <- fromJSON('https://deathtimeline.com/api/deaths?season=1', simplifyDataFrame = F)


companies <- fromJSON('https://www.forbes.com/forbesapi/org/powerful-brands/2020/position/true.json?limit=2000')


write_html(read_html('https://www.forbes.com/the-worlds-most-valuable-brands/'), 't.html')
