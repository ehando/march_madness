# march_madness 🏀

# Contributors
Eirik Andersen, Jason Donohue, Rebecca Moges

## Introduction 

In this project, we use various metrics to predict the winners of the NCAA Men's Basketball Tournament, also known as March Madness. Our goal is to accurately predict which teams are most likely to win each game and ultimately become the tournament champion.

To achieve this goal, we have collected and analyzed a large amount of data on college basketball teams, key player statistics, and various team metrics such as offensive and defensive efficiency.

## Data Dictionary
 
 1.Tournament Data: This dataset contains the teams and their stats for the 2023 season, including their conference tournament.
 
## Data Cleaning 
* Manipulated data to get specific variables of interest to be included in the data frame. Below is varriables that we used
1. Team
2. KENPOM.ADJUSTED.EFFICIENCY 
3. BARTTORVIK.ADJUSTED.EFFICIENCY
4. TURNOVER..
5. POINTS.PER.POSSESSION.DEFENSE
6. FREE.THROW.. 



```
game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE)
```
---

## Data Prep

1. Created a TOTAL.SCORE column using the key stats from the cleaned data

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
 - We did this so we could create a graph that reacts off of the users selections

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
- We choose a bar graph to easily see the difference in the total score between the 2 selected teams

  
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
- We chose to create a table to see the overall winner compared to every other team. This is why we sorted by the highest final score to the lowest. 

``` 
output$table <- DT::renderDataTable(game_data[,c("TEAM","TOTAL.SCORE")],options = list(pageLength = 4))
```

![3DCB5042-61B1-40C0-BAB1-1FA36EFF6572](https://user-images.githubusercontent.com/113206712/227397153-37f2d5af-a6bf-4495-a3a5-220f5312901d.jpeg)
---

4. Chart showing all teams' scores (image only partial, all teams shown in shinyapp)
- We chose to create a bar graph of all the teams total scores to easily see every team compared to the table above. Both images show every teams total score but the bar grapgh makes it easier to see every teams score comapred to the overal winner in the table. 

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

## Model

We didn't get the model to work 100%, so it's not in the R file but here is the code

```
teams <- game_data

# Seeding the teams based on their scores
teams_seeded <- teams %>%
  arrange(desc(TOTAL.SCORE)) %>%
  mutate(seed = row_number())

# Adding a "bye" team if the number of teams is not a power of two
if (nrow(teams_seeded) %% 2 != 0) {
  teams_seeded <- rbind(teams_seeded, data.frame(TEAM = "Bye", TOTAL.SCORE = 0, seed = nrow(teams_seeded) + 1))
}

# Creating the bracket data
round_1 <- data.frame(
  round = 1,
  match = 1:(nrow(teams_seeded)%%32),
  team1 = teams_seeded$TEAM[1:(nrow(teams_seeded)%%32)],
  team2 = teams_seeded$TEAM[((nrow(teams_seeded)%%32) + 1):nrow(teams_seeded)]
)

round_2 <- data.frame(
  round = 2,
  match = 1:(nrow(round_1)/2),
  team1 = ifelse(round_1$match %% 2 == 1, round_1$team1, round_1$team2),
  team2 = ifelse(round_1$match %% 2 == 1, round_1$team2, round_1$team1)
)

round_3 <- data.frame(
  round = 3,
  match = 1:(nrow(round_2)/2),
  team1 = ifelse(round_2$match %% 2 == 1, round_2$team1, round_2$team2),
  team2 = ifelse(round_2$match %% 2 == 1, round_2$team2, round_2$team1)
)

round_4 <- data.frame(
  round = 4,
  match = 1:(nrow(round_3)/2),
  team1 = ifelse(round_3$match %% 2 == 1, round_3$team1, round_3$team2),
  team2 = ifelse(round_3$match %% 2 == 1, round_3$team2, round_3$team1)
)

round_5 <- data.frame(
  round = 5,
  match = 1:(nrow(round_4)/2),
  team1 = ifelse(round_4$match %% 2 == 1, round_4$team1, round_4$team2),
  team2 = ifelse(round_4$match %% 2 == 1, round_4$team2, round_4$team1)
)

championship <- data.frame(
  round = 6,
  match = 1,
  team1 = ifelse(round_5$match %% 2 == 1, round_5$team1, round_5$team2),
  team2 = ifelse(round_5$match %% 2 == 1, round_5$team2, round_5$team1)
)

# Combine all the rounds into one dataframe
bracket_data <- bind_rows(round_1, round_2, round_3, round_4, round_5, championship)

# Create a function to generate the tournament results table
table_results <- function(bracket_data) {
  # Filter the data to only include the final results
  results <- bracket_data %>%
    filter(round == max(round))
  
  if (nrow(results) == 0) {
    return(NULL) # return NULL if no rows match the filtering criteria
  }
  
  # Create a new data frame to hold the results
  winners <- data.frame(
    seed = 1:nrow(results),
    team = ifelse(results$score1 > results$score2, results$team1, results$team2)
  )
  
  # Order the results by seed
  winners <- winners %>%
    arrange(seed)
  
  # Create a flextable with the results
  ft <- flextable(winners)
  
  # Format the table
  ft <- ft %>% 
    set_header_labels("", "Winner") %>% 
    align(align = "center", part = "all") %>% 
    width(width = 1, part = "1") %>% 
    bold(part = "header")
  
  # Return the table
  return(ft)
}
```
