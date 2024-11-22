#### Preamble ####
# Purpose: Downloads and saves data from FRED, needed for analysis
# Author: Krishna Kumar
# Date: 20 November, 2024
# Contact: krishna.kumar@mail.utoronto.ca
# Pre-requisites: Create an account on 'https://fred.stlouisfed.org/' and 
  # generate an API key by going to 'My Account' and clicking on 'API Keys' 
  # and then clicking on 'Request API Key.'
# Any other information needed? N/A


#### Workspace setup ####
library(readr)

### DOWNLOADING FRED DATA ###

#install.packages("fredr")
library(fredr)

# setting API key #
fredr_set_key("5aa998eef538fb478d02e52f5b892293")

# Downloading CPI Data DONE
cpi_data <- fredr(
  series_id = "CPIAUCSL",       # CPI series ID
  observation_start = as.Date("2006-03-01"), # Start date
  observation_end = as.Date("2024-09-01")    # End date
)

# Download Interest Rate data DONE
interest_rate_data <- fredr(
  series_id = "FEDFUNDS",       # Interest rate series ID
  observation_start = as.Date("2006-03-01"),
  observation_end = as.Date("2024-09-01")
)

# Download Average Hourly Earnings of All Employees, Total Private DONE
income_data <- fredr(
  series_id = "CES0500000003", 
  observation_start = as.Date("2006-03-01"),  
  observation_end = as.Date("2024-09-01")
)

# Download Median Sales Price of New Houses in the US DONE
house_price_data <- fredr(
  series_id = "MSPNHSUS",
  observation_start = as.Date("2006-03-01"),
  observation_end = as.Date("2024-09-01")
)

# Download Monthly Supply of New Houses DONE
house_supply_data <- fredr(
  series_id = "MSACSR",
  observation_start = as.Date("2006-03-01"),
  observation_end = as.Date("2024-09-01")
)

  
# returning data
head(cpi_data)
head(interest_rate_data)
head(income_data)
head(house_price_data)
head(house_supply_data)


# saving data
write.csv(cpi_data, "data/01-raw_data/cpi_data.csv", row.names = FALSE)
write.csv(interest_rate_data, "data/01-raw_data/interest_rate_data.csv", row.names = FALSE)
write.csv(income_data, "data/01-raw_data/income_data.csv", row.names = FALSE)
write.csv(house_price_data, "data/01-raw_data/house_price_data.csv", row.names = FALSE)
write.csv(house_supply_data, "data/01-raw_data/house_supply_data.csv", row.names = FALSE)

# Checking number of rows in each dataset

cat("Number of rows in CPI data:", nrow(cpi_data), "\n")
cat("Number of rows in Interest Rate data:", nrow(interest_rate_data), "\n")
cat("Number of rows in Income data:", nrow(income_data), "\n")
cat("Number of rows in House Price data:", nrow(house_price_data), "\n")
cat("Number of rows in House Supply data:", nrow(house_supply_data), "\n")



