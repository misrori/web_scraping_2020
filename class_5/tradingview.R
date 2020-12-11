

require(httr)
library(jsonlite)
library(data.table)

headers = c(
  `authority` = 'scanner.tradingview.com',
  `accept` = 'text/plain, */*; q=0.01',
  `user-agent` = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
  `content-type` = 'application/x-www-form-urlencoded; charset=UTF-8',
  `origin` = 'https://www.tradingview.com',
  `sec-fetch-site` = 'same-site',
  `sec-fetch-mode` = 'cors',
  `sec-fetch-dest` = 'empty',
  `referer` = 'https://www.tradingview.com/',
  `accept-language` = 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7',
  `cookie` = '__utma=226258911.616476251.1574933187.1585902162.1585902162.249; _ga=GA1.2.616476251.1574933187; sessionid=fx3sawb8h4vj19p3o2u8e7s3xut1ptc2; tv_ecuid=692b830f-a7a5-4bb1-a1c9-b870463c5460; _gid=GA1.2.1065370016.1606836054; _sp_ses.cf1a=*; _sp_id.cf1a=305c859a-dc60-45be-b87a-2ebaad3c8c5e.1574933187.929.1607445389.1607442734.4522d0e0-ab36-48bb-bcfd-5894011b45dc'
)

data = '{"filter":[{"left":"market_cap_basic","operation":"nempty"},{"left":"type","operation":"in_range","right":["stock","dr","fund"]},{"left":"subtype","operation":"in_range","right":["common","","etf","unit","mutual","money","reit","trust"]},{"left":"exchange","operation":"in_range","right":["AMEX","NASDAQ","NYSE"]}],"options":{"lang":"en"},"symbols":{"query":{"types":[]},"tickers":[]},"columns":["logoid","name","close","change","change_abs","Recommend.All","volume","market_cap_basic","price_earnings_ttm","earnings_per_share_basic_ttm","number_of_employees","sector","MACD.macd","MACD.signal","net_debt","total_debt","Volatility.D","description","name","type","subtype","update_mode","pricescale","minmov","fractional","minmove2","MACD.macd","MACD.signal"],"sort":{"sortBy":"market_cap_basic","sortOrder":"desc"},"range":[0,6000]}'


res <- httr::POST(url = 'https://scanner.tradingview.com/america/scan', httr::add_headers(.headers=headers), body = data)
df <- fromJSON(content(res, 'text'))
t <- fromJSON(data)
t_colnames <- t$columns





x <- df$data$d[[1]]

findf <- 
rbindlist(
lapply(df$data$d, function(x){
  tdf <- data.frame(t(data.frame(x)))
  names(tdf) <- t_colnames
  return(tdf)
})
)
  
get_tradingview_data  <- function(data) {
  
  headers = c(
    `authority` = 'scanner.tradingview.com',
    `accept` = 'text/plain, */*; q=0.01',
    `user-agent` = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36',
    `content-type` = 'application/x-www-form-urlencoded; charset=UTF-8',
    `origin` = 'https://www.tradingview.com',
    `sec-fetch-site` = 'same-site',
    `sec-fetch-mode` = 'cors',
    `sec-fetch-dest` = 'empty',
    `referer` = 'https://www.tradingview.com/',
    `accept-language` = 'hu-HU,hu;q=0.9,en-US;q=0.8,en;q=0.7',
    `cookie` = '__utma=226258911.616476251.1574933187.1585902162.1585902162.249; _ga=GA1.2.616476251.1574933187; sessionid=fx3sawb8h4vj19p3o2u8e7s3xut1ptc2; tv_ecuid=692b830f-a7a5-4bb1-a1c9-b870463c5460; _gid=GA1.2.1065370016.1606836054; _sp_ses.cf1a=*; _sp_id.cf1a=305c859a-dc60-45be-b87a-2ebaad3c8c5e.1574933187.929.1607445389.1607442734.4522d0e0-ab36-48bb-bcfd-5894011b45dc'
  )
  
  #data = '{"filter":[{"left":"market_cap_basic","operation":"nempty"},{"left":"type","operation":"in_range","right":["stock","dr","fund"]},{"left":"subtype","operation":"in_range","right":["common","","etf","unit","mutual","money","reit","trust"]},{"left":"exchange","operation":"in_range","right":["AMEX","NASDAQ","NYSE"]}],"options":{"lang":"en"},"symbols":{"query":{"types":[]},"tickers":[]},"columns":["logoid","name","close","change","change_abs","Recommend.All","volume","market_cap_basic","price_earnings_ttm","earnings_per_share_basic_ttm","number_of_employees","sector","MACD.macd","MACD.signal","net_debt","total_debt","Volatility.D","description","name","type","subtype","update_mode","pricescale","minmov","fractional","minmove2","MACD.macd","MACD.signal"],"sort":{"sortBy":"market_cap_basic","sortOrder":"desc"},"range":[0,300]}'
  
  t <- fromJSON(data)
  t_colnames <- t$columns
  res <- httr::POST(url = 'https://scanner.tradingview.com/america/scan', httr::add_headers(.headers=headers), body = data)
  
  df <- fromJSON(content(res, 'text'))
  
  x <- df$data$d[[1]]
  
  fin_df <- rbindlist(
    lapply(df$data$d, function(x){
      tdf <- data.table(t(data.frame(x)))
      names(tdf) <- t_colnames
      return(tdf)
    }))
  return(fin_df)
}

t_json<- '{"filter":[{"left":"name","operation":"nempty"},{"left":"exchange","operation":"in_range","right":["AMEX","NASDAQ","NYSE"]},{"left":"RSI","operation":"less","right":30},{"left":"subtype","operation":"nequal","right":"preferred"}],"options":{"lang":"en","active_symbols_only":true},"symbols":{"query":{"types":[]},"tickers":[]},"columns":["logoid","name","change|1","change|5","change|15","change|60","change|240","change","Perf.W","Perf.1M","Perf.3M","Perf.6M","Perf.YTD","Perf.Y","beta_1_year","Volatility.D","description","name","type","subtype","update_mode"],"sort":{"sortBy":"name","sortOrder":"asc"},"range":[0,150]}'
oversold <- get_tradingview_data(t_json)



