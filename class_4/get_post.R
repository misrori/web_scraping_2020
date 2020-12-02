
library(httr)
library(jsonlite)
library(rvest)
library(tidyverse)
library(data.table)
# GET request
my_ans <- GET('https://www.economist.com/international/2019/11/12/banned-in-warfare-is-tear-gas-too-readily-used-to-control-crowds')
content(my_ans, 'text') # the text content is the answer what you get with the request. It can be json, html, xml etc.
my_page <- read_html(content(my_ans, 'text'))
# you can write out and check what is the page looks like. 
write_html(my_page, 't.html')



my_ans <- GET('https://www.economist.com/international/2019/11/12/banned-in-warfare-is-tear-gas-too-readily-used-to-control-crowds', verbose(info=T))


# POST demo
# eu fundings demo
# open the site: https://www.palyazat.gov.hu/tamogatott_projektkereso
# click to next page, find the data source 

my_b <- list("filter" = toJSON( list("where"=list("fejlesztesi_program_nev"="Széchenyi 2020"),"skip"="0","limit"=200000,"order"="konstrukcio_kod, palyazo_neve ASC" ),auto_unbox = T) )
t<- POST('https://pghrest.fair.gov.hu/api/tamogatott_proj_kereso/find2',  body = my_b, encode = 'json',  verbose(info=T))
my_data<- fromJSON(content(t, 'text'))
nrow(my_data)




require(httr)

headers = c(
  `Connection` = 'keep-alive',
  `Accept` = 'application/json, text/plain, */*',
  `User-Agent` = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36',
  `Content-Type` = 'application/x-www-form-urlencoded',
  `Origin` = 'https://www.palyazat.gov.hu',
  `Sec-Fetch-Site` = 'same-site',
  `Sec-Fetch-Mode` = 'cors',
  `Sec-Fetch-Dest` = 'empty',
  `Referer` = 'https://www.palyazat.gov.hu/',
  `Accept-Language` = 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7'
)

data = list(
  `filter` = '{"where":{"fejlesztesi_program_nev":"Sz\xE9chenyi 2020"},"skip":"30","limit":10,"order":"konstrukcio_kod, palyazo_neve ASC"}'
)

res <- httr::POST(url = 'https://pghrest.fair.gov.hu/api/tamogatott_proj_kereso/find2', httr::add_headers(.headers=headers), body = data)

d <- fromJSON(content(res, 'text'))

