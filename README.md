# march_madness 🏀

# Contributors
Eirik Andersen, Jason Donohue, Rebecca Moges

## Introduction 

In this project, we use various metrics to predict the winners of the NCAA Men's Basketball Tournament, also known as March Madness. Our goal is to accurately predict which teams are most likely to win each game and ultimately become the tournament champion.

To achieve this goal, we have collected and analyzed a large amount of data on college basketball teams, including their past performance, key player statistics, and various team metrics such as offensive and defensive efficiency.

 ## Data Dictionary
 
 1.Tournament Data: This dataset contains information on past March Madness tournaments, including the teams that participated, their seeding, and their performance in the tournament.
 
## Data Cleaning 
* Manipulated data to get specific variables of interest to be included in the data frame

    ```game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE) `
  * 

  ---
 
 ## Data Analysis
  
1. we used the ggplot fucnction to plot this graph aiming to predict the winners between team 1 and team 2
 ```  output$plot_01 <- renderPlot({
    team1 <- game_data[game_data$TEAM == input$team_1, ] 
    team2 <- game_data[game_data$TEAM == input$team_2, ]
    matchup <- rbind(team1, team2)
    ggplot(matchup, aes(x = TOTAL.SCORE, y = TEAM, fill = TOTAL.SCORE)) + 
      geom_col() + 
      xlab("Total Score") + 
      ylab("Team") + 
      ggtitle('Matchup Winner') +
      guides(fill = FALSE)
  })

![6BD4E838-7B63-42F4-A4B4-46929FFADB55_4_5005_c](https://user-images.githubusercontent.com/113206712/227397128-6ed55970-3489-42c0-a863-b1070fb40c7d.jpeg)



  ![40B79C8D-31C0-4E2B-AD2E-BEA4410FB03E](https://user-images.githubusercontent.com/113206712/227397136-34b78fe2-e2a1-4011-938d-e2f90f7f0343.jpeg)

![3DCB5042-61B1-40C0-BAB1-1FA36EFF6572](https://user-images.githubusercontent.com/113206712/227397153-37f2d5af-a6bf-4495-a3a5-220f5312901d.jpeg)


![464FFE85-314C-41D8-8AAE-210794CA2BFD](https://user-images.githubusercontent.com/113206712/227397176-694e5d85-4199-4ab9-8ab8-547246f0eabf.jpeg)


 
