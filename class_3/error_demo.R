library(rvest)
library(data.table)

my_url <- 'https://www.wsj.com/search?query=trump'
get_one_page <- function(my_url) {
  t <- read_html(my_url)
  write_html(t, 't.html')
  boxes <-
    t %>%
    html_nodes('.WSJTheme--search-result--2NFlrTX7')
  write_html(t, "t.html")
  x <- boxes[[1]]
  box_dfs <- lapply(boxes, function(x){
    tlist <- list()
    tlist[['title']] <- x %>% html_nodes('.typography--serif-display--ZXeuhS5E') %>% html_text()
    tlist[['summary']] <- x %>% html_nodes('.WSJTheme--summary--lmOXEsbN')%>% html_text()
    tlist[['author']] <- x %>% html_nodes('.WSJTheme--byline--1oIUvtQ3')%>% html_text()
    tlist[['link']] <- paste0('https://www.wsj.com/', x %>%  html_nodes('.typography--serif-display--ZXeuhS5E') %>% html_attr('href'))
    return(tlist)
  })
  df <- rbindlist(box_dfs, fill = T)
  return(df)
}
df <- get_one_page(my_url)



# https://www.forbes.com/global2000/#19a41c92335d


require(httr)

headers = c(
  `authority` = 'www.forbes.com',
  `accept` = 'application/json, text/plain, */*',
  `user-agent` = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36',
  `sec-fetch-site` = 'same-origin',
  `sec-fetch-mode` = 'cors',
  `sec-fetch-dest` = 'empty',
  `referer` = 'https://www.forbes.com/global2000/',
  `accept-language` = 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7',
  `cookie` = 'gig_bootstrap_3_8Fcn29ZQ5lcRRr8BsC6Y2q8eRKPl567JTM6IWXsqW4eqW57_fNx29GDl9YdzZLvH=_gigya_ver3; client_id=ec47d58368760591b0383b65cb8fd5f5abe; _ga=GA1.2.1902738513.1605625995; __qca=P0-1402510187-1605625999275; crdl_forbes-liveaID=anonimlxatI2FLH503g5dtOlfj; __tbc=%7Bjzx%7DIFcj-ZhxuNCMjI4-mDfH1OqNR355Z3R4S_E-gs4ZDLis9bX2bI3oNX57-tkFtSVltU7Dd5KjMhaAAla_P4hxqNvHRQuod-vBO9NsM6kOaB8fuVdvOlm8hb5AicLHZDRV3E9l5ifC0NcYbET3aSZxuA; __pat=-18000000; __gads=ID=794ae81b9ec3489d:T=1605626001:S=ALNI_MbRAO9ALnwcSPWxgkw2MwvXxWpZXA; _cb_ls=1; _cb=B7DDABP9iMDC3H4Ms; global_ad_params=%7B%7D; __pnahc=255; xbc=%7Bjzx%7DX9XB4fAAyPCs50imutKlNz38lKop6ypiFULu2GQILbZoifDq7hf67MA8j3qHU6nOPgJSgnIoTLnrydvRzyTw0O5sVt3bCTjp_Bi2GcOtmtOYvWF0HlzdBfoL2rPXCXV1fHNFXSx45Z8MoH10qNFpDvJXGAu7ufmnas0vl5o4UgppaeNyjGHL8ZxSK1KE9oYv9-EKGjrmROQzoNQuYNxMFPipLt1uWMFYnN_Y5wRBXLeSf84ptm0nq-YvpPWZXgXvCa0YgNdGnbuzVu_IndI3V-zUJ_zhFN2oEch-0mrW0MQ; _chartbeat2=.1571989219749.1606039476251.0000000000100001.B5eu5TCKkbgLCZpjzLekbqSC8mQ5o.1; notice_behavior=expressed,eu; notice_preferences=2:1a8b5228dd7ff0717196863a5d28ce6c; notice_gdpr_prefs=0,1,2:1a8b5228dd7ff0717196863a5d28ce6c; session_depth=www.forbes.com%3D1%7C462705817%3D1%7C383070046%3D1%7C823003578%3D1%7C659093976%3D1%7C218291818%3D1; mnet_session_depth=1%7C1606214230886'
)

params = list(
  `limit` = '2000'
)

res <- httr::GET(url = 'https://www.forbes.com/forbesapi/org/global2000/2020/position/true.json', httr::add_headers(.headers=headers), query = params)

df <- fromJSON(content(res, 'text'))

tdf <-df$organizationList$organizationsLists 
saveRDS(tdf, 'forbescomp.rds')

# try with for loop et all years
# private browser
# https://www.youtube.com/channel/UCkWbqlDAyJh2n8DN5X6NZyg
# https://www.youtube.com/channel/UCKFJx67o0c2MhgYlA3aCo_g
# racing barcharts
# https://app.flourish.studio/projects#



