library(tidyverse)
library(ggplot2)
library(dplyr)

game_data <- read.csv("2023_game_data.csv")
tournament_team_data <- read.csv("tournament_team_data.csv")
new_tournament_data <- read.csv("2023 Tournament Data.csv")

efficiency_game_data <- game_data %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,BARTTORVIK.ADJUSTED.EFFICIENCY)

efficiency_tournament_team_data <- tournament_team_data %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,BARTTORVIK.ADJUSTED.EFFICIENCY)


merged_average <- full_join(efficiency_game_data, efficiency_tournament_team_data) %>%
 group_by(TEAM) %>%
 summarise(KENPOM.ADJUSTED.EFFICIENCY = mean(KENPOM.ADJUSTED.EFFICIENCY, na.rm = TRUE), BARTTORVIK.ADJUSTED.EFFICIENCY = mean(BARTTORVIK.ADJUSTED.EFFICIENCY, na.rm = TRUE)) %>%
  arrange(desc(TEAM))


merged_turnover <- full_join(game_data, tournament_team_data) %>%
  group_by(TEAM)%>%
  summarise(TURNOVER.. = mean(TURNOVER.., na.rm = TRUE)) %>%
  arrange(order(TURNOVER..))

merged_defense_per <- full_join(game_data, tournament_team_data) %>%
  group_by(TEAM) %>%
  summarise(POINTS.PER.POSSESSION.DEFENSE = mean(POINTS.PER.POSSESSION.DEFENSE, na.rm = TRUE)) %>%
  arrange(order(POINTS.PER.POSSESSION.DEFENSE))


new_tournament_data_select <- new_tournament_data %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY, BARTTORVIK.ADJUSTED.EFFICIENCY, FREE.THROW.., TURNOVER..)


  




      

  
   
