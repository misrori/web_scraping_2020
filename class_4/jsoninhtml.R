# start with imdb
library(rvest)
library(jsonlite)
library(data.table)

# find any movie
t <- read_html('https://www.imdb.com/title/tt4154796/')

# get the json of it. 
json_data <- 
  fromJSON(
    t %>%
      html_nodes(xpath = "//script[@type='application/ld+json']")%>%
      html_text()
  )
# database publicly available: https://www.imdb.com/interfaces/
# you can make network analysis with the data
# more info about xpath: https://www.guru99.com/xpath-selenium.html
# https://www.youtube.com/watch?v=r_AP1I3T9yM
# I think you do not have to know how it works, most of the time it will be:
#just this two option:
#html_nodes(xpath = "//script[@type='application/ld+json']")
#html_nodes(xpath = "//script[@type='application/json']")


# payscale 
# https://www.payscale.com/research/US/Job    the base url
# finance   last/B means startswith B
t <- read_html('https://www.payscale.com/research/US/Job=Data_Scientist/Salary')

t <- read_html('https://www.payscale.com/research/US/Job/Accounting-Finance/B')
write_html(t, 't.html')

# there is no a 'anchor'
rel_links <- 
  t%>%
  html_nodes('.subcats__links__item')%>%
  html_attr('href')

my_links <- 
  paste0('https://www.payscale.com', rel_links)


# task get all the jobs 
# write a function which return the data of the sallary save it into json. 
t <- read_html('https://www.payscale.com/research/US/Job=Product_Manager%2C_Software/Salary')
my_data  <- fromJSON(t %>%
                       html_nodes(xpath = "//script[@type='application/ld+json']")%>%
                       html_text()
)

my_data2  <- fromJSON(t %>%
                        html_nodes(xpath = "//script[@type='application/json']")%>%
                        html_text()
)
