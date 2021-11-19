################################################################################
#
# Exercise 2: Preparing S3M data for analysis
# 
# This exercise describes the datasets needed for an S3M analysis in more detail 
# and reviews data handling and management skills in R related to the types of 
# datasets required for an S3M analysis.
#
# Example datasets for all the exercises can be found in the folder `data`.
#
# Following is the starter code to look into these datasets.
#
################################################################################

################################################################################
#
# For this exercise, we will focus on the coverage dataset. Let us read this
# dataset and interrogate it further.
#
################################################################################

# Read coverage dataset --------------------------------------------------------
coverageData <- read.csv("data/coverageData.csv")

################################################################################
#
# This dataset has the following variables:
#   * date - date the data was collected
#   * spid - sampling point identifier
#   * pop - population size for each village/cluster surveyed
#   * latgps - latitude GPS coordinate
#   * longps - longitude GPS coordinate
#   * a - total SAM cases found
#   * b - SAM cases in the programme
#   * c - SAM cases out of the programme
#   * d - Recovering cases
#
################################################################################

# Task 1: Plot the data points

## We can use the longitude and latitude variables of the data to plot
##   * x-axis will be the longitude (longx)
##   * y-axis will be the latitude (laty)
plot(x = coverageData$longps, y = coverageData$latgps)

## Create a plot with a solid circle coloured blue
plot(x = coverageData$longps, y = coverageData$latgps, pch = 20, col = "blue")

## Create a plot with a solid circle with coloured blue outline and 
## light gray fill
plot(
  x = coverageData$longps, y = coverageData$latgps, 
  pch = 21, col = "blue", bg = "gray70"
)

## Convert SpatialPointsDataFrame
coverageDataSP <- SpatialPointsDataFrame(
  coords = coverageData[ , c("longps", "latgps")],
  data = coverageData,
  proj4string = CRS(proj4string(CRS("+proj=longlat +datum=WGS84 +no_defs")))
)

## Plot coverageDataSP
plot(coverageDataSP)

## Plot coverageDataSP
plot(coverageDataSP, pch = 21, col = "blue", bg = "gray70")


# Task 2: Calculate case-finding effectiveness for each sampling point

## Things to know and do to answer this question:
##   * Which rows of data correspond to a sampling point? How many data points
##     for each sampling point?
##   * Perform some form of aggregation of each row of data for each sampling
##     point
##   * With the aggregated data, calculate coverage indicator


# Task 3: Calculate treatment coverage for each sampling point


