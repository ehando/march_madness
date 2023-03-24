library(tidyverse)
library(ggplot2)
library(dplyr)
library(shiny)

game_data <- read.csv("2023 Tournament Data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE, FREE.THROW..) %>%
  distinct(TEAM, .keep_all = TRUE)

game_data$TOTAL.SCORE <- game_data$KENPOM.ADJUSTED.EFFICIENCY *
game_data$BARTTORVIK.ADJUSTED.EFFICIENCY *
game_data$TURNOVER.. / game_data$POINTS.PER.POSSESSION.DEFENSE * game_data$FREE.THROW..

game_data <- game_data %>%
  mutate(TOTAL.SCORE = round(TOTAL.SCORE,4))

game_data <- game_data[order(-game_data$TOTAL.SCORE),]


#dynamic shiny
ui<-fluidPage( 
  
  titlePanel(title = "March Madness 2023"),
  h4('Matchup winner'),
  
  fluidRow(
    column(2,
           selectInput('team_1', 'Choose Team 1', game_data$TEAM)),
    column(2,
             selectInput('team_2', 'Choose Team 2', game_data$TEAM)),
    
    column(4,plotOutput('plot_01', width = '700px')),
    
    column(3.5,DT::dataTableOutput("table", width = "100%")),
    
      column(12, plotOutput('plot_02', width = '5000px'))
  )
)


server<-function(input,output){
  
  matchup <- reactive({
    team1 <- game_data[game_data$TEAM == input$team_1, ] 
    team2 <- game_data[game_data$TEAM == input$team_2, ]
  })
  
  # Display team summaries
 
    
  #})

    #game_data(input$team_1, input$team_2)
  #})
  
  output$plot_01 <- renderPlot({
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

  output$table <- DT::renderDataTable(game_data[,c("TEAM","TOTAL.SCORE")],options = list(pageLength = 4))


  output$plot_02 <- renderPlot({
    ggplot(game_data, aes(x = TEAM, y = TOTAL.SCORE)) +
      geom_point(fill = "steelblue") +
      xlab("Team") +
      ylab("Total Score") +
      ggtitle("Total Score by Team")
})

}
  shinyApp(ui=ui, server=server)

  