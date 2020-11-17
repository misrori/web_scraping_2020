tl <- list()
tl[['first_element']] <- 2
tl$hello<- 'ceu'
tl[['trueorfalse']] <- FALSE
df <- data.frame(tl)
View(df)  
tl[['list_inlist']] <- list('cars'=mtcars)
str(tl)

tl$list_inlist$cars
# tl <-list()
for (i in 1:length(letters)) {
  #tl[[paste0('letters_',  i) ]] <- letters[i]
  tl[[ i ]] <- letters[i]
}
tl$letters_2

tl <-list()
for (i in 1:length(letters)) {
  tl[[ i ]] <- letters[i]
}

tl[[3]]


library(jsonlite)
toJSON(tl) 
#http://jsonviewer.stack.hu/
toJSON(tl,auto_unbox = T)
toJSON(tl,auto_unbox = T,pretty = T)
write_json(tl , 'my_res.json', auto_unbox = T, pretty=T)

back_to_list <- fromJSON('my_res.json')
