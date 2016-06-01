best <- function(state, outcome) {
        
        ## Read outcome data
        m <- read.csv("outcome-of-care-measures.csv",na.strings="Not Available",
        stringsAsFactors = FALSE)
        
        ## Check that state and outcome are valid
        a <- (state %in% m[,7])
        if (!a) stop("invalid state")
        if (outcome == "heart attack") 
                colid <- 11
        else if (outcome == "heart failure") 
                colid <- 17
        else if (outcome == "pneumonia")
                colid <- 23
        else
                stop("invalid outcome")

        ## Return hospital in that state with lowest 30-day death rate
        x <- m[,2][m$State == state]
        y <- m[,colid][m$State == state]
        d <- x[order(y,x)][1]
        d
}