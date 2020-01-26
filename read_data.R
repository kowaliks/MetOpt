# https://archive.ics.uci.edu/ml/datasets.php?format=&task=reg&att=&area=&numAtt=&numIns=&type=&sort=instDown&view=table

# https://archive.ics.uci.edu/ml/datasets/YearPredictionMSD#
music_df <- read.csv("data/YearPredictionMSD.txt", header=FALSE)
music_matrix <- as.matrix(music_df)
y <- music_matrix[,1]
x <- music_matrix[,-1]
