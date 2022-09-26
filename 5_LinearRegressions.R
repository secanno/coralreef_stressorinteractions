library(dplyr)
library(cowplot)
library(tidyr)
library(utils)
library(scales)
library(car)

#load data
load(url("http://github.com/secanno/coralreef_stressorinteractions/blob/main/data.RData?raw=true"))


#add CVSST and NDVI to data_cover 
data_cover$cvSST <- data_env$cvSST[match(row.names(data_env), row.names(data_cover))]
head(data_cover)  

data_cover$NDVI <- data_env$NDVI_inv[match(row.names(data_env), row.names(data_cover))]  
head(data_cover)

#For genus level analysis, create list of key genera/taxa for filtering
keygenera <- c("ACR", "BG", "CCA", "CRL", "FAV", "HEL", "HA", "HYP", "LPA", "MIC", "ISO", "POC", "PRM", 
               "PRS", "SPG", "TRF")

#convert data to long format
data_cover$Site <- row.names(data_cover) #to preserve site info
data_cover <- pivot_longer(data_cover, cols = "ACR":"OTH", names_to = "Taxa", values_to = "RelAbund")
data_cover <- as.data.frame(data_cover)
head(data_cover)

#convert relabund to percent
data_cover$Percent <- data_cover$RelAbund*100

#scale the cvSST for ease of interpreting results
data_cover <- data_cover %>%
  dplyr::mutate(Percent = RelAbund * 100,
                cvSST_scaled = scale(cvSST))

#run model and test assumptions for all codes listed in the key genera vector
for (code.i in keygenera) {
  x <- subset(data_cover, Taxa == code.i)
  mod <- lm(Percent ~ NDVI + cvSST_scaled + NDVI*cvSST_scaled, data = x)
  plot(mod, 2)
  ggsave2(filename = paste("qqplot_percent_", code.i, ".png"))
  plot(mod, 1)
  ggsave2(filename = paste("residualsvsfitted_", code.i, ".png"))
  plot(mod, 3)
  ggsave2(filename = paste("scale_location_", code.i, ".png"))
  capture.output(summary(mod), file = paste("results_simpleregression_", code.i, "_fullequation.txt"))
  capture.output(confint(mod, level = 0.95, file = paste("results_simpleregression_confidenceintervals_", code.i, ".txt")))
}


####
#combine categories into key taxa for further analysis

#write loop to assign "functional group" by code
data_cover$FuncGroup <- "" #create blank column

for (i in 1:length(data_cover$Site)) {
  if (grepl('^ACR$', data_cover$Taxa[i]) == TRUE) { #^ denotes beginning of text string, while $ marks the end of the text string
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^MNT$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^ISO$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^AST$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^FUN$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^CTE$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HRP$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HLM$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HEL$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^POC$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^SER$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^STY$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^FAV$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^CAU$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^LEO$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^COE$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^GAR$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^LEP$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PAC$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PAV$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PBR$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PRM$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PRS$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^POR$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PLE$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^GAL$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HYD$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^MER$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^LOB$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^ECY$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^OXY$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^COS$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PSA$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^TUR$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HCO$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^SCO$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'SoftCoral' }
  if (grepl('^SPG$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Sponges' }
  if (grepl('^ZOA$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^CRL$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Corallimorphs' }
  if (grepl('^GOR$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^INV$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^S$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Sand' }
  if (grepl('^R$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Rubble' }
  if (grepl('^MA$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^HA$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^ASP$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^AUD$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^TRB$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^SCH$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Cyanobacteria' }
  if (grepl('^MIC$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^LPA$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^LIT$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^DIC$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^DCT$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^BRY$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^HYP$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^PAD$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^CCA$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'CCA' }
  if (grepl('^TRF$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'TurfAlgae' }
  if (grepl('^BG$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Cyanobacteria' }
  if (grepl('^HER$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^OTH$', data_cover$Taxa[i]) == TRUE) {
    data_cover$FuncGroup[i] <- 'Other' }
}


unique(data_cover$FuncGroup)

#create vector for key groups
keygroups <- c("LiveCoral", "Macroalgae")
head(data_cover)

#group data by func group
data_grouped <- data_cover %>%
  group_by(Site, FuncGroup) %>% #sum percent of live coral taxa within each site
  dplyr::summarize(Percent = sum(Percent),
                   NDVI = NDVI,
                   cvSST_scaled = cvSST_scaled) %>%
  distinct()
head(data_grouped)

#run regressions and output results to .txt and .png files
for (code.i in keygroups) {
  x <- subset(data_grouped, FuncGroup == code.i)
  mod <- lm(Percent ~ NDVI + cvSST_scaled + NDVI*cvSST_scaled, data = x)
  plot(mod, 2)
  ggsave2(filename = paste("qqplot_percent_", code.i, ".png"))
  plot(mod, 1)
  ggsave2(filename = paste("residualsvsfitted_", code.i, ".png"))
  plot(mod, 3)
  ggsave2(filename = paste("scale_location_", code.i, ".png"))
  capture.output(summary(mod), file = paste("results_simpleregression_", code.i, "_fullequation.txt"))
  capture.output(confint(mod, level = 0.95, file = paste("results_simpleregression_confidenceintervals_", code.i, ".txt")))
}


