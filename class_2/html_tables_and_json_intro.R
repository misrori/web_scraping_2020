library(rvest)
library(jsonlite)
t <- read_html('https://en.wikipedia.org/wiki/Cars_(film)')
list_of_tables <- t %>% html_table(fill = T)
View(list_of_tables[[1]])

# go to https://deathtimeline.com/
# press f12
# refresh

for (my_id in c(1:20)) {
  print(my_id)
  my_url <- paste0('https://deathtimeline.com/', my_id, '.jpg')
  print(my_url)
  my_saving_path <- paste0('gameofthrones/', my_id, '.jpg')
  download.file(my_url, my_saving_path)
  print(my_saving_path)
}


# check the xhr tab and the json object

df <- fromJSON('https://deathtimeline.com/api/deaths?season=1')
tl <- fromJSON('https://deathtimeline.com/api/deaths?season=1',simplifyDataFrame = F)

# task find the most valuable companies
# https://www.forbes.com/powerful-brands/list/
# https://www.forbes.com/forbesapi/org/powerful-brands/2020/position/true.json?limit=2000