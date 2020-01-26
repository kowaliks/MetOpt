datasetSize = 1000000 
# input data
x1 = rnorm(datasetSize,0,1)
x2 = rnorm(datasetSize,2,3)
x3 = rnorm(datasetSize,1,1)
x4 = rnorm(datasetSize,0,2)
x5 = rnorm(datasetSize,4,5)
x6 = rnorm(datasetSize,0,1)
x7 = rnorm(datasetSize,2,1)
x8 = rnorm(datasetSize,0,4)

expected_beta = c(0.5,5,-3,0,1,3,0,2,-2)
y =  expected_beta[1] + 
  expected_beta[2]*x1 +
  expected_beta[3]*x2 +
  expected_beta[4]*x3 +
  expected_beta[5]*x4 +
  expected_beta[6]*x5 +
  expected_beta[7]*x6 +
  expected_beta[8]*x7 +
  expected_beta[9]*x8 +
  rnorm(datasetSize,0,1) # random error

x = cbind(x1,x2,x3,x4,x5,x6,x7,x8)
