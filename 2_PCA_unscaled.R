#Principle Component Analysis of percent cover data to visualize similarities or differences in benthic communities

#load required packages
library(vegan)
library(devtools)
library(ggbiplot) #see https://github.com/vqv/ggbiplot

#load data
load(url("http://github.com/secanno/coralreef_stressorinteractions/blob/main/data.RData?raw=true"))

##all benthic data##

#add column for atoll from data_env to data_cover by site name
data_cover$Atoll <- data_env$Atoll[match(data_cover$Site, data_env$Site)]

#set site names to act as row names and then remove from dataframe 
rownames(data_cover) <- data_cover$Site
data_cover$Site <- NULL

#create vector containing atoll and remove from df
atoll <- data_cover$Atoll
data_cover$Atoll <- NULL

#filter data to include top 99% of observations (remove everything with <1%)
#to run PCA with all observations (not top 99%) comment this section out. 
colSums(data_cover)
ttl <- sum(colSums(data_cover))
d_top <- data_cover[,colSums(data_cover) > (0.01*ttl)]

#hellinger pre-transformation of data (see Borcard 2011 p. 31)
data.hell <-decostand(d_top, "hellinger") #change to _d_top to data_cover if running PCAs for all taxa (not top 99%)

#remove data with zero variance
data_filtered.hell <- data.hell[,apply(data.hell, 2, var, na.rm = TRUE) != 0]

#run PCA
data.hell.pca <- prcomp(data_filtered.hell, scale = FALSE) 
data.hell.pca
summary(data.hell.pca)

#screeplot showing variance explained by PCs
plot(data.hell.pca)

#create biplot
#Plot PCA
ggbiplot(data.hell.pca,
         groups = atoll, ellipse = TRUE,
         circle = FALSE, labels = NULL, labels.size = 6, varname.size = 3) +
  ggtitle("") +
  theme_bw()

######
#Repeat to create independent plots for macroalgae and hard coral taxa
#####

##for coral cover##

#add column for atoll from data_env to data_coral by site name
data_coral$Atoll <- data_env$Atoll[match(data_coral$Site, data_env$Site)]

#set site names to act as row names and then remove from dataframe 
rownames(data_coral) <- data_coral$Site
data_coral$Site <- NULL

#create vector containing atoll and remove from df
atoll <- data_coral$Atoll
data_coral$Atoll <- NULL

#filter data to include top 99% of observations (remove everything with <1%)
#to run PCA with all observations (not top 99%) comment this section out. 
colSums(data_coral)
ttl <- sum(colSums(data_coral))
d_top <- data_coral[,colSums(data_coral) > (0.01*ttl)]

#hellinger pre-transformation of data (see Borcard 2011 p. 31)
data.hell <-decostand(d_top, "hellinger") #change to _d_top to data_coral if running PCAs for all taxa (not top 99%)

#remove data with zero variance
data_filtered.hell <- data.hell[,apply(data.hell, 2, var, na.rm = TRUE) != 0]

#run PCA
data.hell.pca <- prcomp(data_filtered.hell, scale = FALSE) 
data.hell.pca
summary(data.hell.pca)

#screeplot showing variance explained by PCs
plot(data.hell.pca)

#create biplot
#Plot PCA
ggbiplot(data.hell.pca,
         groups = atoll, ellipse = TRUE,
         circle = FALSE, labels = NULL, labels.size = 6, varname.size = 3) +
  ggtitle("") +
  theme_bw()



##for ma cover##

#add column for atoll from data_env to data_ma by site name
data_ma$Atoll <- data_env$Atoll[match(data_ma$Site, data_env$Site)]

#set site names to act as row names and then remove from dataframe 
rownames(data_ma) <- data_ma$Site
data_ma$Site <- NULL

#create vector containing atoll and remove from df
atoll <- data_ma$Atoll
data_ma$Atoll <- NULL

#filter data to include top 99% of observations (remove everything with <1%)
#to run PCA with all observations (not top 99%) comment this section out. 
colSums(data_ma)
ttl <- sum(colSums(data_ma))
d_top <- data_ma[,colSums(data_ma) > (0.01*ttl)]

#hellinger pre-transformation of data (see Borcard 2011 p. 31)
data.hell <-decostand(d_top, "hellinger") #change to _d_top to data_ma if running PCAs for all taxa (not top 99%)

#remove data with zero variance
data_filtered.hell <- data.hell[,apply(data.hell, 2, var, na.rm = TRUE) != 0]

#run PCA
data.hell.pca <- prcomp(data_filtered.hell, scale = FALSE) 
data.hell.pca
summary(data.hell.pca)

#screeplot showing variance explained by PCs
plot(data.hell.pca)

#create biplot
#Plot PCA
ggbiplot(data.hell.pca,
         groups = atoll, ellipse = TRUE,
         circle = FALSE, labels = NULL, labels.size = 6, varname.size = 3) +
  ggtitle("") +
  theme_bw()

