rankall <- function(outcome, num = "best") {
        ## Read outcome data
        m <- read.csv("outcome-of-care-measures.csv",na.strings="Not Available",
                      stringsAsFactors = FALSE)
        
        ## Check that outcome is valid
        if (outcome == "heart attack") 
                colid <- 11
        else if (outcome == "heart failure") 
                colid <- 17
        else if (outcome == "pneumonia")
                colid <- 23
        else
                stop("invalid outcome")
        
        ## For each state, find the hospital of the given rank
        hosp <- character()
        states <- character()
        for (s in unique(m$State)[order(unique(m$State))]){
                x <- m[,2][m$State == s]
                y <- m[,colid][m$State == s]
                r <- x[order(y,x,na.last=NA)]
                n <- num
                if (num == "best") n <- 1
                if (num == "worst") n <- length(r)
                hosp <- c(hosp,r[n])
                states <- c(states,s)
        }

        ## Return a data frame with the hospital names and state name
        df <- data.frame(hospital=hosp,state=states)
        df
}