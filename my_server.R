library(ggplot2)
library(plotly)
library(dplyr)
library(tidyverse)

server <- function(input, output) {
  
  output$calcValues <- renderText({
    
    maxco22020 <- climate_data %>% filter(year == 2020) %>% filter(co2 == max(co2, na.rm = TRUE)) %>% pull(co2)
    maxco2year <- climate_data %>% filter(co2 == max(co2, na.rm = TRUE)) %>% pull(year)
    maxco2 <- climate_data %>% filter(co2 == max(co2, na.rm = TRUE)) %>% pull(co2)
    maxPerCap <- climate_data %>% filter(year == 2020) %>% filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% pull(co2_per_capita)
    maxPerCapCountry <- climate_data %>% filter(year == 2020) %>% filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% pull(country)
    minPerCap <- climate_data %>% filter(year == 2020) %>% filter(co2 == min(co2, na.rm = TRUE)) %>% pull(co2)
    minPerCapCountry <- climate_data %>% filter(year == 2020) %>% filter(co2_per_capita == min(co2_per_capita, na.rm = TRUE)) %>% pull(country)
    minco2 <- climate_data %>% filter(country == "World") %>% filter(co2 == min(co2, na.rm = TRUE)) %>% slice_min(1) %>% pull(co2)
    minco2Year <- climate_data %>% filter(country == "World") %>% filter(co2 == min(co2, na.rm = TRUE)) %>% slice_min(1) %>% pull(year)
    
    paragraph <- paste0("Through analyzing the data, the total CO2 emissions from the world in 2020 were ", maxco22020, " million tonnes. However, ", maxco2year, " was the year with the highest emissions, sitting at ", maxco2, " million tonnes. The country with the highest CO2 emissions per capita in 2020 was ", 
                        maxPerCapCountry, ", with ", maxPerCap, " million tonnes emitted per capita. The country with the lowest CO2 emissions per capita was ", minPerCapCountry, ", with ", minPerCap, 
                        " million tonnes emitted per capita. Finally, the year with the lowest emissions was ", minco2Year, ", with ", minco2, " million tonnes of CO2 emitted.", sep = "")
    return(paragraph)
  })
  
  output$climatePlot <- renderPlotly({

    df <- climate_data %>% filter(year >= 2000) %>% filter(country == input$user_input) %>% rename("CO2 Emissions" = co2, "Year" = year)

    co2plot <- df %>% ggplot(aes(x = Year)) + geom_bar(aes(y = `CO2 Emissions`), stat = "identity", fill = input$color_input) + labs(title = "CO2 Emissions from 2000 to 2020") +
      theme(plot.title = element_text(hjust = 0.5)) + ylab("CO2 Emissions (million tonnes)")

    co2plot <- ggplotly(co2plot)

    return(co2plot)
  })
}
