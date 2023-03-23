# march_madness 🏀

# Contributors
Eirik Andersen, Jason Donohue, Rebecca Moges

## Introduction 

In this project, we use various metrics to predict the winners of the NCAA Men's Basketball Tournament, also known as March Madness. Our goal is to accurately predict which teams are most likely to win each game and ultimately become the tournament champion.

To achieve this goal, we have collected and analyzed a large amount of data on college basketball teams, including their past performance, key player statistics, and various team metrics such as offensive and defensive efficiency.

 ## Data Dictionary
 
1. Team Statistics Data: This dataset contains various statistics for each team, including win-loss record, points per game, rebounds per game, field goal percentage, three-point percentage, and free throw percentage
 
2. Player Statistics Data: This dataset contains individual player statistics for each team, including points per game, rebounds per game, assists per game, steals per game, and blocks per game.
 
3. Game Data: This dataset contains information on each game in the March Madness tournament, including the teams playing, the date and time of the game, the location, and the final score.
 
4. Historical Tournament Data: This dataset contains information on past March Madness tournaments, including the teams that participated, their seeding, and their performance in the tournament.
 
5. Turnover Rate: Is a measure of a teams ability to protect the ball and avoid turnovers. 
 
6. Barttorvik Adjusted Efficiency: Is a measure of a team's overall offensive and defensive performance. 

7. KENPOM Adjusted Efficiency: Is a statistical measure used in college basketball to evaluate a team's offensive and defensive performance. 
## Data Cleaning 
* Manipulated data to get specific variables of interest to be included in the data frame

 `game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE)`

 
