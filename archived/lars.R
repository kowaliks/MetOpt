library(lars)
library(mlbench)
data(diabetes)
attach(diabetes)
cv.lars(x2,y,max.steps=80)
detach(diabetes)



data(diabetes)
par(mfrow=c(2,2))
attach(diabetes)
object <- lars(x,y)
plot(object)
object2 <- lars(x,y,type="lar")
plot(object2)
object3 <- lars(x,y,type="for") # Can use abbreviations
plot(object3)



y <- longley[,1]
x <- as.matrix(longley[,-1])
object <- lars(x,y,normalize=FALSE,intercept = FALSE,type="lasso")
plot(object)
cv.lars(x,y,max.steps=80)
coef(object, s=1, mode="fraction") 
