#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)

duomenys <- read.csv("C:/Users/37067/Documents/lab_sodra.csv") %>%
  filter(ecoActCode == 692000) %>%
  replace(is.na(.), 0)

list1 <- unique(duomenys$code)

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("Apskaitos, buhalterijos ir audito veikla; konsultacijos mokesčių klausimais"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("dat",
                  label = "Įveskite įmonės kodą:",
                  choices = list1,
                  selected = list1[1]
      )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("map"),
      tableOutput("table")
    )
  ))
# Define server logic required to draw a histogram
server <- function(input, output) {
  graf <- reactive({
    duomenys %>% filter(code == input$dat)
  })
  output$map <- renderPlot({
    ggplot(graf(), aes(x=month, y = avgWage, group=name, color=name))+
      geom_line()
  })
  output$table <- renderTable({
    graf()
  })
}
shinyApp(ui = ui, server = server)
