################################################################################
#
# Exercise 1: Datasets required for an S3M analysis
# 
# This exercise describes the datasets needed for an S3M analysis and reviews 
# basic data structure knowledge relevant to R related to the types of datasets 
# required for an S3M analysis.
#
# Example datasets for all the exercises can be found in the folder `data`.
#
# Following is the starter code to look into these datasets.
#
################################################################################

################################################################################
#
# Dataset 1: Dataset collected using an S3M survey
#
# First dataset required is obvious. This will be the dataset that has been
# collected using an S3M design.
#
# In the `data` folder, there are two examples of this dataset:
#   * icfiData.csv - IYCF data collected in the Niger National S3M Survey in
#     2013
#   * coverageData.csv - SAM coverage data collected in the Niger National S3M
#     Survey in 2013
#
################################################################################

# Read both datasets -----------------------------------------------------------

icfiData <- read.csv("data/icfiData.csv")
coverageData <- read.csv("data/coverageData.csv")

#
# Review the datasetes above and reflect on the following questions:
#
# 1. What data structure and data components do you notice in each of the 
#    dataset?

## Count the number of columns and add report it

# rows and columns for ICFI dataset
print(paste0("There are ", ncol(icfiData), " columns in the ICFI dataset."))
print(paste0("There are ", nrow(icfiData), " rows in the ICFI dataset."))

# rows and columns for SAM coverage dataset
print(paste0("There are ", ncol(coverageData), " columns in the coverage dataset."))
print(paste0("There are ", nrow(coverageData), " rows in the coverage dataset."))

## Show the structure of the dataset 
str(icfiData)                  ## very neat and important function to remember
dplyr::glimpse(icfiData)       ## similar to str but from the dplyr package

str(coverageData)              ## very neat and important function to remember
dplyr::glimpse(coverageData)   ## similar to str but from the dplyr package

# 2. What data structure and components are common in each of the dataset?

## - Both are data.frames; tabular;
## - they both have GPS data; both have spid
names(coverageData)[names(coverageData) %in% names(icfiData)]  ## indexing

# 3. Would you consider these datasets as spatial datasets?
## No and yes. No because it is technically not a spatial dataset from an R
## perspective. But Yes because there is spatial data (GPS coordinates)
## included in the dataset.


################################################################################
#
# Dataset 2: Dataset of Niger boundaries
#
# Second dataset required is for a map of Niger boundaries
#
# In the `data` folder, there is the dataset of the Niger boundaries in 
# ESRI Shapefile format and is found in the folder named `NER_adm`.
#
################################################################################

# Read Niger boundaries dataset ------------------------------------------------

# Load libraries
library(rgdal)
library(rgeos)
library(raster)

# Read each administrative boundary maps for Niger
niger0 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm0")
niger1 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm1")
niger2 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm2")
niger3 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm3")

#
# Review the datasetes above and reflect on the following questions:
#
# 1. What data structure and data components do you notice in each of the 
#    datasets?

## See the structure of the spatial objects
str(niger0)
str(niger1)
str(niger2)
str(niger3)

## Access the slots of each spatial object
niger0@data
niger0@polygons
niger0@plotOrder
niger0@bbox
niger0@proj4string

## Access the data.frame in the data slot
niger0$NAME_ENGLI
niger0[["NAME_ENGLI"]]

## Access the names of the variables in the data.frame in the data slot
names(niger0)


# 2. What data structure and components are common in each of the dataset?

##
## Different in:
##    1. number of polygons in the dataset - niger0 has 1, niger1 has more
##    2. data.frame associated with spatial dataset will have some similar
##       columns/variables but also have unique/different variables/columns
## Similar in:
##    1. they all have the same CRS projection 
##


# 3. Would you consider these datasets as spatial datasets? - YES
