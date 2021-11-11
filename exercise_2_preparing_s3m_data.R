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

# Task 2: Calculate case-finding effectiveness for each sampling point

# Task 3: Calculate treatment coverage for each sampling point


