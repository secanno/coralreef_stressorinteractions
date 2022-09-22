#selecting environmental variables based on their correlation
#see README.md for more information

#load required packages
library(Hmisc)
library(corrplot)
library(dplyr)

#load data
load(url("http://github.com/secanno/coralreef_stressorinteractions/blob/main/data.RData?raw=true"))

#select numeric variables
data <- select(data_env, "Latitude":"NDVI_inv")
  
#change environmental data to matrix
data <- as.matrix(data)

#run correlation analysis
results <- rcorr(data)

#run Bonferroni correction to account for multiple comparisons
results_padj <- p.adjust(results$P ,method="bonferroni")

#draw plot of coefficients
corrplot(data_sign$r, type="upper", order="hclust", p.mat = data_sign$P, sig.level = 0.05, insig = "blank", tl.cex=0.8)


