sampleSize = 10000
parameterSize = 1000
relevantParameters = 5
# input data
set.seed(42)
x <-data.frame(row.names=1:sampleSize)
for (i in 1:parameterSize){
  x[i] = rnorm(sampleSize,sample(1:5,1),sample(1:5,1))
}
x <-  as.matrix(x)
expected_beta = c(1,2,3,4,5,6, integer(parameterSize - relevantParameters))
set.seed(1337)
y =  expected_beta[1] + rnorm(sampleSize,0,5) # random error
for(i in 1:relevantParameters)
  y = y + expected_beta[i+1]*x[1:sampleSize,i]  


lambda <- 0
op <- qp_lasso(x, y, lambda)

start_time <- Sys.time()
lars_solved <- ROI_solve(op, "lars")
stop_time <- Sys.time()
lars_duration <- stop_time - start_time

start_time <- Sys.time()
qpoases_solved <- ROI_solve(op, "qpoases")
stop_time <- Sys.time()
qpoases_duration <- stop_time - start_time
