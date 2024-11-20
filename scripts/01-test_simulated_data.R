#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(dplyr)

## reading data

simulated_data <- read.csv("data/00-simulated_data/simulated_data.csv")

head(simulated_data)

# 1. Test: Dataset load success
test_that("Dataset loads successfully", {
  expect_true(exists("simulated_data") && is.data.frame(simulated_data))
})

# 2. Test: No missing values in the dataset
test_that("No missing values in dataset", {
  expect_true(all(!is.na(simulated_data)))
})

# 3. Test: Column names are correct
test_that("Column names are as expected", {
  expected_names <- c("date", "cpi", "interest_rates", "house_prices", "average_wages", "house_supply")
  expect_equal(colnames(simulated_data), expected_names)
})

# 4. Test: Column data types are correct
test_that("Column data types are correct", {
  expect_true(is.Date(simulated_data$date))              # Date column
  expect_true(is.numeric(simulated_data$cpi))            # CPI column
  expect_true(is.numeric(simulated_data$interest_rates)) # Interest rates
  expect_true(is.numeric(simulated_data$house_prices))   # House prices
  expect_true(is.numeric(simulated_data$average_wages))  # Average wages
  expect_true(is.numeric(simulated_data$house_supply))   # House supply
})

# 5. Test: Value ranges for each column
test_that("Values fall within expected ranges", {
  expect_true(all(simulated_data$cpi >= 200 & simulated_data$cpi <= 400))               # CPI range
  expect_true(all(simulated_data$interest_rates >= 0 & simulated_data$interest_rates <= 10)) # Interest rates
  expect_true(all(simulated_data$house_prices >= 200000 & simulated_data$house_prices <= 600000)) # House prices
  expect_true(all(simulated_data$average_wages >= 20 & simulated_data$average_wages <= 50))      # Average wages
  expect_true(all(simulated_data$house_supply >= 4 & simulated_data$house_supply <= 12))         # House supply
})

# 6. Test: Data set shape (number of rows and columns)
test_that("Dataset shape is correct", {
  expect_equal(nrow(simulated_data), 223) # Number of rows
  expect_equal(ncol(simulated_data), 6)   # Number of columns
})

# 7. Test: All values in the 'date' column are unique
test_that("All values in the 'date' column are unique", {
  expect_true(length(unique(simulated_data$date)) == nrow(simulated_data))
})

# 8. Test: Trend consistency (e.g., CPI generally increases over time)
test_that("CPI shows reasonable trends over time", {
  expect_true(median(diff(simulated_data$cpi)) >= 0) # Median change should be non-negative
})

# 9. Test_that("No extreme outliers in numeric columns", 
{
  expect_true(all(simulated_data$cpi < quantile(simulated_data$cpi, 0.99)))         # CPI outliers
  expect_true(all(simulated_data$interest_rates < quantile(simulated_data$interest_rates, 0.99))) # Interest rates
  expect_true(all(simulated_data$house_prices < quantile(simulated_data$house_prices, 0.99)))     # House prices
  expect_true(all(simulated_data$average_wages < quantile(simulated_data$average_wages, 0.99)))   # Wages
  expect_true(all(simulated_data$house_supply < quantile(simulated_data$house_supply, 0.99)))     # House supply
  }

# 10. Test_that("Dataset integrity is maintained after cleaning", 
{
  expect_equal(nrow(simulated_data), 223) # Number of rows should remain unchanged
  expect_equal(ncol(simulated_data), 6)   # Number of columns should remain unchanged
}

# 10. test_that("Variables have expected correlations", 
{
  cor_cpi_price <- cor(simulated_data$cpi, simulated_data$house_prices)
  expect_true(cor_cpi_price > 0) # Positive correlation between CPI and house prices
  
  cor_wage_price <- cor(simulated_data$average_wages, simulated_data$house_prices)
  expect_true(cor_wage_price > 0) # Positive correlation between wages and house prices
}

