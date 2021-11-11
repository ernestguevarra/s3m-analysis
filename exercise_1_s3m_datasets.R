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
# 2. What data structure and components are common in each of the dataset?
# 3. Would you consider these datasets as spatial datasets?
#

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
# 2. What data structure and components are common in each of the dataset?
# 3. Would you consider these datasets as spatial datasets?
#