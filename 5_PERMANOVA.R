#Permutational Analysis of Variance 

library(grid)
library(vegan)

#load data
load(url("http://github.com/secanno/coralreef_stressorinteractions/blob/main/data.RData?raw=true"))

#Check to ensure samples in data_env are in the same order as in data_cover
data_env <- data_env[rownames(data_cover),]

#filter out samples taxas that have zero entries
data_cover <- subset(data_cover, rowSums(data_cover)!=0)
data_coral <- subset(data_coral, rowSums(data_coral)!=0)
data_ma <- subset(data_ma, rowSums(data_ma)!=0)

#all taxa
x <- adonis2(data_cover ~ NDVI_inv + cvSST + NDVI_inv*cvSST, data = data_env, permutations = 9999, by = NULL)
x_full <- adonis2(data_cover ~ NDVI_inv + cvSST + NDVI_inv*cvSST, data = data_env, permutations = 9999)
x
x_full


#hard coral taxa
x <- adonis2(data_coral ~ NDVI_inv + cvSST + NDVI_inv*cvSST, data = data_env, permutations = 9999, by = NULL)
x_full <- adonis2(data_coral ~ NDVI_inv + cvSST + NDVI_inv*cvSST, data = data_env, permutations = 9999)
x
x_full

#macroalgae taxa
x <- adonis2(data_ma ~ NDVI_inv + cvSST + NDVI_inv*cvSST, data = data_env, permutations = 9999, by = NULL)
x_full <- adonis2(data_ma ~ NDVI_inv + cvSST + NDVI_inv*cvSST, data = data_env, permutations = 9999)
x
x_full

