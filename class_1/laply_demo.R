# lapply demo 
my_list <- c(1:10)
my_list^2

squred_numbers <- NULL
for (i in 1:10) {
  squred_numbers <- c(squred_numbers, i^2)
}

my_demo_fun <- function(x) {
  return(x^2)
}

# return with list of element
lapply(my_list, my_demo_fun)

# return with a vector if the function retun with numeric value
sapply(my_list, my_demo_fun)

# return with a named list if the function returns with string
sapply(letters, function(x) {
  return(paste0('#', toupper(x), '#'))
})


# return with a character vector, unlist is important function
unlist(lapply(my_list, my_demo_fun))




unlist(
  lapply(letters, function(x){
    return(paste0('the input letter is: ', toupper(x)))
  })
)



# with multiple arguments
# https://stackoverflow.com/questions/14427253/passing-several-arguments-to-fun-of-lapply-and-others-apply
my_list <- c(1:10)

my_demo_fun <- function(x,y) {
  return((x+y)^2)
}

unlist(lapply(my_list, my_demo_fun, y=2))