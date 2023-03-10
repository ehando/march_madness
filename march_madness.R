library(tidyverse)
library(ggplot2)

game_data <- read.csv("2023_game_data.csv")
tournament_team_data <- read.csv("tournament_team_data.csv")

game_data <- game_data %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,BARTTORVIK.ADJUSTED.EFFICIENCY)

tournament_team_data <- tournament_team_data %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,BARTTORVIK.ADJUSTED.EFFICIENCY)
