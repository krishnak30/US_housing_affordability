#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(readr)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/usa_00006.csv.gz")

head(raw_data)
tail(raw_data)
colnames(raw_data)

# Keep only relevant columns
cleaned_data <- raw_data %>%
  select(YEAR, MULTYEAR, SERIAL, STATEICP, MORTAMT1, RENTGRS, HHINCOME, VALUEH, SEX, AGE, EMPSTAT)

colnames(cleaned_data)

# Restructuring data to separate multyear and year columns and row data

# Step 1: Create a new 'FINAL_YEAR' column
restructured_data <- cleaned_data %>%
  mutate(FINAL_YEAR = ifelse(is.na(MULTYEAR), YEAR, MULTYEAR))

# Step 2: Drop the 'YEAR' and 'MULTYEAR' columns (optional, if not needed anymore)
restructured_data <- restructured_data %>%
  select(-YEAR, -MULTYEAR)

# Step 3: Sort the data by 'FINAL_YEAR' to ensure chronological order
restructured_data <- restructured_data %>%
  arrange(FINAL_YEAR)

# Step 4: Verify the structure of the restructured data
head(restructured_data)
tail(restructured_data)

# Checking the unique years
unique_years <- unique(restructured_data$FINAL_YEAR)

# Print the unique years
print(unique_years)

write.csv(restructured_data, "data/02-analysis_data/restructured_data.csv", row.names = FALSE)


#### Save data ####
write_csv(cleaned_data, "outputs/data/analysis_data.csv")
