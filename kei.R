# add this code as an R script then run the function kei(cases)
# where cases is the number of cases, p is the population,
# and s is the sample. Defaults are 150,7,4 if you just
# want to run kei() without arguments

kei <- function(cases=150, p=7, s=4) {
        k <-  matrix(nrow=0,ncol=4)
        for (x in 1:cases) k <- rbind(k,sample(1:p,s))
        k
}