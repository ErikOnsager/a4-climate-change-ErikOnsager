library(ggplot2)
library(plotly)
library(dplyr)

server <- function(input, output) {

  output$climatePlot <- renderPlotly({

# Allow user to filter by multiple countries
  climate_data <- climate_data %>% filter(country == input$user_category)

    # Make a scatter plot of oil per capita over time by country
    my_plot <- ggplot(data = climate_data) + geom_line(mapping = aes(x = year, y = oil_co2_per_capita, color = country))

    # Make interactive plot
    my_plotly_plot <- ggplotly(my_plot)

    return(my_plotly_plot)
  })
}

?renderText