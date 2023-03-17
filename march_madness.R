library(tidyverse)
library(ggplot2)
library(dplyr)

game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE) %>%
  distinct(TEAM, .keep_all = TRUE)

game_data$TOTAL.SCORE <- game_data$KENPOM.ADJUSTED.EFFICIENCY *
game_data$BARTTORVIK.ADJUSTED.EFFICIENCY *
game_data$TURNOVER.. / game_data$POINTS.PER.POSSESSION.DEFENSE

