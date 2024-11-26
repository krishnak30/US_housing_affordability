#### Preamble ####
# Purpose: Creates a directed acrylic graph showcasing the model set up
# Author: Krishna Kumar
# Date: 20 November, 2024
# Contact: krishna.kumar@mail.utoronto.ca
# Pre-requisites: None
# Any other information needed? N/A

#### Workspace setup ####
#install.packages("DiagrammeRsvg")
#install.packages("rsvg")

library(DiagrammeR)
library(DiagrammeRsvg)
library(rsvg)

# Define the causal model
causal_model <- "digraph {
  # Define nodes
  node [shape = plaintext]
    AffordabilityIndex [label = 'Affordability Index']
    CPI [label = 'CPI']
    InterestRate [label = 'Interest Rate']
    HousingSupply [label = 'Housing Supply']

  # Define directed edges (causal relationships)
  edge []
    CPI -> AffordabilityIndex
    InterestRate -> AffordabilityIndex
    HousingSupply -> AffordabilityIndex
}"

# Render and export the graph
graph <- grViz(causal_model)

# Save the graph as a PNG file
export_svg(graph) |>
  charToRaw() |>
  rsvg::rsvg_png("paper/dag.png", width = 1000)
