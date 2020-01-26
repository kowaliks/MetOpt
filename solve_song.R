# https://archive.ics.uci.edu/ml/datasets.php?format=&task=reg&att=&area=&numAtt=&numIns=&type=&sort=instDown&view=table

# https://archive.ics.uci.edu/ml/datasets/YearPredictionMSD#
music_df <- read.csv("data/YearPredictionMSD.txt", header=FALSE)
music_matrix <- as.matrix(music_df)
y <- music_matrix[,1]
x <- music_matrix[,-1]


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
