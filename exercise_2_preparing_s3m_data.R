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

## Answer: Data is structured as about 3 rows of data/data points corresponding
## to a sampling point.

##   * Perform some form of aggregation of each row of data for each sampling
##     point

## Sum the coverage data for each sampling point
## For coordinates, get the min-max latitude, min-max longitude, also can get
## mean values of longitude and latitude

if (!requireNamespace(dplyr)) install.packages("dplyr")
library(dplyr)

coverageDataBySP <- coverageData %>%
  group_by(spid) %>%
  summarise(
    pop = sum(pop, na.rm = TRUE),
    min_lat = min(latgps, na.rm = TRUE),
    max_lat = max(latgps, na.rm = TRUE),
    min_lon = min(longps, na.rm = TRUE),
    max_lon = max(longps, na.rm = TRUE),
    mean_lat = mean(latgps, na.rm = TRUE),
    mean_lon = mean(longps, na.rm = TRUE),
    median_lat = median(latgps, na.rm = TRUE),
    median_lon = median(longps, na.rm = TRUE),
    sam_total = sum(a, na.rm = TRUE), 
    sam_in = sum(b, na.rm = TRUE), 
    sam_out = sum(c, na.rm = TRUE), 
    sam_rec = sum(d, na.rm = TRUE)
  )

## Plot the original dataset
plot(
  x = coverageData$longps, y = coverageData$latgps, 
  pch = 21, col = "blue", bg = "gray70"
)

## Plot summarised dataset
points(
  x = coverageDataBySP$mean_lon, y = coverageDataBySP$mean_lat,
  pch = 16, col = "red"
)

## Plot meadian GPS coordinates
points(
  x = coverageDataBySP$median_lon, y = coverageDataBySP$median_lat,
  pch = 1, col = "green", cex = 2
)

##   * With the aggregated data, calculate coverage indicator
## Creating your own function


# Task 3: Calculate treatment coverage for each sampling point

## Case-finding effectiveness
with(coverageDataBySP, sam_in / sam_total)
#coverageDataBySP$case_finding <- with(coverageDataBySP, sam_in / sam_total)

coverageDataBySP$sam_in / coverageDataBySP$sam_total
coverageDataBySP$case_finding <- coverageDataBySP$sam_in / coverageDataBySP$sam_total

coverageDataBySP %>%
  mutate(case_finding = sam_in / sam_total)

## Treatment coverage
##
## Rout = floor((1 / k) * (Rin * (Cin + Cout + 1) / (Cin + 1) - Rin))
##
r_out <- with(
  coverageDataBySP, 
  floor(
    (1 / 3) * (sam_rec * ((sam_in + sam_out + 1) / (sam_in + 1)) - sam_rec)
  )
)

##
## treatment_coverage <- (Cin + Rin) / (Cin + Rin + Cout + Rout))
##
with(
  coverageDataBySP, 
  (sam_in + sam_rec) / (sam_in + sam_rec + sam_out + r_out)
)

## Writing functions in R

## Create a function to calculate case-finding effectiveness
calculate_case_finding <- function(sam_in, sam_total) {
  ## Add your scripts
  sam_in / sam_total
}

## Apply the function
with(
  coverageDataBySP, 
  calculate_case_finding(sam_in = sam_in, sam_total = sam_total)
)

## Create a function to calculate treatment coverage
calculate_rec_out <- function(k, sam_in, sam_out, sam_rec) {
  floor(
    (1 / k) * (sam_rec * ((sam_in + sam_out + 1) / (sam_in + 1)) - sam_rec)
  )
}

## Apply r_out function
r_out <- with(
  coverageDataBySP, 
  calculate_rec_out(
    k = 3, sam_in = sam_in, sam_out = sam_out, sam_rec = sam_rec
  )
)

## Create function for calculating treatment coverage
calculate_treatment <- function(sam_in, sam_out, sam_rec, k) {
  r_out <- calculate_rec_out(
    k = k, sam_in = sam_in, sam_out = sam_out, sam_rec = sam_rec
  )
  
  (sam_in + sam_rec) / (sam_in + sam_rec + sam_out + r_out)
}

## Apply calculate_treatment
with(
  coverageDataBySP, 
  calculate_treatment(
    sam_in = sam_in, sam_out = sam_out, sam_rec = sam_rec, k = 3
  )
)

## Add treatment coverage to data frame
coverageDataBySP$treatment_coverage <- with(
  coverageDataBySP, 
  calculate_treatment(
    sam_in = sam_in, sam_out = sam_out, sam_rec = sam_rec, k = 3
  )
)
