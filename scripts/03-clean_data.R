#### Preamble ####
# Purpose: Combines all datasets and cleans them, making them ready for analysis
# Author: Krishna Kumar
# Date: 20 November, 2024
# Contact: krishna.kumar@mail.utoronto.ca
# Pre-requisites: Download all datasets according to "download_data" R script
# Any other information needed? N/A

#### Workspace setup ####

library(tidyverse)
library(readr)
library(arrow)
library(dplyr)

## Reading the datasets in this file 

cpi_data <- read.csv("data/01-raw_data/cpi_data.csv")
interest_rate_data <- read.csv("data/01-raw_data/interest_rate_data.csv")
income_data <- read.csv("data/01-raw_data/income_data.csv")
house_price_data <- read.csv("data/01-raw_data/house_price_data.csv")
house_supply_data <- read.csv("data/01-raw_data/house_supply_data.csv")

## Inspecting the datasets

head(cpi_data)
tail(interest_rate_data)
tail(income_data)
tail(house_price_data)
head(house_supply_data)

## Converting first columns of all data sets to 'date' types

cpi_data$date <- as.Date(cpi_data$date)
interest_rate_data$date <- as.Date(interest_rate_data$date)
income_data$date <- as.Date(income_data$date)
house_price_data$date <- as.Date(house_price_data$date)
house_supply_data$date <- as.Date(house_supply_data$date)

## Checking if the column type conversion worked

cat("CPI Data:", class(cpi_data$date), "\n")
cat("Interest Rate Data:", class(interest_rate_data$date), "\n")
cat("Income Data:", class(income_data$date), "\n")
cat("House Price Data:", class(house_price_data$date), "\n")
cat("House Supply Data:", class(house_supply_data$date), "\n")

## Keeping only the date and value columns from each dataset and renaming the 'value' column to an appropriate name

cpi_data <- cpi_data %>% select(date, cpi = value)
interest_rate_data <- interest_rate_data %>% select(date, interest_rate = value)
income_data <- income_data %>% select(date, average_wage = value)
house_price_data <- house_price_data %>% select(date, house_price = value)
house_supply_data <- house_supply_data %>% select(date, house_supply = value)

# Checking to see if the column removal and renaming worked

head(cpi_data)
head(interest_rate_data)
head(income_data)
head(house_price_data)
head(house_supply_data)


## creating a merged data set by combining all others

# Merging CPI and Interest Rate data

merged_data <- cpi_data %>%
  left_join(interest_rate_data, by = "date")

# View the first and last few rows of the merged dataset
head(merged_data)
tail(merged_data)


# Merging the previous merged data with Income data
merged_data <- merged_data %>%
  left_join(income_data, by = "date")

# View the first few rows of the updated merged dataset
head(merged_data)
tail(merged_data)

# Check for missing values
colSums(is.na(merged_data))


# Merging the previous merged data with House Price data
merged_data <- merged_data %>%
  left_join(house_price_data, by = "date")

# View the first few rows of the updated merged dataset
head(merged_data)
tail(merged_data)


# Merging the previous merged data with House Supply data
merged_data <- merged_data %>%
  left_join(house_supply_data, by = "date")

# View the first few rows of the final merged dataset
head(merged_data)
tail(merged_data)

# Checking total number of rows

nrow(merged_data)

#### Merging data sets complete. 

## Renaming columns

cleaned_data <- merged_data

head(cleaned_data)

colnames(cleaned_data) <- c(
  "Date",                     # Column 1: Date remains unchanged
  "CPI (Index)",              # CPI column with unit
  "Interest Rate (%)",        # Interest rate with percentage unit
  "Average Wage ($/Hour)",    # Average wage with dollar/hour unit
  "House Price (USD)",        # House price with USD unit
  "House Supply (Month's Supply)" # House supply with unit
)

colnames(cleaned_data)
head(cleaned_data)

## Creating two new columns for Wage Growth Rate and House Price Growth Rate
analysis_data <- cleaned_data
head(analysis_data)

# Calculate growth rates
analysis_data <- analysis_data %>%
  arrange(Date) %>%  # Ensure the data is sorted by date
  mutate(
    `House Price Growth (%)` = ( `House Price (USD)` / lag(`House Price (USD)`) - 1) * 100,
    `Wage Growth (%)` = ( `Average Wage ($/Hour)` / lag(`Average Wage ($/Hour)`) - 1) * 100
  )

head(analysis_data)
colnames(analysis_data)

head(analysis_data[, c("Date", "House Price Growth (%)", "Wage Growth (%)")])
head(analysis_data[, c("Date", "House Price (USD)", "Average Wage ($/Hour)")])

## creating a new column for affordability index (house prices/average wage)

# Add Affordability Index to the dataset
analysis_data <- analysis_data %>%
  mutate(`Affordability Index` = `House Price (USD)` / `Average Wage ($/Hour)`)

# View the first few rows to confirm
head(analysis_data[, c("Date", "House Price (USD)", "Average Wage ($/Hour)", "Affordability Index")])

head(analysis_data)
## Saving data

write_parquet(analysis_data, "data/02-analysis_data/analysis_data.parquet")
