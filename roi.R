Sys.setenv(ROI_LOAD_PLUGINS = "FALSE")
library(ROI)
library(ROI.plugin.glpk)
library(ROI.plugin.qpoases)
library(ROI.plugin.ecos)
library(ROI.plugin.scs)
library(ROI.plugin.alabama)
library(ROI.plugin.lpsolve)

library(dplyr)
library(slam)

y <- head(longley[,1], 5)
x <- as.matrix(head(longley[,-1], 5))

# diagonal bind
dbind <- function(...) {
  .dbind <- function(x, y) {
    A <- simple_triplet_zero_matrix(NROW(x), NCOL(y))
    B <- simple_triplet_zero_matrix(NROW(y), NCOL(x))
    rbind(cbind(x, A), cbind(B, y))
  }
  Reduce(.dbind, list(...))
}

# wrapper to ROI
qp_lasso <- function(x, y, lambda) {
  # MINIMIZE
  m <- NROW(x) # number of rows (observations)
  n <- NCOL(x) # number of columns (features)
  # Q0, a0 defines 2-nd order polynomial
  Q0 <- dbind(simple_triplet_zero_matrix(n), simple_triplet_diag_matrix(1, m), simple_triplet_zero_matrix(n))
  a0 <- c(b = double(n), g = double(m), t = lambda * rep(1, n))
  # definition of objective based on constructed polynomial
  op <- OP(objective = Q_objective(Q = Q0, L = a0))
  
  # SUBJECT TO
  ## y - X %*% beta = gamma  <=>  X %*% beta + gamma = y
  A1 <- cbind(x, simple_triplet_diag_matrix(1, m), simple_triplet_zero_matrix(m, n))
  LC1 <- L_constraint(A1, eq(m), y)
  ##  -t <= beta  <=>  0 <= beta + t
  A2 <- cbind(simple_triplet_diag_matrix(1, n), simple_triplet_zero_matrix(n, m), simple_triplet_diag_matrix(1, n))
  LC2 <- L_constraint(A2, geq(n), double(n))
  ##   beta <= t  <=>  beta - t <= 0
  A3 <- cbind(simple_triplet_diag_matrix(1, n), simple_triplet_zero_matrix(n, m), simple_triplet_diag_matrix(-1, n))
  LC3 <- L_constraint(A3, leq(n), double(n))
  constraints(op) <- rbind(LC1, LC2, LC3)
  
  # WITH
  bounds(op) <- V_bound(ld = -Inf, nobj = ncol(Q0))
  
  op
}

op <- qp_lasso(x, y, 0)
(qp0 <- ROI_solve(op, "qpoases"))

cbind(round(coef(lm.fit(x, y)), 3), round(head(solution(qp0), ncol(x)), 3))


xy_from_op <- function(op) {
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
}

