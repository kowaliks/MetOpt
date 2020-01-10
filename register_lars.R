Sys.setenv(ROI_LOAD_PLUGINS = "FALSE")
library(ROI)

library(dplyr)
library(slam)
library(lars)
library(expm)


lars_signature <- ROI_plugin_make_signature(objective = "Q", constraints = "L",
                                            types = c("C"), bounds = c("X"), maximum = c(FALSE))

ROI_plugin_add_status_code_to_db("lars", 0L, "OPT", "Solution is optimal", roi_code = 0L)


# ROI wrapper on lars
xyl_from_op <- function(op) {
  constraints_matrix <- op$constraints$L
  count_cols_nonzero_values <- table(constraints_matrix$j)
  gamma_cols <- (as.data.frame(count_cols_nonzero_values) %>% filter(Freq == 1))$Var1 #cols with one value
  
  m <- length(gamma_cols)
  n <- (NCOL(constraints_matrix) - m)/2
  
  #if(constraints_matrix[1][gamma_cols[1]] != 1) {
  #  stop("unsupported problem representation")
  #}
  
  x <- as.matrix(constraints_matrix)[1:m, 1:n]
  y <- op$constraints$rhs[1:m]
  
  lambda <- op$objective$L[m+2*n]
  
  list(x, y, lambda)
}

calc_optimum <- function(x, y, lambda, b) {
  1/2 * norm(y - x %*% b, "2") ^ 2 + lambda * norm(b, "1")
}

# solver method for ROI
lars_solve_op <- function(op, control) {
  xyl <- xyl_from_op(op)
  x <- xyl[[1]]
  y <- xyl[[2]]
  lambda <- xyl[[3]]
  
  out <- lars(x, y, normalize=FALSE, intercept=FALSE, type="lasso")
  b <- coef(out, s=lambda, mode="lambda")
  res <- ROI_plugin_canonicalize_solution(solution = b, optimum = calc_optimum(x, y, lambda, as.matrix(b)),
                                          status = 0L, solver = "lars",
                                          message = out)
  res
}

ROI_plugin_register_solver_method(lars_signature, "lars", lars_solve_op)
