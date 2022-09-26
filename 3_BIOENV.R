#Analysis of Similarities following Clarke 1993

library(grid)
library(vegan)
library(dplyr)
library(stringr)

#load data
load(url("http://github.com/secanno/coralreef_stressorinteractions/blob/main/data.RData?raw=true"))

#set site names as rownames 
row.names(data_env) <- data_env$Site
row.names(data_cover) <- data_cover$Site
row.names(data_coral) <- data_coral$Site
row.names(data_ma) <- data_ma$Site

#Check to ensure samples in data_env are in the same order as in data_cover
data_env <- data_env[rownames(data_cover),]

#delete sites from dataframes
data_cover$Site <- NULL
data_coral$Site <- NULL
data_env$Site <- NULL
data_ma$Site <- NULL

#filter out taxa that have zero entries
data_cover <- subset(data_cover, rowSums(data_cover)!=0)
data_ma <- subset(data_ma, rowSums(data_cover)!=0)
data_coral <- subset(data_coral, rowSums(data_cover)!=0)

#create vectors for Atoll and Country 
Atoll <- data_env$Atoll
Country <- data_env$Country

#convert variables for atoll and country to numeric variables in data_env df
data_env <- data.frame(lapply(data_env, function(x) {
  gsub("Arno", "1", x)
}))
data_env <- data.frame(lapply(data_env, function(x) {
  gsub("Majuro", "2", x)
}))
data_env <- data.frame(lapply(data_env, function(x) {
  gsub("Abaiang", "3", x)
}))
data_env <- data.frame(lapply(data_env, function(x) {
  gsub("Tarawa", "4", x)
}))
data_env <- data.frame(lapply(data_env, function(x) {
  gsub("RMI", "1", x)
}))
data_env <- data.frame(lapply(data_env, function(x) {
  gsub("KBT", "2", x)
}))

#make sure the replacement worked
unique(data_env$Atoll)
unique(data_env$Country)

#check to make sure all columns are quantitative
str(data_env)

#change each column to numeric
data_env <- lapply(data_env, as.numeric)
data_env <- as.data.frame(data_env)
str(data_env)



#########################################
#BIOENV analyses

head(data_env)
data_env <- select(data_env, NDVI_inv, WWE, mean_par, mean_chla, cvSST) #variables selected via correlation analysis 
head(data_env)

#run bioenv analysis for all taxa 
mod <- bioenv(data_cover, data_env)
mod
summary(mod)
z <- bioenvdist(mod, which = 'best')
z

#rerun analyses for just coral taxa 


#run bioenv analysis for all taxa 
mod <- bioenv(data_coral, data_env)
mod
summary(mod)
z <- bioenvdist(mod, which = 'best')
z


#run bioenv analysis for all taxa and write results to a text file
mod <- bioenv(data_ma, data_env)
mod
summary(mod)
z <- bioenvdist(mod, which = 'best')
z

