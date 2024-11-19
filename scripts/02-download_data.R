#### Preamble ####
# Purpose: Downloads and saves the data from [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(readr)

raw_data <- read_csv("data/01-raw_data/usa_00006.csv.gz")

head(raw_data)

### DOWNLOADING FRED DATA ###

#install.packages("fredr")
library(fredr)

# setting API key #
fredr_set_key("5aa998eef538fb478d02e52f5b892293")

# Downloading Data
cpi_data <- fredr(
  series_id = "CPIAUCSL",       # CPI series ID
  observation_start = as.Date("2015-01-01"), # Start date
  observation_end = as.Date("2022-12-31")    # End date
)

# Download Interest Rate data
interest_rate_data <- fredr(
  series_id = "FEDFUNDS",       # Interest rate series ID
  observation_start = as.Date("2015-01-01"),
  observation_end = as.Date("2022-12-31")
)

# Download Median Household Income (MEHOINUSA672N)
income_data <- fredr(
  series_id = "MEHOINUSA672N", 
  observation_start = as.Date("2000-01-01"),  # Adjust date range as needed
  observation_end = as.Date("2022-12-31")
)

# Download Median Sales Price of Houses (MSPUS)
house_price_data <- fredr(
  series_id = "MSPUS",
  observation_start = as.Date("2000-01-01"),
  observation_end = as.Date("2022-12-31")
)
  ## STILL HAVE TO DOWNLOAD AND SAVE THESE LAST TWO PROPERLY
  
# returning data
head(cpi_data)
head(interest_rate_data)
head(income_data)
head(house_price_data)


# saving data
write.csv(cpi_data, "data/01-raw_data/cpi_data.csv", row.names = FALSE)
write.csv(interest_rate_data, "data/01-raw_data/interest_rate_data.csv", row.names = FALSE)
write.csv(income_data, "data/01-raw_data/interest_rate_data.csv", row.names = FALSE)
write.csv(house_price_data, "data/01-raw_data/interest_rate_data.csv", row.names = FALSE)

### INSTRUCTIONS FOR DOWNLOADING DATA FROM IPUMS ###


## Step 1: Access the IPUMS USA Website

# Navigate to the IPUMS USA website: https://usa.ipums.org/usa/.
# If you do not have an account, create one by signing up. 
# If you already have an account, log in.

## Step 2: Start a New Data Extract

# On the IPUMS USA homepage, click "Get Data" in the navigation menu.

## Step 3: Select Variables

# Move to "Select Harmonized Variables" to choose the variables for your extract.
# Use the search bar or browse the categories to find the following variables:

  # STATEICP: State identifier for regional analysis.
  # RENTGRS: Monthly gross rent.
  # HHINCOME: Total household income.
  # VALUEH: House value.
  # MORTAMT1 (First mortgage payment).
  # SEX
  # AGE
  # EMPSTAT 

  ## The following variables are automatically included: 

  # YEAR: Census year.
  # MULTYEAR: Actual year of survey for multi-year samples.
  # SAMPLE: IPUMS sample identifier.
  # SERIAL: Household serial number
  # CBSERIAL: Original Census Bureau household serial number
  # CLUSTER: Household cluster for variance estimation
  # HWT: Household weight
  # GQ: Group quarters status
  # PERNUM: Person number in sample unit
  # PWT: Person weight

  # Deselect any other variables that have been included


##  Step 4: Click "Create Data Extract" and Choose Samples
# Click "Create Data Extract"
# Change the data format to ".dta" or ".csv"
# Click the "Change" button in the Samples" tab and select the following: 

  # 2019 ACS 5-Year Sample: Use for pre-pandemic baseline data.
# 2020, 2021, and 2022 ACS Single-Year Samples: Use for pandemic and post-pandemic analysis.
# Click "Submit Sample Selections"

# Step 5: Reduce Sample Size by clicking "Customize Sample Sizes" and do the following:
  
  # Adjust 'Persons' for the 2019 5-Year ACS Sample to 999:
  # Cap Sample Sizes for Single-Year Samples:
  # For each single-year sample (2020–2022), set:Persons: 500
  # Click 'Submit'.

## Step 6: Put a brief description of your extract and 
## Click "Submit Data Extract" and download it when it's ready'
## It will notify you by email. 

         
