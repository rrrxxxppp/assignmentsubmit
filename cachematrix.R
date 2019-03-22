## this program is to calculate the inverse of a matrix and store it in cache.
## if there is a inverse already been stored, it gets the inverse directly from the cache.

## makeCacheMatrix allows users to set a matrix and its inverse, and stores the values in the cache with 'setMatrix' and 'setInverse'functions.
## users are able to get the matrix and inverse using 'getMatrix' and 'getInverse' functions.

makeCacheMatrix <- function(x = matrix()) {
  inver<<-NULL
  setMatrix<-function(y){
    x<<-y
    inver<<-NULL
  }
  getMatrix<-function()
    x
  setInverse<-function(solve){
    inver<<-solve
  }
  getInverse<-function()
    inver
  list(setMatrix= setMatrix, getMatrix= getMatrix,
       setInverse = setInverse,
       getInverse = getInverse) 
}


## cacheSolve checks if there is a value for 'inver' in the cache,
## if 'inver=NULL' is FALSE, it returns the value of 'inver' with 'getInverse' function.
## if 'inver=NULL' is TRUE, it calculates the inverse of the matrix(from 'getMatrix')  and return the inverse.

cacheSolve <- function(x, ...) {
  inver<-getInverse() 
  if(!is.null(inver)){
    message("getting cached data...")
    inver
  }
  else{
    theMatrix<-getMatrix()
    inver<-solve(theMatrix,...)
    setInverse(inver)
    inver
  }
}
