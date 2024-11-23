#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(arrow)
library(here)

#### Read data ####
analysis_data <- read_parquet(here("data", "02-analysis_data", "analysis_data.parquet"))

## Model 1: Only using CPI as a predictor ##

model_1 <- lm(`Affordability Index` ~ `CPI (Index)`, data = analysis_data)

## Save Model 1 ##

saveRDS(model_1, "models/model_1_CPI.rds")


## Model 2: Using CPI and Housing Suply as Predictors ##

model_2 <- lm(`Affordability Index` ~ `CPI (Index)` + `House Supply (Month's Supply)`, data = analysis_data)

## Saving Model 2 ## 

saveRDS(model_2, "models/model_2_CPI_HousingSupply.rds")

## Model 3: Using CPI, Housing Supply, and Interest Rate as predictors ##

model_3 <- lm(`Affordability Index` ~ `CPI (Index)` + `House Supply (Month's Supply)` + `Interest Rate (%)`, data = analysis_data)

## Saving Model 3 ##

saveRDS(model_3, "models/model_3_Full.rds")







### Model data ####
first_model <-
  stan_glm(
    formula = flying_time ~ length + width,
    data = analysis_data,
    family = gaussian(),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_aux = exponential(rate = 1, autoscale = TRUE),
    seed = 853
  )


#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


