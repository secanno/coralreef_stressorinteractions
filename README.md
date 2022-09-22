# Coral Reef Stressor Interactions

Data and R code for a manuscript currently in review that investigates differences in benthic communities across gradients of local human disturbance and exposure to past heat stress in the central Pacific Islands.

Included in this repository are:

-   **Raw data (includes the percent cover data by taxa and environmental variables; data.RData):**

1.  data_coral contains the relative abundance for all coral taxa

2.  data_cover contains the relative abundance for all benthic taxa and categories

3.  data_env contains all environmental variables

4.  data_ma contains the relative abundance for all macroalgae taxa  

-   **R scripts for analyses:**

1.  1_envirovars_correlation.R contains the code used to estimate the correlation of environmental variables.

2.  2_PCA_unscaled.R contains code to run unscaled Principle Component Analyses for all benthic taxa, just coral, and just macroalgae taxa, and to create biplots of the results.

3.  3_HCPC.R is the script for running Hierarchical Clustering on Principle Components. This analysis uses the first three principal components of a scaled PCA that includes 99% of the benthic taxa in the dataset.

4.  4_ANOSIMs & BIOENV.R includes code for nonparametric multivariate analyses following Clarke 1993. ANOSIMs provide estimates of how much the benthic communities differ across groups, while BIOENV finds the best subset of environmental variables that have maximum correlation with community dissimilarities.

5.  
