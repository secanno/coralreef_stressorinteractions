library(dplyr)
library(tidyr)
library(censReg)
library(utils)

#load data
load(url("http://github.com/secanno/coralreef_stressorinteractions/blob/main/data.RData?raw=true"))


#add CVSST and NDVI to data_cover 
data_cover$cvSST <- data_env$cvSST[match(row.names(data_env), row.names(data_cover))]
head(data_cover)  

data_cover$NDVI <- data_env$NDVI_inv[match(row.names(data_env), row.names(data_cover))]  
head(data_cover)

#For Taxa level analysis, create list of key genera/taxa for filtering
keygenera <- c("ACR", "BG", "CCA", "CRL", "FAV", "HEL", "HA", "HYP", "LPA", "MIC", "ISO", "POC", "PRM", 
               "PRS", "SPG", "TRF")

#convert data to long format
data_cover$Site <- row.names(data_cover) #to preserve site info
data_cover <- pivot_longer(data_cover, cols = "ACR":"OTH", names_to = "Taxa", values_to = "RelAbund")
data_cover <- as.data.frame(data_cover)
head(data_cover)

#convert relabund to percent
data_cover$Percent <- data_cover$RelAbund*100

#check for zero-inflation of the data
100*sum(data_cover$RelAbund == 0)/nrow(data_cover)
#63% of data = 0, but this is before filtering for key genera

#use standard tobit model (left censored @ 0) via censReg package (Henningsen)

#scale CVSST values for ease of interpretation (NDVI values already scaled)
data <- data_cover %>%
  dplyr::mutate(cvSST_scaled = scale(cvSST))


#fit a constant scale model (tobit model with logistic distribution) for each of the key genera and output results in txt file
for (code.i in keygenera) {
  x <- subset(data, Taxa == code.i)
  tryCatch({
    mod <- censReg(Percent ~ NDVI + cvSST_scaled + NDVI*cvSST_scaled, data = x)
    mod0 <- update(mod, .~1)
    mcfad <- 1- as.vector(logLik(mod)/logLik(mod0))
  }, error = function(e){cat('Error :', conditionMessage(e), code.i, '\n')})
  capture.output(summary(mod), "mcfadden R2:", mcfad, file = paste('results_tobitregression_', code.i, '.txt'))
  capture.output(confint(mod, level = 0.95), file = paste('results_tobitregression_confidenceintervals_', code.i, '_scaled.txt'))
}



#write loop to assign "functional group" by code
data$FuncGroup <- "" #create blank column

for (i in 1:length(data$Site)) {
  if (grepl('^ACR$', data$Taxa[i]) == TRUE) { #^ denotes beginning of text string, while $ marks the end of the text string
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^MNT$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^ISO$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^AST$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^FUN$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^CTE$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HRP$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HLM$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HEL$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^POC$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^SER$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^STY$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^FAV$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^CAU$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^LEO$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^COE$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^GAR$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^LEP$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PAC$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PAV$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PBR$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PRM$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PRS$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^POR$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PLE$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^GAL$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HYD$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^MER$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^LOB$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^ECY$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^OXY$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^COS$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^PSA$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^TUR$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^HCO$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'LiveCoral' }
  if (grepl('^SCO$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'SoftCoral' }
  if (grepl('^SPG$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Sponges' }
  if (grepl('^ZOA$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^CRL$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Corallimorphs' }
  if (grepl('^GOR$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^INV$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^S$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Sand' }
  if (grepl('^R$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Rubble' }
  if (grepl('^MA$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^HA$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^ASP$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^AUD$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^TRB$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^SCH$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Cyanobacteria' }
  if (grepl('^MIC$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^LPA$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^LIT$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^DIC$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^DCT$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^BRY$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'OtherInverts' }
  if (grepl('^HYP$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^PAD$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^CCA$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'CCA' }
  if (grepl('^TRF$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'TurfAlgae' }
  if (grepl('^BG$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Cyanobacteria' }
  if (grepl('^HER$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Macroalgae' }
  if (grepl('^OTH$', data$Taxa[i]) == TRUE) {
    data$FuncGroup[i] <- 'Other' }
}


unique(data$FuncGroup)

#create vector for key groups
keygroups <- c("LiveCoral", "Macroalgae")


#group data by func group
data_grouped <- data %>%
  group_by(Site, FuncGroup) %>% #sum percent of live coral taxa within each site
  dplyr::summarize(Percent = sum(Percent),
                   NDVI = NDVI,
                   cvSST_scaled = cvSST_scaled) %>%
  distinct()
head(data_grouped)


#loop to fit a standard tobit model for each of the key genera and output results in txt file
for (code.i in keygroups) {
  x <- subset(data_grouped, FuncGroup == code.i)
  tryCatch({
    mod <- censReg(Percent ~ NDVI + cvSST_scaled + NDVI*cvSST_scaled, data = x)
    mod0 <- update(mod, .~1)
    mcfad <- 1- as.vector(logLik(mod)/logLik(mod0))
  }, error = function(e){cat('Error :', conditionMessage(e), code.i, '\n')})
  capture.output(summary(mod), "mcfadden R2:", mcfad, file = paste('results_tobitregression_', code.i, '.txt'))
  capture.output(confint(mod, level = 0.95), file = paste('results_tobitregression_confidenceintervals_', code.i, '_scaled.txt'))
}

