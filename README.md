# Coral Reef Stressor Interactions

[![](https://zenodo.org/badge/540081570.svg)](https://zenodo.org/badge/latestdoi/540081570)

Data and R code for a manuscript currently in review that investigates interactions between local human disturbance and past exposure to heat stress in the central Pacific Islands.

Included in this repository are:

-   **Raw data (includes the percent cover data by taxa and environmental variables; data.RData):**

1.  data_coral contains the relative abundance for all coral taxa

2.  data_cover contains the relative abundance for all benthic taxa and categories

3.  data_env contains all environmental variables

4.  data_ma contains the relative abundance for all macroalgae taxa

------------------------------------------------------------------------

-   **R scripts for analyses:**

1.  1_envirovars_correlation.R: estimating the correlation of environmental variables.

2.  2_PCA_unscaled.R: unscaled Principle Component Analyses for all benthic taxa, just coral, and just macroalgae taxa, and to create biplots of the results.

3.  3_HCPC.R: Hierarchical Clustering on Principle Components. This analysis uses the first three principal components of a scaled PCA that includes 99% of the benthic taxa in the dataset.

4.  4_ANOSIMs & BIOENV.R: Nonparametric multivariate analyses following Clarke 1993. ANOSIMs provide estimates of how much the benthic communities differ across groups, while BIOENV finds the best subset of environmental variables that have maximum correlation with community dissimilarities.

5.  5_PERMANOVA.R: Permutational Analysis of Variance to estimate amount that variables of interest contribute to differences in (1) all benthic cover, (2) live coral percent cover, and (3) macroalgae percent cover.

6.  6_LinearRegressions.R: Linear regressions of key taxa and functional groups by cvSST, NDVI, and the interaction between cvSST and NDVI. Loops through a list of taxa and outputs regression results and diagnostic plots.

7.  7_TobitRegressions.R: Left-censored tobit regression models of key taxa and functional group by cvSST, NDVI, and the interaction between cvSST and NDVI. Loops through a list of taxa and outputs regression results.
