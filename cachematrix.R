## The following functions take advantage of R scoping rules to cache
## the values returned by the function, specifically the matrix inverse
## so that it does not have to be repeatedly calculated every time the 
## function is called.

## example output where "mymatrix" is a matrix
# > x <- makeCacheMatrix(mymatrix)
# > x$get()
# [,1] [,2] [,3]
# [1,]    1    0    1
# [2,]    0    0    1
# [3,]    1    1    1
# > inv <- cacheSolve(x)
# setting cached data
# > inv <- cacheSolve(x)
# getting cached data
# > inv
# [,1] [,2] [,3]
# [1,]    1   -1    0
# [2,]   -1    0    1
# [3,]    0    1    0

## makeCacheMatrix takes a matrix as input and performs one of several
## subfunctions on the matrix, which are returned as a list of functions.
## These are:
## 1.  set the value of the matrix with set
## 2.  get the value of the matrix with get
## 3.  set the inverse of the matrix with setsolve
## 4.  get the inverse of the matrix with getsolve

makeCacheMatrix <- function(x = matrix()) {
        ## create initial cache object and set as null
        s <- NULL 

        ## set function sets new cached matrix into PARENT environment
        set <- function(y) { 
                x <<- y    ## assign the matrix to x in PARENT environment
                s <<- NULL ## assign NULL to m in PARENT environment
        }
      
        ## get function retrieves the value of x (the original matrix)
        get <- function() x
        
        ## setsolve function caches the solved matrix to the PARENT environment
        setsolve <- function(solvedmatrix) {
                s <<- solvedmatrix
                message("setting cached data")
        }
        
        ## getsolve function retrievs the value of m (the solved matrix)
        getsolve <- function() s
        
        ## the returned value is a list of functions
        list(set = set, get = get,
             setsolve = setsolve,
             getsolve = getsolve)
}

## cacheSolve takes a matrix as input and returns the inverse of the matrix.
## First it checks if the matrix inverse has already been computed. If so, it 
## gets the value from the cache and skips the computation.

cacheSolve <- function(x, ...) {
        m <- x$getsolve() ## retrieve cached value
        if(!is.null(m)) {
                message("getting cached data")
                return(m) ## if not null, just return value, do not continue
        }
        ## if its not null, it need to be calculated and then loaded into
        ## the cache, in addition to being returned from this function
        data <- x$get()
        m <- solve(data, ...)
        x$setsolve(m)
        m
}
