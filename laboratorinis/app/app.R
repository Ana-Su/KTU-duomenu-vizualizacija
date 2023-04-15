#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
duomenys = read.csv("lab_sodra.csv")
duomenys=duomenys %>%
  filter(ecoActCode==692000)
duomenys[is.na(duomenys)] = 0
list1 = as.array(duomenys %>% pull(code))
class(list1)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Apskaitos, buhalterijos ir audito veikla; 
               konsultacijos mokesčių klausimais"),
  
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
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  graf = reactive({
    req(input$dat)
  })
  output$map <- redredPlot({
    ggplot(graf(), aes(x=month, y = avgWage, group=name, color=name))+
      geom_line()
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)