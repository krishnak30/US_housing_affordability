#### Preamble ####
# Purpose: Simulates a data set of the variables needed for housing affordability
# analysis, including CPI, interest rates, housing prices, average wages, and housing supply
# Author: Krishna Kumar
# Date: 20 November, 2024
# Contact: krishna.kumar@mail.utoronto.ca
# Pre-requisites: None
# Any other information needed? N/A


#### Workspace setup ####

# Load necessary libraries
library(dplyr)
library(lubridate)

# Set seed for reproducibility
set.seed(123)

# Create a date sequence for monthly data from 2006-03-01 to 2024-09-01
start_date <- as.Date("2006-03-01")
end_date <- as.Date("2024-09-01")
dates <- seq(start_date, end_date, by = "month")

# Number of months in the dataset
n <- length(dates)

# Simulate CPI (e.g., between 200 and 400)
cpi <- round(runif(n, min = 200, max = 400), 2)

# Simulate Interest Rates (e.g., between 0 and 10%)
interest_rates <- round(runif(n, min = 0, max = 10), 2)

# Simulate House Prices (e.g., between $200,000 and $600,000)
house_prices <- round(runif(n, min = 200000, max = 600000), 0)

# Simulate Average Wages (e.g., between $20 and $50 per hour)
average_wages <- round(runif(n, min = 20, max = 50), 2)

# Simulate House Supply (e.g., between 4 and 12 months of supply)
house_supply <- round(runif(n, min = 4, max = 12), 1)

# Combine into a data frame
simulated_data <- data.frame(
  date = dates,
  cpi = cpi,
  interest_rates = interest_rates,
  house_prices = house_prices,
  average_wages = average_wages,
  house_supply = house_supply
)

# Ensure the date column is of type Date
simulated_data$date <- as.Date(simulated_data$date)

# View the first few rows of the simulated data
head(simulated_data)

# Save the simulated data as a CSV
write.csv(simulated_data, "data/00-simulated_data/simulated_data.csv", row.names = FALSE)
