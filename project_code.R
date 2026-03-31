library(dplyr)

# Load in March Madness dataset
original_dataset <- read.csv("cbb.csv")

# DATA CLEANING 1: Purge all non-tournament teams from dataset
tournament_teams_data <- original_dataset %>%
  filter_out(is.na(POSTSEASON) | POSTSEASON == "N/A")

