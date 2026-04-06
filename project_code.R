library(dplyr)

# Load in March Madness dataset
original_dataset <- read.csv("cbb.csv")

# DATA CLEANING 1: Purge all non-tournament teams from dataset
tournament_teams_data <- original_dataset %>%
  filter_out(is.na(POSTSEASON) | POSTSEASON == "N/A")

# Load in Large March Madness dataset
large_dataset <- read.csv("DEV _ March Madness.csv")

# DATA CLEANING 2: Create Net Rating variable for analysis
large_dataset$NetRtg <- large_dataset$OE - large_dataset$DE

