library(tidyverse)
library(ggplot2)
library(dplyr)
library(shiny)

game_data <- read.csv("2023_game_data.csv") %>%
  select(TEAM, KENPOM.ADJUSTED.EFFICIENCY,
         BARTTORVIK.ADJUSTED.EFFICIENCY,
         TURNOVER..,POINTS.PER.POSSESSION.DEFENSE) %>%
  distinct(TEAM, .keep_all = TRUE)

game_data$TOTAL.SCORE <- game_data$KENPOM.ADJUSTED.EFFICIENCY *
game_data$BARTTORVIK.ADJUSTED.EFFICIENCY *
game_data$TURNOVER.. / game_data$POINTS.PER.POSSESSION.DEFENSE


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
    
    column(3.5,DT::dataTableOutput("table", width = "100%"))
  )
)

server<-function(input,output){
  
  #matchup <- reactive({
  #  game_data(input$team_1, input$team_2)
  #})
  
  
  #output$plot_01 <- renderPlot({
  #  ggplot(game_data, aes(x=team, y=TOTAL.SCORE, fill=Product))+
   #   geom_col(data = subset(game_data, team == input$team))

  #})
  output$table <- DT::renderDataTable(game_data[,c("TEAM","TOTAL.SCORE")],options = list(pageLength = 4))
}

shinyApp(ui=ui, server=server)
