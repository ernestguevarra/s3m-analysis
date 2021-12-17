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

# Create a Dosso region administrative map
dosso <- subset(niger1, NAME_1 == "Dosso")

# Convert coverage data into class Spatial object and subset to Dosso region
coverageSP <- SpatialPointsDataFrame(
  coords = coverageData[ , c("longps", "latgps")],
  data = coverageData,
  proj4string = CRS(proj4string(niger0))
) |>
  subset(spid %in% 154:217)

# Step 2: Create an interpolation grid -----------------------------------------
intPoints <- spsample(x = dosso, n = 10000, type = "hexagonal")
intGrid <- HexPoints2SpatialPolygons(hex = intPoints)

proj4string(coverageSP) <- CRS("+proj=longlat +datum=WGS84 +no_defs")
proj4string(intPoints) <- CRS("+proj=longlat +datum=WGS84 +no_defs")

# Step 3: Interpolate estimates at spatial units with no estimates
intCoverage <- idw(
  formula = b / a ~ 1,
  locations = coverageSP |> subset(a > 0),
  newdata = intPoints
)

# Plot coverage estimates
pCoverage <- cut(
  intCoverage$var1.pred, 
  breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1), 
  labels = FALSE
)

coverage_colours <- RColorBrewer::brewer.pal(n = 6, name = "RdYlGn")

plot(
  intGrid, 
  col = coverage_colours[pCoverage + 1], 
  borders = coverage_colours[pCoverage + 1]
)



