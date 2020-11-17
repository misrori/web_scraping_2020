In this repository you will find the code of the "Coding 2: Web Scraping with R" course in the 2020/2021 Fall term, part of the MSc in Business Analytics at CEU.

# Web scraping with R

## Pre requirements:
* Installed R and R studio
* "rvest", "data.table", "jsonlite" package installed
```R
install.packages(c("rvest", "data.table", "jsonlite"))
```
* [SelectorGadget](https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb) extension for browser. (Chrome is the preferred browser)


## Topics:
* rvest, html_nodes, html_attr, html_table, lapply, sapply, for loop, if statment
* GET, POST, ad header and data to requests
* Selenium
* Multi threading with R and python

## Assignments

#### HTML process
* Find a news website or any website where you can search for a keyword and the matches return in a list.
* Create a function which downloads information from a url to dataframe from the website that you found interesting.
* Create a function which requires two arguments. First a keyword then a number of pages to download.
* Create the links and apply your function to the links that you created and save the dataframe into csv and rds objects.
* Create a pretydoc HTML where I can see the function and a the result of it.
* Upload your code into github, and to module.
* The deadline is november 23.