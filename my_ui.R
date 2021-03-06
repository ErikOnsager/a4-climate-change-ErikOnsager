library(ggplot2)
library(plotly)
library(bslib)

climate_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(primary = "#091F43", font_scale = NULL, bootswatch = "cerulean"),
    h1("Introduction"),
    p("In this project, I've chosen to analyze carbon emissions from 2000 to 2020 in my Shiny app to better understand current trends related to global warming and what countries are the largest contributors to it."), ##############################
    h3("Who collected the data?"),
    p("The data was collected by Our World in Data, an online publication that focuses on large problems affecting the world, such as poverty, disease, and climate change."),
    h3("How was the data collected or generated?"),
    p("The data is collected from four main sources: specialized institutes, research articles, international institutions/statistical agencies, and official government sources. 
      Some examples of these sources would be UN institutions, the Peace Research Institute Oslo, and the World Bank."),
    h3("Why was the data collected?"),
    p("The data was collected to make use of preexisting research and data in an accessible way so that it progress can be made on the world's largest problems. A few issues that 
      OWID seeks to solve are paywalls, jargon, and outdated data."),
    h3("What are possible limitations or problems with this data?"),
    p("The data contains many NA values, limiting the conclusions that can be drawn from it. Because of this, I have to be aware of when assumptions are made when cleaning and analyzing the data.
        As a result of being removed from the collection of the data, I need to make sure that I don't suppress voices or exclude key information just to emphasize clarity and cleanliness in my visualizations.
        Finally, the data's country column contains more than just countries - World, Africa, and Asia are all examples of this mislabeling, something I'll have to account for in my analysis."),
    textOutput(outputId = "calcValues")
  )
)

plot_sidebar <- sidebarPanel(
  selectInput("user_input", "Select Region to Plot", choices = climate_data$country),
  textInput("color_input", "Choose a Color (Hexcode)", value = "#55ffcc")
)

plot_main <- mainPanel(
  plotlyOutput(outputId = "climatePlot")
)

plot_tab <- tabPanel(
  "Interactive Visualization",
  sidebarLayout(
    plot_sidebar,
    plot_main
  ),
  p("This chart was included to explore recent trends in CO2 emissions throughout the world. Some patterns that emerged from the chart were: 
    China's CO2 emissions have more than tripled in the past 20 years, going from 3,349 to 10,667 million tonnes. On the other hand, North America's emissions have decreased from 7,107 in 2000 to 5,775 million tonnes in 2020.
    Finally, the world's emissions have mostly increased in the past 20 years, though it saw a decrease from 2019 to 2020, likely due to Coronavirus quarantines reducing individual carbon emissions.")
)

value_tab <- tabPanel(
  "Value Sensitive Design",
  fluidPage(theme = bs_theme(primary = "#091F43", font_scale = NULL, bootswatch = "cerulean"),
    h3("Prompt: Envision your system in use by a single stakeholder. Now imagine 100 such individuals interacting with the system. Then 1,000 individuals. Then 100,000. What new 
       interactions might emerge from widespread use? Find three synergistic benefits of widespread use and three potential breakdowns."),
    p("One benefit of widespread use of my system is that it would show a large population that global CO2 emissions are increasing, spreading awareness of our impact on the environment.
      This could also lead more people to push for aggressive climate goals, as they see that their country is still emitting lots of carbon dioxide into the atmosphere and protest for regulations such as a carbon tax.
      Finally, it would let these stakeholders compare different countries and look at the effects of their climate plans - countries with the greatest negative rate of change may have the most effective regulations.
      On the other hand, widespread use can lead to misinterpretation & spreading of misinformation, as one could see that carbon emissions in the US have decreased in the past 20 years and believe that the US is effectively decreasing emissions, even though its transition to clean energy is going extremely slowly.
      Also, with a large population of stakeholders using the product, some might see countries with increasing CO2 emissions and blame them for climate change, even when they have low CO2 emissions when compared to the rest of the world or less CO2 emissions per capita than other countries.
      Finally, the information presented in the system is limited by not being able to compare countries on the same y-scale, which a small amount of involved stakeholders may want for more in-depth analysis.")
  )
)


ui <- navbarPage(
  "Climate Change",
  intro_tab,
  plot_tab,
  value_tab
)
