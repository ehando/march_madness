# march_madness 🏀

# Contributors
Eirik Andersen, Jason Donohue, Rebecca Moges

## Introduction 

In this project, we use various metrics to predict the winners of the NCAA Men's Basketball Tournament, also known as March Madness. Our goal is to accurately predict which teams are most likely to win each game and ultimately become the tournament champion.

To achieve this goal, we have collected and analyzed a large amount of data on college basketball teams, including their past performance, key player statistics, and various team metrics such as offensive and defensive efficiency.

## Data Dictionary
 
 1.Tournament Data: This dataset contains the teams and their stats for the 2023 season, including their conference tournament.
 
## Data Cleaning 
* Manipulated data to get specific variables of interest to be included in the data frame

```
game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE)
```
---

## Data Prep

1. Created a TOTAL.SCORE column using key stats

```
game_data$TOTAL.SCORE <- game_data$KENPOM.ADJUSTED.EFFICIENCY *
game_data$BARTTORVIK.ADJUSTED.EFFICIENCY *
game_data$TURNOVER.. / game_data$POINTS.PER.POSSESSION.DEFENSE * game_data$FREE.THROW..
```
---

2. Rounded scores to 4 digits

```
game_data <- game_data %>%
  mutate(TOTAL.SCORE = round(TOTAL.SCORE,4))
```
---

3. Sorted the data by the TOTAL.SCORE column instead of alphabetically

```
game_data <- game_data[order(-game_data$TOTAL.SCORE),]
```
---

## Data Analysis
 
 1. We let the user select two teams for a matchup

```
fluidRow(
    column(2,
           selectInput('team_1', 'Choose Team 1', game_data$TEAM)),
    column(2,
             selectInput('team_2', 'Choose Team 2', game_data$TEAM)),
```

![6BD4E838-7B63-42F4-A4B4-46929FFADB55_4_5005_c](https://user-images.githubusercontent.com/113206712/227397128-6ed55970-3489-42c0-a863-b1070fb40c7d.jpeg)
---

2. We used the ggplot function to visualize a hypothetical match up between team 1 and team 2
  
 ``` 
    output$plot_01 <- renderPlot({
    team1 <- game_data[game_data$TEAM == input$team_1, ] 
    team2 <- game_data[game_data$TEAM == input$team_2, ]
    matchup <- rbind(team1, team2)
    ggplot(matchup, aes(x = TOTAL.SCORE, y = TEAM, fill = TOTAL.SCORE)) + 
      geom_col() + 
      xlab("Total Score") + 
      ylab("Team") + 
      ggtitle('Matchup Winner') +
      guides(fill = "none")
  })
  ```
  ![40B79C8D-31C0-4E2B-AD2E-BEA4410FB03E](https://user-images.githubusercontent.com/113206712/227397136-34b78fe2-e2a1-4011-938d-e2f90f7f0343.jpeg)
---

3. Added a table sorted by score so the user can find teams and try them in the matchup

``` 
output$table <- DT::renderDataTable(game_data[,c("TEAM","TOTAL.SCORE")],options = list(pageLength = 4))
```

![3DCB5042-61B1-40C0-BAB1-1FA36EFF6572](https://user-images.githubusercontent.com/113206712/227397153-37f2d5af-a6bf-4495-a3a5-220f5312901d.jpeg)
---

4. Chart showing all teams' scores (image only partial, all teams shown in shinyapp)

```  
    output$plot_02 <- renderPlot({
    ggplot(game_data, aes(x = TEAM, y = TOTAL.SCORE)) +
      geom_col(fill = "steelblue") +
      xlab("Team") +
      ylab("Total Score") +
      ggtitle("Total Score by Team")
```
      
![464FFE85-314C-41D8-8AAE-210794CA2BFD](https://user-images.githubusercontent.com/113206712/227397176-694e5d85-4199-4ab9-8ab8-547246f0eabf.jpeg)

---
