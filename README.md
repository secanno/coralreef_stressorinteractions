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

2.  2_HCPC.R: Hierarchical Clustering on Principle Components. This analysis uses the first three principal components of a scaled PCA that includes 99% of the benthic taxa in the dataset.

3.  3_BIOENV.R: Analysis to identify environmental variables that have maximum correlation with community dissimilarities.

4.  4_PERMANOVA.R: Permutational Analysis of Variance to estimate amount that variables of interest contribute to differences in (1) all benthic cover, (2) live coral percent cover, and (3) macroalgae percent cover.

5.  5_LinearRegressions.R: Linear regressions of key taxa and functional groups by cvSST, NDVI, and the interaction between cvSST and NDVI. Loops through a list of taxa and outputs regression results and diagnostic plots.

6.  6_TobitRegressions.R: Left-censored tobit regression models of key taxa and functional group by cvSST, NDVI, and the interaction between cvSST and NDVI. Loops through a list of taxa and outputs regression results.
