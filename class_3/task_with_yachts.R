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
  t <- read_html(my_link)
  data_list <- list()
  

    
  return(data_list)
}


df <- rbindlist(lapply(yacht_links, process_yachts), fill = T)