################################################################################
#
# Exercise 3: Spatial interpolation
# 
#This exercise discusses how to perform spatial interpolation on S3M data to be 
# able to predict estimates of the indicator of interest in smaller spatial 
# units across the survey area.
#
# Example datasets for all the exercises can be found in the folder `data`.
#
# Following is the starter code to perform spatial interpolation on S3M 
# datasets.
#
################################################################################

# Step 1: Read coverage and map dataset ----------------------------------------

# Load libraries
library(rgdal)
library(rgeos)
library(raster)
library(gstat)

# Read coverage data
coverageData <- read.csv("data/coverageData.csv")

# Read each administrative boundary maps for Niger
niger0 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm0")
niger1 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm1")
niger2 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm2")
niger3 <- readOGR(dsn = "data/NER_adm", layer = "NER_adm3")

# Convert coverage data into class Spatial object
coverageSP <- SpatialPointsDataFrame(
  coords = coverageData[ , c("longps", "latgps")],
  data = coverageData,
  proj4string = CRS(proj4string(niger0))
)

# Step 2: Create an interpolation grid -----------------------------------------
intPoints <- spsample(x = niger0, n = 100000, type = "hexagonal")
intGrid <- HexPoints2SpatialPolygons(hex = intPoints)

# Step 3: Interpolate estimates at spatial units with no estimates
intCoverage <- idw(
  formula = b ~ 1,
  locations = coverageSP,
  newdata = intPoints
)
