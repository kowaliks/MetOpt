data(diabetes)
attach(diabetes)
x <- diabetes$x2
y <- diabetes$y


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
