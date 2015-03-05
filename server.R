source('roll_functions.R')

require(shiny)

shinyServer(
    function(input, output) {
        func=c()
        output$distPlot <- renderPlot({
            if(input$drop.highest){
                func <- c(func, drop.highest)
            }
            if(input$drop.lowest){
                func <- c(func, drop.lowest)
            }
            plot.rolls(
                 n=input$n,
                 d=input$d,
                 func
            )
        })
})
