yacht_links <- c('https://www.boatinternational.com/yachts-for-sale/rainbow--80615',
                 'https://www.boatinternational.com/yachts-for-sale/steadfast--103295',
                 'https://www.boatinternational.com/yachts-for-sale/crescent-117--99363')


my_link <- 'https://www.boatinternational.com/yachts-for-sale/crescent-110--95543'
t <- read_html(my_link)
data_list <- list()

# get the keys
# get the values
# check if they have same length
# with for loop process the data
# return with list
# put it into finction

process_yachts  <- function(my_link) {
  print(my_link)
  t <- read_html(my_link)
  data_list <- list()
  
 tkeys <- t %>% html_nodes('.stats__title') %>% html_text()
 tvalue <- t %>% html_nodes('.stats__value') %>% html_text()
 if (length(tkeys) ==length(tvalue)) {
   print('good base info data')
   for (i in 1:length(tkeys)) {
     data_list[[  tkeys[i]  ]] <- tvalue[i]
   }
 }
 
 
 tkeys <- t %>% html_nodes('.spec-block__title') %>% html_text()
 tvalue <- t %>% html_nodes('.spec-block__data') %>% html_text()
 if (length(tkeys) ==length(tvalue)) {
   print('good base info data')
   for (i in 1:length(tkeys)) {
     data_list[[  tkeys[i]  ]] <- tvalue[i]
   }
 }
 
  return(data_list)
}
process_yachts(yacht_links[1])

df <- rbindlist(lapply(yacht_links, process_yachts), fill = T)