library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Roll simulations"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("n",
                  "Number of dice:",
                  min = 1,
                  max = 10,
                  value = 2),
      sliderInput("d",
                  "Die number",
                  min = 2,
                  max = 20,
                  value = 6),
      checkboxInput('drop.lowest',
                    'Drop Lowest Die',
                    value=FALSE),
      checkboxInput('drop.highest',
                    label='Drop Highest Die',
                    value=FALSE)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
