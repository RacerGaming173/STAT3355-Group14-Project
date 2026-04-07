library(dplyr)

# Load in March Madness datasets
original_dataset <- read.csv("cbb.csv")
large_dataset <- read.csv("march-madnesss-historical-data.csv")

# DATA CLEANING 1: Purge all non-tournament teams from dataset
original_dataset <- original_dataset %>%
  filter(!is.na(POSTSEASON) & POSTSEASON != "NA" & POSTSEASON != "N/A")

sort(unique(original_dataset$TEAM))
sort(unique(large_dataset$Team))

gsub("\\s*\\([^)]*\\)\\s*", "", original_dataset$TEAM, ignore.case = TRUE)
gsub("\\s*\\([^)]*\\)\\s*", "", large_dataset$Team, ignore.case = TRUE)

sort(unique(original_dataset$TEAM))
sort(unique(large_dataset$Team))

original_dataset$TEAM <- gsub("[^A-Za-z ]", "", original_dataset$TEAM)
large_dataset$Team <- gsub("[^A-Za-z ]", "", large_dataset$Team)

# Create list of unique teams
original_teams_unique <- sort(unique(original_dataset$TEAM))
large_teams_unique <- sort(unique(large_dataset$Team))
merged_teams_unique <- intersect(original_teams_unique, large_teams_unique)

large_dataset <- large_dataset %>%
  filter(Team %in% merged_teams_unique & !(Year %in% c(2012, 2024)))
original_dataset <- original_dataset %>%
  filter(TEAM %in% merged_teams_unique & !(YEAR %in% c(2012, 2024)))

# DATA CLEANING 2: Standardize 
merged_dataset <- merge(original_dataset,
                        large_dataset[, c("Team", "Year", "OppO", "OppD", "Made.Round.of.16")], 
                        by.x = c("Team", "Year"), 
                        by.y = c("TEAM", "YEAR")
                        )

# DATA CLEANING 3: Create new variable NetRtg (net rating)
merged_dataset$NetRtg <- merged_dataset$OppO - merged_dataset$OppD
