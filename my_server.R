library(ggplot2)
library(plotly)
library(dplyr)

server <- function(input, output) {
  
  output$calcValues <- renderText({
    
    maxco2 <- climate_data %>% filter(year == 2020) %>% filter(co2 == max(co2, na.rm = TRUE)) %>% pull(co2)
    maxPerCap <- climate_data %>% filter(year == 2020) %>% filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% pull(co2_per_capita)
    maxPerCapCountry <- climate_data %>% filter(year == 2020) %>% filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% pull(country)
    minPerCap <- climate_data %>% filter(year == 2020) %>% filter(co2 == min(co2, na.rm = TRUE)) %>% pull(co2)
    minPerCapCountry <- climate_data %>% filter(year == 2020) %>% filter(co2_per_capita == min(co2_per_capita, na.rm = TRUE)) %>% pull(country)
    minco2 <- climate_data %>% filter(country == "World") %>% filter(co2 == min(co2, na.rm = TRUE)) %>% slice_min(1) %>% pull(co2)
    minco2Year <- climate_data %>% filter(country == "World") %>% filter(co2 == min(co2, na.rm = TRUE)) %>% slice_min(1) %>% pull(year)
    
    paragraph <- paste0("Through analyzing the data, the total CO2 emissions from the world in 2020 were ", maxco2, " million tonnes. The country with the highest CO2 emissions per capita in 2020 was ", 
                        maxPerCapCountry, ", with ", maxPerCap, " million tonnes emitted per capita. The country with the lowest CO2 emissions per capita was ", minPerCapCountry, ", with ", minPerCap, 
                        " million tonnes emitted per capita. Finally, the year with the lowest emissions was ", minco2Year, ", with ", minco2, " million tonnes of CO2 emitted.", sep = "")
    return(paragraph)
  })
  
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