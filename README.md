# march_madness 🏀

# Contributors
Eirik Andersen, Jason Donohue, Rebecca Moges

## Introduction 

In this project, we use various metrics to predict the winners of the NCAA Men's Basketball Tournament, also known as March Madness. Our goal is to accurately predict which teams are most likely to win each game and ultimately become the tournament champion.

To achieve this goal, we have collected and analyzed a large amount of data on college basketball teams, including their past performance, key player statistics, and various team metrics such as offensive and defensive efficiency.

 ## Data Dictionary
 
 1. Game Data: This dataset contains information on each game in the March Madness tournament, including the teams playing, the date and time of the game, the location, and the final score.
 
## Data Cleaning 
* Manipulated data to get specific variables of interest to be included in the data frame

    `game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE)`

 <game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE)>
  
 
