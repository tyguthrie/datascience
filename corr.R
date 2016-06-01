corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        
        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        
        ## Return a numeric vector of correlations
        ## NOTE: Do not round the result!
        
        x <- complete(directory)
        id <- x$id[x$nobs > threshold] ## vector of ids meeting threshold

        z <- numeric()
        if(length(id) > 0)
                for (i in 1:length(id)){
                        fp = paste(directory,"/",sprintf("%03s",id[i]),".csv",sep="")
                        filedata <- read.csv(fp,header = TRUE)
                        s <- filedata["sulfate"]
                        n <- filedata["nitrate"]
                        c <- cor(n,s, use = "complete.obs")
                        z <- c(z,c)
                }
        z
}