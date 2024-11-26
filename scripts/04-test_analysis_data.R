#### Preamble ####
# Purpose: Tests the analysis data we will be using for our analysis
# Author: Krishna Kumar
# Date: 20 November, 2024
# Contact: krishna.kumar@mail.utoronto.ca
# Pre-requisites: none
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(dplyr)
library(arrow)

analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
head(analysis_data)

# Ensure date column is of type Date
analysis_data$Date <- as.Date(analysis_data$Date)

# 1. Test: Dataset loads successfully
test_that("Dataset loads successfully", {
  expect_true(exists("analysis_data") && is.data.frame(analysis_data))
})

# 2. Test: No missing values in the dataset
test_that("No missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# 3. Test: Column names are correct
test_that("Column names are as expected", {
  expected_names <- c("Date", "CPI (Index)", "Interest Rate (%)", "Average Wage ($/Hour)", 
                      "House Price (USD)", "House Supply (Month's Supply)")
  expect_equal(colnames(analysis_data), expected_names)
})

# 4. Test: Column data types are correct
test_that("Column data types are correct", {
  expect_true(is.Date(analysis_data$Date))                  # Date column
  expect_true(is.numeric(analysis_data$`CPI (Index)`))      # CPI column
  expect_true(is.numeric(analysis_data$`Interest Rate (%)`)) # Interest rates
  expect_true(is.numeric(analysis_data$`House Price (USD)`)) # House prices
  expect_true(is.numeric(analysis_data$`Average Wage ($/Hour)`))  # Average wages
  expect_true(is.numeric(analysis_data$`House Supply (Month's Supply)`)) # House supply
})

# 6. Test: Dataset shape (number of rows and columns)
test_that("Dataset shape is correct", {
  expect_equal(nrow(analysis_data), 223) # Expected number of rows
  expect_equal(ncol(analysis_data), 6)   # Expected number of columns
})

# 7. Test: All values in the 'Date' column are unique
test_that("All values in the 'Date' column are unique", {
  expect_true(length(unique(analysis_data$Date)) == nrow(analysis_data))
})

# 8. Test: Trend consistency (e.g., CPI generally increases over time)
test_that("CPI shows reasonable trends over time", {
  expect_true(median(diff(analysis_data$`CPI (Index)`)) >= 0) # Median change should be non-negative
})

# 10. Test: Dataset integrity is maintained after cleaning
test_that("Dataset integrity is maintained after cleaning", {
  expect_equal(nrow(analysis_data), 223) # Number of rows should remain unchanged
  expect_equal(ncol(analysis_data), 6)   # Number of columns should remain unchanged
})

# 11. Test: Variables have expected correlations
test_that("Variables have expected correlations", {
  cor_cpi_price <- cor(analysis_data$`CPI (Index)`, analysis_data$`House Price (USD)`)
  expect_true(cor_cpi_price > 0) # Positive correlation between CPI and house prices
  
  cor_wage_price <- cor(analysis_data$`Average Wage ($/Hour)`, analysis_data$`House Price (USD)`)
  expect_true(cor_wage_price > 0) # Positive correlation between wages and house prices
})