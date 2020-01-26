sampleSize = 100000
parameterSize = 1000
relevantParameters = 5
# input data
set.seed(42)
x <-data.frame(row.names=1:sampleSize)
for (i in 1:parameterSize){
  x[i] = rnorm(sampleSize,sample(1:5,1),sample(1:5,1))
}

expected_beta = c(1,2,3,4,5,6, integer(parameterSize - relevantParameters))
set.seed(1337)
y =  expected_beta[1] + rnorm(datasetSize,0,5) # random error
for(i in 1:parameterSize)
  y = y + expected_beta[i+1]*x[i]  
  